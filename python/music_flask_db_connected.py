from flask import Flask
import pandas as pd
import numpy as np
from transformers import BertTokenizer,TFBertModel
import tensorflow as tf
import pymysql
import os
from apscheduler.schedulers.background import BackgroundScheduler
from datetime import datetime

app = Flask(__name__)

# BERT 토크나이저 로드

tokenizer_kor = BertTokenizer.from_pretrained("klue/bert-base")
bert_kor=TFBertModel.from_pretrained('klue/bert-base')
tokenizer_all = BertTokenizer.from_pretrained('bert-base-multilingual-cased')
bert_model_all = TFBertModel.from_pretrained('bert-base-multilingual-cased')

# 모델 로드
emotion_model = tf.keras.models.load_model('result/modeling/emotion/emotionkr.h5',custom_objects={'TFBertModel':bert_kor})
situation_model = tf.keras.models.load_model('result/modeling/situation/situation2_weights.h5',custom_objects={'TFBertModel':bert_model_all})
time_model = tf.keras.models.load_model('result/modeling/time/time2.h5',custom_objects={'TFBertModel':bert_model_all})
season_model = tf.keras.models.load_model('result/modeling/time/season2.h5',custom_objects={'TFBertModel':bert_model_all})

# 가중치 불러오기
emotion_model.load_weights('result/modeling/emotion/emotionkr_weights')
situation_model.load_weights('result/modeling/situation/situation2_weights')
time_model.load_weights('result/modeling/time/time2_weights')
season_model.load_weights('result/modeling/time/season2_weights')

# MySQL 연결 설정
mysql_connection = pymysql.connect(
    host='',
    user='',
    password='',
    database='',
    port=3307
)
 
def update_data():
    if os.path.exists('new_data.csv'):    
            # 새로운 노래 데이터가 있는 CSV 파일 읽기
        new_data = pd.read_csv('new_data.csv')
        print("new_data")
        new_data["lyrics"] = new_data["lyrics"].str.replace("\n", " ")
        new_data["lyrics"] = new_data["lyrics"].str.replace("\r", " ")
        new_data["lyrics"] = new_data["lyrics"].str.replace("[^a-zA-Z가-힣\s]", "", regex=True)
        new_data[["time", "activity", "emotion"]] = None

        # 가사 길이를 앞부분만 사용하기 위해 100개의 단어까지만 받도록 함
        list1 = []
        for i in range(len(new_data["lyrics"])):
            list1 = list(str(new_data["lyrics"][i]).split(" "))
            list1 = list1[:100]
            new_data["lyrics"][i] = " ".join(list1)

        # 토큰화
        token_all = tokenizer_all(
            text=new_data["lyrics"].tolist(),
            add_special_tokens=True,
            max_length=200,
            truncation=True,
            padding=True,
            return_tensors='tf',
            return_token_type_ids=False,
            return_attention_mask=True,
            verbose=True
        )

        token_kr = tokenizer_kor(
            text=new_data["lyrics"].tolist(),
            add_special_tokens=True,
            max_length=50,
            truncation=True,
            padding=True,
            return_tensors='tf',
            return_token_type_ids=False,
            return_attention_mask=True,
            verbose=True
        )

        # 감정 예측
        emotion_pred = emotion_model.predict(
            {'input_ids': token_kr['input_ids'], 'attention_mask': token_kr['attention_mask']})
        predicted_tags = np.argmax(emotion_pred, axis=1)
        tag_mapping_emo = {0: '분노', 1: '기쁨', 2: '안정', 3: '열정적', 4: '슬픔', 5: '사랑'}
        predicted_tags = [tag_mapping_emo[tag] for tag in predicted_tags]

        # 상황 예측
        situ_pred = situation_model.predict(
            {'input_ids': token_all['input_ids'], 'attention_mask': token_all['attention_mask']})
        predicted_tags2 = np.argmax(situ_pred, axis=1)
        tag_mapping_situ = {0: '차량/운전중', 1: '휴식/수면', 2: '운동/훈련중', 3: '산책/걷는중'}
        predicted_tags2 = [tag_mapping_situ[tag] for tag in predicted_tags2]

        # 시간 예측
        time_pred = time_model.predict(
            {'input_ids': token_all['input_ids'], 'attention_mask': token_all['attention_mask']})
        predicted_tags3 = np.argmax(time_pred, axis=1)
        tag_mapping_time = {0: '아침', 1: '점심', 2: '저녁', 3: '새벽'}
        predicted_tags3 = [tag_mapping_time[tag] for tag in predicted_tags3]

        # 계절 예측
        season_pred = season_model.predict(
            {'input_ids': token_all['input_ids'], 'attention_mask': token_all['attention_mask']})
        predicted_tags4 = np.argmax(season_pred, axis=1)
        tag_mapping_seas = {0: '봄', 1: '여름', 2: '가을', 3: '겨울'}
        predicted_tags4 = [tag_mapping_seas[tag] for tag in predicted_tags4]

        # 계절_시간으로 변환
        combined_predictions = [f"{season}_{time}" for season, time in zip(predicted_tags4, predicted_tags3)]

        # 태그 반환
        new_data["time"] = combined_predictions
        new_data["activity"] = predicted_tags2
        new_data["emotion"] = predicted_tags
        
        print(new_data)
        # MySQL에 데이터 삽입
        insert_data_to_mysql(new_data)
        
        os.remove('new_data.csv')
        return '데이터 업데이트 완료!'
    else:
        return 'new_data.csv 파일이 존재하지 않습니다. 작업을 스킵합니다.'

def insert_data_to_mysql(data):
    cursor = mysql_connection.cursor()

    for _, row in data.iterrows():
        # 여기서 각 열의 데이터를 MySQL에 넣는 쿼리를 작성하세요.
        # 예를 들어, 아래와 같은 형태로 데이터를 삽입할 수 있습니다.
        query = f"INSERT INTO MUSIC (music_index,album_index,singer_index,singer,song,album,lyrics,genre,music_titme,album_released,time,activity,emotion) VALUES ({row['music_index']},{row['album_index']}, {row['singer_index']},'{row['singer']}','{row['song']}','{row['album']}','{row['lyrics']}','{row['genre']}',{row['music_titme']},'{row['album_released']}','{row['time']}','{row['activity']}','{row['emotion']}')"
        cursor.execute(query)
    cursor.close()
    mysql_connection.commit()

if __name__ == '__main__':
    # 스케줄러 객체 생성
    scheduler = BackgroundScheduler()
    # update_data() 함수를 매 시간 0시마다 실행하도록 스케줄링
    trigger = CronTrigger(hour="0")
    scheduler.add_job(update_data, trigger)
    # 스케줄러 시작
    scheduler.start()
    app.run(debug=True)
