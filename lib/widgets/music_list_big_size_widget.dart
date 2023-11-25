import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/data_model.dart';
import 'package:flutter_test_project/widgets/app_large_text.dart';
import 'package:flutter_test_project/widgets/app_text.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';

class MusicListBigSizePlay extends StatefulWidget {
  final String listTitle;
  final String listContents;
  final List<Activity> playList;

  const MusicListBigSizePlay(
      {super.key,
      this.listTitle = "리스트 제목",
      this.listContents = "리스트 소개 내용",
      required this.playList});

  @override
  State<MusicListBigSizePlay> createState() => _MusicListBigSizePlayState();
}

class _MusicListBigSizePlayState extends State<MusicListBigSizePlay> {
  @override
  Widget build(BuildContext context) {
    double screen = MediaQuery.of(context).size.width;

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

    return Container(
      width: screen,
      height: screen * 1.1,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              child: Row(
                children: [
                  Container(
                    width: screen * 0.24,
                    height: screen * 0.24,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: NetworkImage(
                                "http://192.168.219.106:3300/img/album/" +
                                    widget.playList[0].albumIndex.toString() +
                                    ".jpg"),
                            fit: BoxFit.cover)),
                  ),
                  SizeBoxW10(),
                  Container(
                    width: screen * 0.57,
                    height: screen * 0.24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.listTitle,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        AppText(
                          text: "SEB'S MUSIC",
                          color: Colors.white54,
                          size: 14,
                        ),
                        AppText(
                          text: widget.playList.length.toString(),
                          color: Colors.white54,
                          size: 14,
                        )
                      ],
                    ),
                  )
                ],
              )),
          Positioned(
            top: screen * 0.26,
            left: 0,
            child: Container(
              width: screen * 0.84,
              height: screen * 0.12,
              child: Text(
                widget.listContents,
                style: TextStyle(color: Colors.white70, fontSize: 17),
              ),
            ),
          ),
          Positioned(
              top: screen * 0.43,
              left: 0,
              child: Container(
                height: screen * 0.45,
                width: screen * 0.84,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: 3,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "http://192.168.219.106:3300/img/album/" +
                                                widget
                                                    .playList[index].albumIndex
                                                    .toString() +
                                                ".jpg"),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              // 여기에 노래의 가수 이름과 노래 제목이 들어갑니다. -이찬용
                              Expanded(
                                child: Container(
                                  width: screen * 0.3,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 240,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppText(
                                              text: widget.playList[index].song,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                            AppText(
                                              text:
                                                  widget.playList[index].singer,
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
              )),
          Positioned(
            bottom: 0,
            left: 0,
            child: Row(
              children: [
                Container(
                  width: screen * 0.13,
                  height: screen * 0.13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          width: 1, color: Colors.grey.withOpacity(0.8))),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizeBoxW10(),
                Container(
                  width: screen * 0.13,
                  height: screen * 0.13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          width: 1, color: Colors.grey.withOpacity(0.8))),
                  child: Icon(
                    Icons.autorenew,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizeBoxW10(),
                Container(
                  width: screen * 0.13,
                  height: screen * 0.13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          width: 1, color: Colors.grey.withOpacity(0.8))),
                  child: Icon(
                    Icons.add_to_photos_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
