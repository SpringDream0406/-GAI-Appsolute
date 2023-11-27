import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/data_model.dart';
import 'package:flutter_test_project/models/test_model.dart';
import 'package:flutter_test_project/pages/rank_page/rank_page_widgets/rank_page_new_album_list.dart';
import 'package:flutter_test_project/pages/rank_page/rank_page_widgets/rank_page_title_text.dart';
import 'package:flutter_test_project/widgets/music_list_big_size_widget.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';

class MenuContentBuilder {
  static Widget buildMenuContent(String? selectedMenu, List<TestModel> Info,
      Recommend recommend, List<String> userimg) {
    if (selectedMenu == "휴식") {
      return RelaxMenuWidget(
          playList: recommend.activity, userimg: userimg, info: Info);
    } else if (selectedMenu == "행복한 기분") {
      return HappyFeelingMenuWidget(
          playList: recommend.emotion, userimg: userimg, info: Info);
    } else if (selectedMenu == "에너지 충전") {
      return EnergyBoostMenuWidget(
          playList: recommend.activity, userimg: userimg, info: Info);
    } else if (selectedMenu == "집중") {
      return FocusMenuWidget(
          playList: recommend.emotion, userimg: userimg, info: Info);
    } else if (selectedMenu == "운동") {
      return ExerciseMenuWidget(
          playList: recommend.activity, userimg: userimg, info: Info);
    } else if (selectedMenu == "출퇴근길") {
      return CommuteMenuWidget(
          playList: recommend.emotion, userimg: userimg, info: Info);
    } else if (selectedMenu == "로멘스") {
      return RomanceMenuWidget(
          playList: recommend.activity, userimg: userimg, info: Info);
    } else if (selectedMenu == "슬픔") {
      return SadnessMenuWidget(
          playList: recommend.activity, userimg: userimg, info: Info);
    } else if (selectedMenu == "파티") {
      return PartyMenuWidget(
          playList: recommend.emotion, userimg: userimg, info: Info);
    } else if (selectedMenu == "잠잘 때") {
      return SleepMenuWidget(
          playList: recommend.time, userimg: userimg, info: Info);
    } else {
      return Container(); // 선택된 메뉴가 없을 때의 기본 위젯
    }
  }
}

// '휴식' 메뉴 위젯
class RelaxMenuWidget extends StatelessWidget {
  final List<Activity> playList;
  final List<String> userimg;
  final List<TestModel> info;

  RelaxMenuWidget({
    Key? key,
    required this.playList,
    required this.userimg,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MusicListBigSizePlay(
          playList: playList,
          listTitle: "집에서 쉴 때",
          listContents: "오늘은 뭔가 한가한 하루, 집에서 아늑할 때 듣기에 차분한 노래들로 준비해 보았어요.",
        ),
        SizeBoxH20(),
        RankPageTitleText(text: "맞춤 뮤직 스테이션"),
        SizeBoxH30(),
        RankPageNewAlbumList(
          userimg: userimg,
          info: info,
          playList: playList,
        ),
      ],
    );
  }
}

// '행복한 기분' 메뉴 위젯
class HappyFeelingMenuWidget extends StatelessWidget {
  final List<Activity> playList;
  final List<String> userimg;
  final List<TestModel> info;

  HappyFeelingMenuWidget({
    Key? key,
    required this.playList,
    required this.userimg,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MusicListBigSizePlay(
          playList: playList,
          listTitle: "행복한 기분일 때",
          listContents: "기분 좋은 날, 에너지 넘치는 노래들로 기분을 더욱 상쾌하게!",
        ),
        SizeBoxH20(),
        RankPageTitleText(text: "맞춤 뮤직 스테이션"),
        SizeBoxH30(),
        RankPageNewAlbumList(userimg: userimg, info: info, playList: playList),
      ],
    );
  }
}

// '에너지 충전' 메뉴 위젯
class EnergyBoostMenuWidget extends StatelessWidget {
  final List<Activity> playList;
  final List<String> userimg;
  final List<TestModel> info;

  EnergyBoostMenuWidget({
    Key? key,
    required this.playList,
    required this.userimg,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MusicListBigSizePlay(
          playList: playList,
          listTitle: "에너지 충전",
          listContents: "활력이 필요할 때, 에너지를 북돋워줄 노래들을 모았습니다.",
        ),
        SizeBoxH20(),
        RankPageTitleText(text: "맞춤 뮤직 스테이션"),
        SizeBoxH30(),
        RankPageNewAlbumList(userimg: userimg, info: info, playList: playList),
      ],
    );
  }
}

// '집중' 메뉴 위젯
class FocusMenuWidget extends StatelessWidget {
  final List<Activity> playList;
  final List<String> userimg;
  final List<TestModel> info;

  FocusMenuWidget({
    Key? key,
    required this.playList,
    required this.userimg,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MusicListBigSizePlay(
          playList: playList,
          listTitle: "집중",
          listContents: "집중이 필요할 때, 마음을 진정시키고 집중력을 높여줄 음악들입니다.",
        ),
        SizeBoxH20(),
        RankPageTitleText(text: "맞춤 뮤직 스테이션"),
        SizeBoxH30(),
        RankPageNewAlbumList(userimg: userimg, info: info, playList: playList),
      ],
    );
  }
}

// '운동' 메뉴 위젯
class ExerciseMenuWidget extends StatelessWidget {
  final List<Activity> playList;
  final List<String> userimg;
  final List<TestModel> info;

  ExerciseMenuWidget({
    Key? key,
    required this.playList,
    required this.userimg,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MusicListBigSizePlay(
          playList: playList,
          listTitle: "운동",
          listContents: "운동할 때 듣기 좋은 역동적이고 활력 넘치는 노래들입니다.",
        ),
        SizeBoxH20(),
        RankPageTitleText(text: "맞춤 뮤직 스테이션"),
        SizeBoxH30(),
        RankPageNewAlbumList(userimg: userimg, info: info, playList: playList),
      ],
    );
  }
}

// '출퇴근길' 메뉴 위젯
class CommuteMenuWidget extends StatelessWidget {
  final List<Activity> playList;
  final List<String> userimg;
  final List<TestModel> info;

  CommuteMenuWidget({
    Key? key,
    required this.playList,
    required this.userimg,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MusicListBigSizePlay(
          playList: playList,
          listTitle: "출퇴근길",
          listContents: "매일의 출퇴근길, 여러분을 위한 여유로운 노래들로 준비했습니다.",
        ),
        SizeBoxH20(),
        RankPageTitleText(text: "맞춤 뮤직 스테이션"),
        SizeBoxH30(),
        RankPageNewAlbumList(userimg: userimg, info: info, playList: playList),
      ],
    );
  }
}

// '로멘스' 메뉴 위젯
class RomanceMenuWidget extends StatelessWidget {
  final List<Activity> playList;
  final List<String> userimg;
  final List<TestModel> info;

  RomanceMenuWidget({
    Key? key,
    required this.playList,
    required this.userimg,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MusicListBigSizePlay(
          playList: playList,
          listTitle: "로멘스",
          listContents: "사랑과 로맨스를 느낄 수 있는 달콤한 멜로디의 곡들입니다.",
        ),
        SizeBoxH20(),
        RankPageTitleText(text: "맞춤 뮤직 스테이션"),
        SizeBoxH30(),
        RankPageNewAlbumList(userimg: userimg, info: info, playList: playList),
      ],
    );
  }
}

// '슬픔' 메뉴 위젯
class SadnessMenuWidget extends StatelessWidget {
  final List<Activity> playList;
  final List<String> userimg;
  final List<TestModel> info;

  SadnessMenuWidget({
    Key? key,
    required this.playList,
    required this.userimg,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MusicListBigSizePlay(
          playList: playList,
          listTitle: "슬픔",
          listContents: "마음이 아플 때, 위로가 되는 곡들로 마음을 달래보세요.",
        ),
        SizeBoxH20(),
        RankPageTitleText(text: "맞춤 뮤직 스테이션"),
        SizeBoxH30(),
        RankPageNewAlbumList(userimg: userimg, info: info, playList: playList),
      ],
    );
  }
}

// '파티' 메뉴 위젯
class PartyMenuWidget extends StatelessWidget {
  final List<Activity> playList;
  final List<String> userimg;
  final List<TestModel> info;

  PartyMenuWidget({
    Key? key,
    required this.playList,
    required this.userimg,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MusicListBigSizePlay(
          playList: playList,
          listTitle: "파티",
          listContents: "분위기를 띄울 파티 시간! 신나는 노래들로 즐겁게!",
        ),
        SizeBoxH20(),
        RankPageTitleText(text: "맞춤 뮤직 스테이션"),
        SizeBoxH30(),
        RankPageNewAlbumList(userimg: userimg, info: info, playList: playList),
      ],
    );
  }
}

// '잠잘 때' 메뉴 위젯
class SleepMenuWidget extends StatelessWidget {
  final List<Activity> playList;
  final List<String> userimg;
  final List<TestModel> info;

  SleepMenuWidget({
    Key? key,
    required this.playList,
    required this.userimg,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MusicListBigSizePlay(
          playList: playList,
          listTitle: "잠잘 때",
          listContents: "평온한 밤, 숙면을 도와줄 부드럽고 차분한 음악들입니다.",
        ),
        SizeBoxH20(),
        RankPageTitleText(text: "맞춤 뮤직 스테이션"),
        SizeBoxH30(),
        RankPageNewAlbumList(userimg: userimg, info: info, playList: playList),
      ],
    );
  }
}
