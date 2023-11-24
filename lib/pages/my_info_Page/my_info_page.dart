import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/cubit/app_cubit_states.dart';
import 'package:flutter_test_project/cubit/app_cubits.dart';
import 'package:flutter_test_project/pages/edit_my_information_page/edit_my_information_page.dart';
import 'package:flutter_test_project/pages/my_info_Page/my_info_widgets/my_info_list_icon_style.dart';
import 'package:flutter_test_project/pages/my_info_Page/my_info_widgets/my_info_list_text_style.dart';
import 'package:flutter_test_project/widgets/app_large_text.dart';
import 'package:flutter_test_project/widgets/app_our_bar.dart';
import 'package:flutter_test_project/widgets/app_our_list_bar.dart';
import 'package:flutter_test_project/widgets/app_text.dart';
import 'package:flutter_test_project/widgets/background_concept_color.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool listStayle = true;
  IconData iconChainge = Icons.list;

  @override
  Widget build(BuildContext context) {
    List<int> randomNum1or2List() {
      var random = Random();
      List<int> randomNumberlist =
          List<int>.generate(10, (index) => random.nextInt(2) + 1);
      return randomNumberlist;
    }

    final List<int> randomNumberlist = randomNum1or2List();

    final List<String> sing = [
      "11.jpeg",
      "22.jpeg",
      "33.jpeg",
      "44.jpeg",
      "55.jpeg",
      "66.png",
      "77.jpeg",
      "88.jpeg"
    ];
    final List<String> song = [
      "11.jpeg",
      "22.jpeg",
      "33.jpeg",
      "44.jpeg",
      "55.jpeg",
      "66.jpeg",
      "77.jpeg",
      "88.png"
    ];
    final List<String> menu = ["재생목록", "노래", "앨범", "아티스트", "팟캐스트"];

    return Scaffold(
      // backgroundColor: Colors.grey[900],
      body: Stack(children: [
        BackgroundConceptColor(),
        CustomScrollView(slivers: <Widget>[
          OurAppBar(),
          OurAppListBar(menu: menu),
          SliverToBoxAdapter(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: BlocBuilder<AppCubits, CubitStates>(
                builder: (context, state) {
                  if (state is LoadedState) {
                    var info = state.places;
                    var infomation = state.lastResponse;

                    return Column(
                      children: [
                        // 최근활동 버튼
                        const SizeBoxH10(),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppLargeText(
                                text: "최근 활동",
                                color: Colors.white,
                                size: 24,
                              ),
                              IconButton(
                                icon: Icon(
                                  iconChainge,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (listStayle) {
                                    iconChainge = Icons.grid_view;
                                  } else {
                                    iconChainge = Icons.list;
                                  }

                                  setState(() {
                                    listStayle = !listStayle;
                                  });
                                },
                              )
                            ],
                          ),
                        ),

                        // 마이 리스트 정렬
                        const SizeBoxH15(),

                        listStayle == false
                            ? myInfoListTextStyle(
                                userLikeSong: infomation.user.singer,
                                song: song,
                                sing: sing,
                                randomNumberlist: randomNumberlist,
                                info: info,
                              )
                            : MyInfoListIconStyle(
                                userLikeSong: infomation.user.singer,
                                sing: sing,
                                song: song,
                                randomNumberlist: randomNumberlist,
                                info: info),
                        SizeBoxH40(),
                        SizeBoxH40()
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
