from flask import Flask, render_template
import pandas as pd
from transformers import BertTokenizer
from tensorflow.keras.models import load_model
import os
app = Flask(__name__)

# BERT 토크나이저 로드
tokenizer_kor = BertTokenizer.from_pretrained('klue_bert_base')
tokenizer_all= BertTokenizer.from_pretrained("bert-base-multilingual-cased")

# 모델 로드
emotion_model = load_model('./model/emotion/emotionkr.h5', custom_objects={'TFBertModel': tokenizer_kor})
situation_model = load_model('./model/situation/situation2_weights.h5', custom_objects={'TFBertModel': tokenizer_all})
time_model = load_model('./model/time/time2.h5', custom_objects={'TFBertModel': tokenizer_all})
#가중치 불러오기
emotion_model.load_weights('./model/emotion/emotionkr_weights')
situation_model.load_weights('./model/situation/situation2_weights')
time_model.load_weights('./model/time/time2_weights')

@app.route('/')# 요청시 루트 당기기 
def update_data():
    if os.path.exists('new_data.csv'):    
        # 기존의 곡 데  이터가 있는 CSV 파일 읽기
        existing_data = pd.read_csv('414곡_예측결과.csv')

        # 새로운 노래 데이터가 있는 CSV 파일 읽기
        new_data = pd.read_csv('new_data.csv')
        new_data["lyrics"]=new_data["lyrics"].str.replace("\n"," ")
        new_data["lyrics"]=new_data["lyrics"].str.replace("\r"," ")
        new_data["lyrics"] = new_data["lyrics"].str.replace("[^a-zA-Z가-힣\s]", "", regex=True)
        new_data[["time","activity","emotion"]]=None
        # 가사길이를 앞부분만사용하기위해 100개의 단어까지만 받도록함
        list1=[]
        for i in range (len(new_data["lyrics"])):
            list1=list(str(new_data["lyrics"][i]).split(" "))
            list1= list1[:100]
            new_data["lyrics"][i]=" ".join(list1)
        # 토큰화
        token_all=tokenizer_all(
            text=new_data["lyrics"].tolist(),
            add_special_tokens=True,
            max_length=200,
            truncation=True,
            padding=True, 
            return_tensors='tf',
            return_token_type_ids = False,
            return_attention_mask = True,
            verbose = True)

        token_kr=tokenizer_kor(
            text=new_data["lyrics"].tolist(),
            add_special_tokens=True,
            max_length=50,
            truncation=True,
            padding=True, 
            return_tensors='tf',
            return_token_type_ids = False,
            return_attention_mask = True,
            verbose = True)
        # 감정 예측
        emotion_pred = emotion.predict(
        {'input_ids':token_kr['input_ids'],'attention_mask':token_kr['attention_mask']})
        predicted_tags = np.argmax(emotion_pred, axis=1)
        tag_mapping_emo = {0: '분노', 1: '기쁨', 2: '안정', 3: '열정적', 4: '슬픔', 5: '사랑'}
        predicted_tags = [tag_mapping_emo[tag] for tag in predicted_tags]

        #상황 예측
        situ_pred = situation.predict(
        {'input_ids':token_all['input_ids'],'attention_mask':token_all['attention_mask']})
        predicted_tags2 = np.argmax(situ_pred , axis=1)
        tag_mapping_situ = {0: '차량/운전중', 1: '휴식/수면', 2: '운동/훈련중', 3: '산책/걷는중'}
        predicted_tags2 = [tag_mapping_situ[tag] for tag in predicted_tags2]
        # 시간예측
        time_pred = times.predict(
        {'input_ids':token_all['input_ids'],'attention_mask':token_all['attention_mask']})
        predicted_tags3 = np.argmax(time_pred, axis=1)
        tag_mapping_time = {0: '아침', 1: '점심', 2: '저녁', 3: '새벽'}
        predicted_tags3 = [tag_mapping_time[tag] for tag in predicted_tags3]

        #계절예측
        season_pred = season.predict(
        {'input_ids':token_all['input_ids'],'attention_mask':token_all['attention_mask']})
        predicted_tags4 = np.argmax(season_pred, axis=1)
        tag_mapping_seas = {0: '봄', 1: '여름', 2: '가을', 3: '겨울'}
        predicted_tags4 = [tag_mapping_seas[tag] for tag in predicted_tags4]

        # 계절_시간으로 변환
        combined_predictions = [f"{season}_{time}" for season, time in zip(predicted_tags4, predicted_tags3)]
        # 태그 반환
        new_data["time"]=combined_predictions
        new_data["activity"]=predicted_tags2
        new_data["emotion"]=predicted_tags
        # 기존 데이터에 추가
        existing_data = existing_data.append(new_data, ignore_index=True)

        # 결과를 업데이트된 CSV 파일로 저장
        existing_data.to_csv('existing_data.csv', index=False)
        os.remove('new_data.csv')
        return '데이터 업데이트 완료!'
    else: 
        return 'new_data.csv 파일이 존재하지 않습니다. 작업을 스킵합니다.'
    

if __name__ == '__main__':
    app.run(debug=True)
