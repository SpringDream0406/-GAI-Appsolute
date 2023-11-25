import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/cubit/app_cubit_states.dart';
import 'package:flutter_test_project/cubit/app_cubits.dart';
import 'package:flutter_test_project/pages/rank_page/rank_page_widgets/rank_page_category.dart';
import 'package:flutter_test_project/pages/rank_page/rank_page_widgets/rank_page_new_album_list.dart';
import 'package:flutter_test_project/pages/rank_page/rank_page_widgets/rank_page_rank_list.dart';
import 'package:flutter_test_project/pages/rank_page/rank_page_widgets/rank_page_title_text.dart';
import 'package:flutter_test_project/pages/rank_page/rank_page_widgets/rank_page_top_button.dart';
import 'package:flutter_test_project/widgets/app_large_text.dart';
import 'package:flutter_test_project/widgets/app_our_bar.dart';
import 'package:flutter_test_project/widgets/app_text.dart';
import 'package:flutter_test_project/widgets/background_concept_color.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';

class RankPage extends StatefulWidget {
  const RankPage({super.key});

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  final List<String> userimg = [
    "userlist1.png",
    "userlist2.png",
    "userlist3.png",
    "userlist4.png",
    "userlist5.png"
  ];
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
  final List<String> title = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[900],
      body: Stack(children: [
        BackgroundConceptColor(),
        CustomScrollView(slivers: <Widget>[
          OurAppBar(),
          SliverToBoxAdapter(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: BlocBuilder<AppCubits, CubitStates>(
                builder: (context, state) {
                  if (state is LoadedState) {
                    var info = state.places;
                    var infomation = state.lastResponse;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizeBoxH30(),
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
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

                        SizeBoxH20(),

                        // 새 앨범 및 싱글 타이틀이 들어갑니다.
                        RankPageTitleText(
                          text: "새 앨범 및 싱글",
                        ),
                        SizeBoxH20(),

                        // 새 앨범 및 싱글 리스트뷰가 들어갑니다.
                        RankPageNewAlbumList(userimg: userimg, info: info),
                        SizeBoxH20(),

                        // 인기곡 타이틀이 들어갑니다.
                        RankPageTitleText(
                          text: "인기곡",
                        ),
                        SizeBoxH20(),

                        // 인기순위가 들어갑니다. 상승하락중, 등수, 앨범자켓, 노래 타이틀, 가수, 설정,
                        RankPageRankList(
                            images: images,
                            titles: title,
                            info: info,
                            userPlayed: infomation.user.liked),

                        SizeBoxH20(),
                        RankPageTitleText(
                          text: "분위기 및 장르",
                        ),
                        SizeBoxH20(),
                        CategoryList(),
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
    );
  }
}
