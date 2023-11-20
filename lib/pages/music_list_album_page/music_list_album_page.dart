import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/models/test_model.dart';
import 'package:flutter_test_project/pages/music_list_album_page/cubit/music_list_album_page_info_cubits.dart';
import 'package:flutter_test_project/pages/music_list_album_page/widgets/music_list_album_page_background.dart';
import 'package:flutter_test_project/pages/music_list_album_page/widgets/music_list_album_page_jacket.dart';
import 'package:flutter_test_project/pages/music_list_album_page/widgets/music_list_album_top_bar.dart';
import 'package:flutter_test_project/pages/music_list_album_page/widgets/music_list_album_wish_and_play_botten.dart';
import 'package:flutter_test_project/widgets/app_large_text.dart';
import 'package:flutter_test_project/widgets/app_text.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';

class MusicListAlbumPage extends StatefulWidget {
  final String imgAsset;
  final TestModel info;
  const MusicListAlbumPage(
      {super.key, required this.info, required this.imgAsset});

  @override
  State<MusicListAlbumPage> createState() => _MusicListAlbumPageState();
}

class _MusicListAlbumPageState extends State<MusicListAlbumPage> {
  // 스크롤 이동을 주기위한 코드입니다.
  late ScrollController _musicListAlbumcontroller = ScrollController();

  @override
  void initState() {
    super.initState();
    _musicListAlbumcontroller = ScrollController(); // initState에서 초기화
  }

  @override
  void dispose() {
    _musicListAlbumcontroller.dispose(); // _tabController를 dispose 메서드에서 해제
    super.dispose();
  }

  // 스크롤 이동을 주기위한 코드입니다.-- 여기까지입니다.

  int selectedIndex = -1;
  Color? btncolor = Colors.white;

  // 아래는 전부 테스트용.
  String test = "";

  // 이미지
  List images = [
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

  // 노래제목
  List title = [
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

  // 별점의 숫자가 들어갈 공간
  int gottenStars = 5;

  @override
  Widget build(BuildContext context) {
    var list = BlocProvider.of<MusicListAlbumPageInfoCubits>(context).state;
    //
    // MusicListArtistPage detail = state as MusicListArtistPage;
    //
    print('정보의 길이${list.length}');

    for (int i = 0; i < list.length; i++) {
      if (list[i].name == widget.info.name) {
        selectedIndex = list[i].index!;
        btncolor = list[i].color;
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
              MusicListAlbumBackground(imgAsset: widget.imgAsset),

              // 상단의 메뉴 (widget)
              MusicListAlbumPageTopBar(),

              // 하단의 출력 공간
              Positioned(
                  top: 260,
                  child: Container(
                    padding: EdgeInsets.only(left: 20, top: 30, right: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 700,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black, // 끝 색상
                      ],
                      stops: [0.0, 0.25], // 각 색상이 위치할 지점
                    )),
                    child: Column(
                      // 하단의 내용이 들어 있다.- 이찬용
                      children: [
                        SizeBoxH40(),
                        SizeBoxH40(),
                        // 가수 이름
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppLargeText(
                              text: "앨범 제목",
                              color: Colors.white,
                              size: 38,
                            ),
                          ],
                        ),
                        SizeBoxH10(),
                        // 데이터 넘어오는거 확인용
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppLargeText(
                              text: "데확용1 : " + widget.info.name,
                              color: Colors.white,
                              size: 20,
                            )
                          ],
                        ),
                        SizeBoxH20(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: AlbumWishButton(
                                btnColor: btncolor,
                                onTap: () {
                                  var list = BlocProvider.of<
                                          MusicListAlbumPageInfoCubits>(context)
                                      .state;

                                  if (list.isEmpty) {
                                    setState(() {
                                      btncolor = Colors.white70;
                                    });

                                    BlocProvider.of<
                                                MusicListAlbumPageInfoCubits>(
                                            context)
                                        .updateMusicListAlbumPageWish(
                                            widget.info.name,
                                            selectedIndex,
                                            btncolor);
                                  } else {
                                    for (int i = 0; i < list.length; i++) {
                                      if (list[i].name == widget.info.name) {
                                        if (list[i].color == Colors.white70) {
                                          Future.delayed(Duration.zero, () {
                                            BlocProvider.of<
                                                        MusicListAlbumPageInfoCubits>(
                                                    context)
                                                .updateMusicListAlbumPageWish(
                                                    widget.info.name,
                                                    selectedIndex,
                                                    btncolor);
                                          });
                                          setState(() {
                                            btncolor = Colors.white;
                                          });
                                          return;
                                        } else if (btncolor == Colors.white) {
                                          setState(() {
                                            btncolor = Colors.white70;
                                          });
                                          BlocProvider.of<
                                                      MusicListAlbumPageInfoCubits>(
                                                  context)
                                              .updateMusicListAlbumPageWish(
                                                  widget.info.name,
                                                  selectedIndex,
                                                  btncolor);
                                          return;
                                        }
                                      } else {
                                        if (btncolor == Colors.white) {
                                          setState(() {
                                            btncolor = Colors.white70;
                                          });
                                          BlocProvider.of<
                                                      MusicListAlbumPageInfoCubits>(
                                                  context)
                                              .updateMusicListAlbumPageWish(
                                                  widget.info.name,
                                                  selectedIndex,
                                                  btncolor);
                                        } else {
                                          setState(() {
                                            btncolor = Colors.white;
                                          });
                                          BlocProvider.of<
                                                      MusicListAlbumPageInfoCubits>(
                                                  context)
                                              .updateMusicListAlbumPageWish(
                                                  widget.info.name,
                                                  selectedIndex,
                                                  btncolor);
                                        }
                                      }
                                    }
                                  }
                                },
                              ),
                            ),
                            SizeBoxW15(),
                            Expanded(
                              child: AlbumPlayButton(
                                onTap: () {},
                              ),
                            )
                          ],
                        ),
                        SizeBoxH20(),
                        // 노래 리스트가 담긴 곳
                        Container(
                          height: 240,
                          width: double.maxFinite,
                          child: ListView.builder(
                              controller: _musicListAlbumcontroller,
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemCount: images.length,
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                  onTap: () {
                                    var data = widget.info;
                                    var list = BlocProvider.of<
                                                MusicListAlbumPageInfoCubits>(
                                            context)
                                        .state;

                                    for (int i = 0; i < list.length; i++) {
                                      if (list[i].name == data.name) {
                                        if (list[i].index == index) {
                                          print('안녕 인덱스 ${selectedIndex}');
                                        } else {
                                          print('안녕 새로운 인덱스 $index');
                                          BlocProvider.of<
                                                      MusicListAlbumPageInfoCubits>(
                                                  context)
                                              .updateMusicListAlbumPageInfo(
                                                  widget.info.name,
                                                  index,
                                                  btncolor);
                                          selectedIndex = index;
                                        }
                                      }
                                    }

                                    if (selectedIndex == -1) {
                                      // 이 버튼, 즉 앨범을 누를 떄, 정보가 넘어갑니다. 이것은요, 이 페이지 안에서 체크 되는 것을 저장하기 위한 것입니다.
                                      BlocProvider.of<
                                                  MusicListAlbumPageInfoCubits>(
                                              context)
                                          .addMusicListAlbumPageInfo(
                                              widget.info.name,
                                              index,
                                              btncolor);
                                    }

                                    setState(() {
                                      selectedIndex = index;
                                    });

                                    // 음악을 누르면 스크롤이 거기로 이동함. 아시죠?
                                    _musicListAlbumcontroller.animateTo(
                                        index * 60.0,
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
                                                  image: AssetImage("assets/" +
                                                      images[index]),
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
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      AppText(
                                                        text: title[index]
                                                            .toString(),
                                                        color: Colors.white,
                                                        size: 16,
                                                      ),
                                                      AppText(
                                                        text: "잔나비",
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

              // 앨범의 자켓 이미지.(생성자 만들어서 이미지 전달하시면 됩니다.)
              MusicListPageAlbumJacketImg(imgAsset: widget.imgAsset)
            ],
          )),
    );
  }
}
