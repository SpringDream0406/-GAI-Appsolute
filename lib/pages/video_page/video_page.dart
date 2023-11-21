import 'package:flutter/material.dart';
import 'package:flutter_test_project/widgets/animaited_card.dart';
import 'package:flutter_test_project/widgets/animaited_coin.dart';
import 'package:flutter_test_project/widgets/app_large_text.dart';
import 'package:flutter_test_project/widgets/background_concept_color.dart';
import '../../widgets/app_our_bar.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundConceptColor(),
          CustomScrollView(
            slivers: <Widget>[
              OurAppBar(),
              SliverToBoxAdapter(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
