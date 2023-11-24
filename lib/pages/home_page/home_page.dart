import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/cubit/app_cubit_states.dart';
import 'package:flutter_test_project/cubit/app_cubits.dart';
import 'package:flutter_test_project/models/data_model.dart';
import 'package:flutter_test_project/pages/home_page/widgets/homepage_place_recommended_play_list.dart';
import 'package:flutter_test_project/pages/home_page/widgets/homepage_title.dart';
import 'package:flutter_test_project/pages/home_page/widgets/homepage_environment_recommended_playlist.dart';
import 'package:flutter_test_project/pages/home_page/widgets/homepage_playback_history.dart';
import 'package:flutter_test_project/pages/home_page/widgets/homepage_emotion_recommended_playlist.dart';
import 'package:flutter_test_project/pages/home_page/widgets/homepage_user_custom_music_list.dart';
import 'package:flutter_test_project/pages/rank_page/rank_page_widgets/rank_page_category.dart';
import 'package:flutter_test_project/pages/rank_page/rank_page_widgets/rank_page_new_album_list.dart';
import 'package:flutter_test_project/pages/rank_page/rank_page_widgets/rank_page_rank_list.dart';
import 'package:flutter_test_project/pages/rank_page/rank_page_widgets/rank_page_title_text.dart';
import 'package:flutter_test_project/pages/rank_page/rank_page_widgets/rank_page_top_button.dart';
import 'package:flutter_test_project/widgets/app_our_bar.dart';
import 'package:flutter_test_project/widgets/app_our_list_bar.dart';
import 'package:flutter_test_project/widgets/background_concept_color.dart';
import 'package:flutter_test_project/widgets/background_concept_img.dart';
import 'package:flutter_test_project/widgets/music_list_big_size_widget.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController; // _tabController를 필드로 선언

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // initState에서 초기화
  }

  @override
  void dispose() {
    _tabController.dispose(); // _tabController를 dispose 메서드에서 해제
    super.dispose();
  }

  final List<String> images = [
    "jan_hon.jpeg",
    "jan_le.jpeg",
    "jan_monkey.jpeg",
    "jan_so.jpeg",
    "jan_so2.jpeg",
    "jan_monkey.jpeg",
    "jan_so.jpeg",
    "jan_hon.jpeg",
    "jan_le.jpeg",
    "jan_monkey.jpeg",
    "jan_so.jpeg",
    "jan_so2.jpeg",
    "jan_monkey.jpeg",
    "jan_so.jpeg",
  ];
  final List<String> titles = [
    "환상의나라",
    "전설",
    "몽키",
    "소곡집1",
    "소곡집2",
    "몽키",
    "소곡집2",
    "환상의나라",
    "전설",
    "몽키",
    "소곡집1",
    "소곡집2",
    "몽키",
    "소곡집2"
  ];
  final List<String> menu = [
    "휴식",
    "행복한 기분",
    "에너지 충전",
    "집중",
    "운동",
    "출퇴근길",
    "로멘스",
    "슬픔",
    "파티",
    "잠잘 때"
  ];
  final List<String> userimg = [
    "userlist1.png",
    "userlist2.png",
    "userlist3.png",
    "userlist4.png",
    "userlist5.png"
  ];

  String? currentImagePath; // 초기 이미지 경로
  String? selectedMenu; // 현재 선택된 메뉴 추적

  void _handleMenuSelection(String menu) {
    setState(() {
      if (selectedMenu == menu) {
        // 이미 선택된 메뉴를 다시 클릭한 경우
        currentImagePath = null; // 이미지 경로를 null로 설정하여 검은색 배경 표시
        selectedMenu = null; // 선택된 메뉴 상태도 초기화
      } else {
        // 새로운 메뉴를 선택한 경우
        currentImagePath = "assets/bgimg/${menu}.jpeg"; // 새 이미지 경로 설정
        selectedMenu = menu; // 선택된 메뉴 상태 업데이트
      }
    });
  }

  Color backgroundColor = Colors.black.withOpacity(0);

  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification.metrics.axis == Axis.vertical) {
            // 여기서는 세로 스크롤 알림에만 반응합니다.
            final double scrollPosition = notification.metrics.pixels;
            double opacity = (scrollPosition / 100).clamp(0, 1);
            setState(() {
              backgroundColor = Colors.black.withOpacity(opacity);
            });
          }
          return true;
        },
        child: Stack(children: [
          BackgroundConceptImg(imagePath: currentImagePath),
          BackgroundConceptColor(backgroundColor: backgroundColor),
          CustomScrollView(slivers: <Widget>[
            OurAppBar(backgroundColor: backgroundColor),
            OurAppListBar(
                menu: menu,
                backgroundColor: backgroundColor,
                onMenuSelected: _handleMenuSelection),
            SliverToBoxAdapter(
              child: SizedBox(
                // height: MediaQuery.of(context).size.height,
                // height: 1600,
                width: MediaQuery.of(context).size.width,
                child: BlocBuilder<AppCubits, CubitStates>(
                  builder: (context, state) {
                    if (state is LoadedState) {
                      var info = state.places;
                      var infomation = state.lastResponse;

                      print("  최종적으로 도착해야할 곳1 :   $info");
                      print("  최종적으로 도착해야할 곳1 :   $infomation");
                      print(info[1].name);
                      print(infomation.user.played[0].song);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // 페이지의 내용은 여기 있음
                        children: [
                          if (selectedMenu == "휴식")
                            Column(
                              children: [
                                MusicListBigSizePlay(
                                  listTitle: "집에서 쉴 때",
                                  listContents:
                                      "오늘은 뭔가 한가한 하루, 집에서 아늑할 때 듣기에 차분한 노래들로 준비해 보았어요.",
                                ),
                                SizeBoxH20(),
                                RankPageTitleText(
                                  text: "맞춤 뮤직 스테이션",
                                ),
                                SizeBoxH30(),
                                RankPageNewAlbumList(
                                    userimg: userimg, info: info),
                              ],
                            ),
                          if (selectedMenu == "행복한 기분")
                            Column(
                              children: [
                                MusicListBigSizePlay(),
                                SizeBoxH20(),
                                RankPageTitleText(
                                  text: "맞춤 뮤직 스테이션",
                                ),
                                SizeBoxH30(),
                                RankPageNewAlbumList(
                                    userimg: userimg, info: info),
                              ],
                            ),
                          if (selectedMenu == "에너지 충전")
                            Column(
                              children: [
                                MusicListBigSizePlay(),
                                SizeBoxH20(),
                                RankPageTitleText(
                                  text: "맞춤 뮤직 스테이션",
                                ),
                                SizeBoxH30(),
                                RankPageNewAlbumList(
                                    userimg: userimg, info: info),
                              ],
                            ),
                          if (selectedMenu == "집중")
                            Column(
                              children: [
                                MusicListBigSizePlay(),
                                SizeBoxH20(),
                                RankPageTitleText(
                                  text: "맞춤 뮤직 스테이션",
                                ),
                                SizeBoxH30(),
                                RankPageNewAlbumList(
                                    userimg: userimg, info: info),
                              ],
                            ),
                          if (selectedMenu == "운동")
                            Column(
                              children: [
                                MusicListBigSizePlay(),
                                SizeBoxH20(),
                                RankPageTitleText(
                                  text: "맞춤 뮤직 스테이션",
                                ),
                                SizeBoxH30(),
                                RankPageNewAlbumList(
                                    userimg: userimg, info: info),
                              ],
                            ),
                          if (selectedMenu == "슬픔")
                            Column(
                              children: [
                                MusicListBigSizePlay(),
                                SizeBoxH20(),
                                RankPageTitleText(
                                  text: "맞춤 뮤직 스테이션",
                                ),
                                SizeBoxH30(),
                                RankPageNewAlbumList(
                                    userimg: userimg, info: info),
                              ],
                            ),
                          if (selectedMenu == "출퇴근길")
                            Column(
                              children: [
                                MusicListBigSizePlay(),
                                SizeBoxH20(),
                                RankPageTitleText(
                                  text: "맞춤 뮤직 스테이션",
                                ),
                                SizeBoxH30(),
                                RankPageNewAlbumList(
                                    userimg: userimg, info: info),
                              ],
                            ),
                          if (selectedMenu == "로멘스")
                            Column(
                              children: [
                                MusicListBigSizePlay(),
                                SizeBoxH20(),
                                RankPageTitleText(
                                  text: "맞춤 뮤직 스테이션",
                                ),
                                SizeBoxH30(),
                                RankPageNewAlbumList(
                                    userimg: userimg, info: info),
                              ],
                            ),
                          if (selectedMenu == "파티")
                            Column(
                              children: [
                                MusicListBigSizePlay(),
                                SizeBoxH20(),
                                RankPageTitleText(
                                  text: "맞춤 뮤직 스테이션",
                                ),
                                SizeBoxH30(),
                                RankPageNewAlbumList(
                                    userimg: userimg, info: info),
                              ],
                            ),
                          if (selectedMenu == "잠잘 때")
                            Column(
                              children: [
                                MusicListBigSizePlay(),
                                SizeBoxH20(),
                                RankPageTitleText(
                                  text: "맞춤 뮤직 스테이션",
                                ),
                                SizeBoxH30(),
                                RankPageNewAlbumList(
                                    userimg: userimg, info: info),
                              ],
                            ),

                          // "타이틀"(widget)
                          const SizeBoxH30(),
                          const HomePageMainTitle(text: "MUSIC 추천 리스트"),
                          const SizeBoxH15(),

                          // 신곡 추천 리스트 나열 됨.
                          // TabBar
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TabBar(
                              labelPadding:
                                  const EdgeInsets.only(left: 15, right: 0),
                              controller: _tabController,
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.white60,
                              isScrollable: true,
                              indicatorSize: TabBarIndicatorSize.label,
                              labelStyle: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ),
                              indicator: CircleTabIndicator(
                                  color: Colors.white, radius: 5),
                              tabs: const [
                                Tab(text: "PLACE"),
                                Tab(text: "ENVIRONMENT"),
                                Tab(text: "EMOTION"),
                              ],
                            ),
                          ),
                          const SizeBoxH15(),

                          // 추천 리스트를 담은 박스
                          Container(
                            padding: const EdgeInsets.only(left: 15),
                            height: 200,
                            width: double.maxFinite,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                // 장소 기반의 추천 리스트(widget)
                                PlaceRecommendedPlaylist(info: info),

                                // 상황 기반의 추천 리스트(widget)
                                EnvironmentRecommendedPlaylist(info: info),

                                // 감성 기반의 추천 리스트(widget)
                                EmotionRecommendedPlaylist(info: info)
                              ],
                            ),
                          ),
                          const SizeBoxH40(),

                          // "내가 들은 노래 리스트"를 나열 해준다. (widget)
                          const HomePageSubTitleAndIcon(text: '재생 목록'),
                          const SizeBoxH25(),

                          // 재생되었던 목록을 만들었습니다.
                          PlayBackHistory(
                            info: info,
                            images: images,
                            titles: titles,
                          ),
                          const SizeBoxH40(),

                          // "유저가 만든 리스트"를 나열해준다. (widget)
                          const HomePageSubTitleAndIcon(text: "유저가 만든 리스트"),
                          const SizeBoxH25(),
                          UserCustomMusicList(info: info),

                          const SizeBoxH40(),
                          const RankPageTitleText(
                            text: "분위기 및 장르",
                          ),

                          const SizeBoxH20(),
                          CategoryList(),

                          const SizeBoxH40(),
                          const RankPageTitleText(
                            text: "둘러보기",
                          ),

                          const SizeBoxH20(),
                          Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: RankPageTopButton(
                                  text: "최신음악",
                                  icon: Icons.brightness_5,
                                )),
                                Expanded(
                                    child: RankPageTopButton(
                                  text: "차트",
                                  icon: Icons.trending_up,
                                )),
                                Expanded(
                                    child: RankPageTopButton(
                                  text: "최신 음악",
                                  icon: Icons.sentiment_very_satisfied_rounded,
                                )),
                              ],
                            ),
                          ),
                          const SizeBoxH40(),
                          const SizeBoxH40(),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}

// indicator를 디자인을 커스텀하기 위한 클래스를 선언했다. - 이찬용

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);

    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
