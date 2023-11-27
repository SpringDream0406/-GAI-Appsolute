import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/globals/globals.dart';
import 'package:flutter_test_project/models/data_model.dart';
import 'package:flutter_test_project/models/test_model.dart';
import 'package:flutter_test_project/pages/music_list_page/cubit/music_list_page_info_cubits.dart';
import 'package:flutter_test_project/pages/music_list_page/widgets/music_list_add_button.dart';
import 'package:flutter_test_project/pages/music_list_page/widgets/music_list_page_background.dart';
import 'package:flutter_test_project/pages/music_list_page/widgets/music_list_page_top_bar.dart';
import 'package:flutter_test_project/pages/music_list_page/widgets/music_list_page_play_button.dart';
import 'package:flutter_test_project/widgets/app_large_text.dart';
import 'package:flutter_test_project/widgets/app_text.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';

class MusicListPage extends StatefulWidget {
  final TestModel info;
  final List<Activity> playList;
  const MusicListPage({super.key, required this.info, required this.playList});

  @override
  State<MusicListPage> createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  // 스크롤 이동을 주기위한 코드입니다.
  late ScrollController _musiclistcontroller = ScrollController();

  @override
  void initState() {
    super.initState();
    _musiclistcontroller = ScrollController(); // initState에서 초기화
  }

  @override
  void dispose() {
    _musiclistcontroller.dispose(); // _tabController를 dispose 메서드에서 해제
    super.dispose();
  }

  // 스크롤 이동을 주기위한 코드입니다.-- 여기까지입니다.
  int selectedIndex = -1;
  Color? color = Colors.white70;

  // 별점의 숫자가 들어갈 공간
  int gottenStars = 5;

  @override
  Widget build(BuildContext context) {
    var list = BlocProvider.of<MusicListPageInfoCubits>(context).state;
    //
    // MusicListPage detail = state as MusicListPage;

    print('정보의 길이${list.length}');

    for (int i = 0; i < list.length; i++) {
      if (list[i].name == widget.info.name) {
        selectedIndex = list[i].index!;
        color = list[i].color;
      }
    }

    return Scaffold(
      body: Container(
          color: Colors.black,
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
            children: [
              // 상단의 이미지 (widget)
              MusicListBackground(),

              // 상단의 메뉴 (widget)
              MusicListPageTopBar(),

              // 하단의 출력 공간
              Positioned(
                  top: 310,
                  child: Container(
                    padding: EdgeInsets.only(left: 20, top: 30, right: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 700,
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(
                      // 하단의 내용이 들어 있다.- 이찬용
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AppLargeText(
                              text: "출근길 추천 노래",
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizeBoxH10(),
                        SizeBoxH20(),
                        // 별 평점이 담긴 곳
                        Row(
                          children: [
                            Wrap(
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  color: index < gottenStars
                                      ? Colors.orangeAccent
                                      : Colors.grey,
                                );
                              }),
                            ),
                            SizeBoxW10(),
                            AppText(
                              text: "(5.0)",
                              color: Colors.white70,
                            ),
                          ],
                        ),
                        SizeBoxH20(),
                        // 노래 리스트가 담긴 곳
                        Container(
                          height: 240,
                          width: double.maxFinite,
                          child: ListView.builder(
                              controller: _musiclistcontroller,
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemCount: widget.playList.length,
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                  onTap: () {
                                    var data = widget.info;
                                    var list = BlocProvider.of<
                                            MusicListPageInfoCubits>(context)
                                        .state;

                                    for (int i = 0; i < list.length; i++) {
                                      if (list[i].name == data.name) {
                                        if (list[i].index == index) {
                                          print('안녕 인덱스 ${selectedIndex}');
                                        } else {
                                          print('안녕 새로운 인덱스 $index');
                                          BlocProvider.of<
                                                      MusicListPageInfoCubits>(
                                                  context)
                                              .updatePageInfo(widget.info.name,
                                                  index, color);
                                          selectedIndex = index;
                                        }
                                      }
                                    }

                                    if (selectedIndex == -1) {
                                      // 이 버튼, 즉 앨범을 누를 떄, 정보가 넘어갑니다. 이것은요, 이 페이지 안에서 체크 되는 것을 저장하기 위한 것입니다.
                                      BlocProvider.of<MusicListPageInfoCubits>(
                                              context)
                                          .addPageInfo(
                                              widget.info.name, index, color);
                                    }

                                    setState(() {
                                      selectedIndex = index;
                                    });

                                    // 음악을 누르면 스크롤이 거기로 이동함. 아시죠?
                                    _musiclistcontroller.animateTo(index * 60.0,
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeInOut);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 55,
                                          height: 55,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.white,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      "${GlobalConfig.apiEndpoint}/img/album/" +
                                                          widget.playList[index]
                                                              .albumIndex
                                                              .toString() +
                                                          ".jpg"),
                                                  fit: BoxFit.cover)),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        // 여기에 노래의 가수 이름과 노래 제목이 들어갑니다. -이찬용
                                        Expanded(
                                          child: Container(
                                            // width: 290,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 200,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      AppText(
                                                        text: widget
                                                            .playList[index]
                                                            .song,
                                                        color: Colors.white,
                                                        size: 16,
                                                      ),
                                                      AppText(
                                                        text: widget
                                                            .playList[index]
                                                            .singer,
                                                        color: Colors.grey,
                                                        size: 15,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Icon(
                                                    Icons.more_vert_sharp,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  )),

              // 하단의 메뉴
              Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          var list =
                              BlocProvider.of<MusicListPageInfoCubits>(context)
                                  .state;

                          if (list.isEmpty) {
                            setState(() {
                              color = Colors.red;
                            });

                            BlocProvider.of<MusicListPageInfoCubits>(context)
                                .updatePageWish(
                                    widget.info.name, selectedIndex, color);
                          } else {
                            for (int i = 0; i < list.length; i++) {
                              if (list[i].name == widget.info.name) {
                                if (list[i].color == Colors.red) {
                                  Future.delayed(Duration.zero, () {
                                    BlocProvider.of<MusicListPageInfoCubits>(
                                            context)
                                        .updatePageWish(widget.info.name,
                                            selectedIndex, color);
                                  });
                                  setState(() {
                                    color = Colors.white70;
                                  });
                                  return;
                                } else if (color == Colors.white70) {
                                  setState(() {
                                    color = Colors.red;
                                  });
                                  BlocProvider.of<MusicListPageInfoCubits>(
                                          context)
                                      .updatePageWish(widget.info.name,
                                          selectedIndex, color);
                                  return;
                                }
                              } else {
                                if (color == Colors.white70) {
                                  setState(() {
                                    color = Colors.red;
                                  });
                                  BlocProvider.of<MusicListPageInfoCubits>(
                                          context)
                                      .updatePageWish(widget.info.name,
                                          selectedIndex, color);
                                } else {
                                  setState(() {
                                    color = Colors.white70;
                                  });
                                  BlocProvider.of<MusicListPageInfoCubits>(
                                          context)
                                      .updatePageWish(widget.info.name,
                                          selectedIndex, color);
                                }
                              }
                            }
                          }
                        },
                        child: MusicListAddButtons(
                            isIcon: true,
                            icon: Icons.star_rounded,
                            size: 60,
                            color: color!,
                            backgraundColor: Colors.transparent,
                            borderColor: color!),
                      ),
                      SizeBoxW05(),
                      MusicListPlayButton(
                        icon: Icons.skip_previous,
                        iconColor: Colors.white,
                        iconSize: 35,
                        backColor: Colors.transparent,
                      ),
                      MusicListPlayButton(
                        icon: Icons.play_arrow,
                        iconColor: Colors.white,
                        iconSize: 40,
                        backColor: Colors.white12,
                      ),
                      MusicListPlayButton(
                        icon: Icons.skip_next,
                        iconColor: Colors.white,
                        iconSize: 35,
                        backColor: Colors.transparent,
                      ),
                      MusicListPlayButton(
                        icon: Icons.replay,
                        iconColor: Colors.white,
                        iconSize: 30,
                        backColor: Colors.transparent,
                      )
                    ],
                  )),

              // 리스트, 뷰, 자켓 앨범.
              Positioned(
                  top: 130,
                  left: MediaQuery.of(context).size.width / 2 - 100,
                  child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 15,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: GridView.count(
                        padding: EdgeInsets.zero,
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1,
                        children: List.generate(4, (index) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "${GlobalConfig.apiEndpoint}/img/album/" +
                                            widget.playList[index].albumIndex
                                                .toString() +
                                            ".jpg"),
                                    fit: BoxFit.cover)),
                          );
                        }),
                      ))),
            ],
          )),
    );
  }
}
