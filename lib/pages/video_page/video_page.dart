import 'package:flutter/material.dart';
import 'package:flutter_test_project/widgets/animaited_card.dart';
import 'package:flutter_test_project/widgets/app_large_text.dart';
import 'package:flutter_test_project/widgets/background_concept_color.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';
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
                  height: MediaQuery.of(context).size.height - 150,
                  child: Center(
                    child: AnimatedCard(
                      yAngle: 30,
                      zAngle: -15,
                      width: 200,
                      height: 200,
                      radius: 100,
                      cardColor: Colors.orange,
                      widget: Center(
                        child: AppLargeText(
                          text: "정태녕",
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
