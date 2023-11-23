import 'package:flutter/material.dart';
import 'package:flutter_test_project/widgets/app_large_text.dart';
import 'package:flutter_test_project/widgets/app_text.dart';
import 'package:flutter_test_project/widgets/background_concept_color.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';
import '../../widgets/app_our_bar.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
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

  @override
  Widget build(BuildContext context) {
    double screen = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          BackgroundConceptColor(),
          CustomScrollView(
            slivers: <Widget>[
              OurAppBar(),
              SliverToBoxAdapter(
                child: Container(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
