import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/cubit/app_cubits.dart';
import 'package:flutter_test_project/models/data_model.dart';
import 'package:flutter_test_project/models/test_model.dart';
import 'package:flutter_test_project/pages/music_play_page/music_play_page.dart';
import 'package:flutter_test_project/widgets/app_text.dart';
import 'package:flutter_test_project/widgets/global_keys.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';
import 'package:flutter_test_project/pages/main_page/main_page.dart';

class PlayBackHistory extends StatelessWidget {
  final List<TestModel> info;
  final List<String> titles;
  final List<String> images;

  const PlayBackHistory(
      {super.key,
      required this.info,
      required this.images,
      required this.titles});

  @override
  Widget build(BuildContext context) {
    PageController playBackHistoryPageController =
        PageController(viewportFraction: 0.97);

    return Container(
      padding: EdgeInsets.only(left: 10),
      height: 280,
      width: MediaQuery.of(context).size.width,
      child: PageView(
        controller: playBackHistoryPageController,
        children: [
          _buildRankList(context, 0, 4),
          _buildRankList(context, 4, 8),
          _buildRankList(context, 8, 12)
        ],
      ),
    );
  }

  Widget _buildRankList(BuildContext context, int start, int end) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: end - start,
      itemBuilder: (_, index) {
        int rankIndex = start + index;
        return InkWell(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => MusicPlayPage(info: info[index]),
            //     fullscreenDialog: true,
            //   ),
            // );
            // BlocProvider.of<AppCubits>(context).MusicPlayPage(info[index]);
            mainNavigatorKey.currentState!.push(
              MaterialPageRoute(
                  builder: (context) => MusicPlayPage(info: info[index])),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage("assets/" + images[rankIndex]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizeBoxW20(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: titles[rankIndex],
                            color: Colors.white,
                            size: 16,
                          ),
                          AppText(
                            text: "잔나비",
                            color: Colors.grey,
                            size: 15,
                          ),
                        ],
                      ),
                      Icon(
                        Icons.more_vert_sharp,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizeBoxW10(),
              ],
            ),
          ),
        );
      },
    );
  }
}
