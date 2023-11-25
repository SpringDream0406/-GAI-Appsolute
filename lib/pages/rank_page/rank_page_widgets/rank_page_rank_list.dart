import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/cubit/app_cubits.dart';
import 'package:flutter_test_project/models/data_model.dart';
import 'package:flutter_test_project/models/test_model.dart';
import 'package:flutter_test_project/pages/music_play_page/music_play_page.dart';
import 'package:flutter_test_project/widgets/app_text.dart';
import 'package:flutter_test_project/widgets/global_keys.dart';

class RankPageRankList extends StatelessWidget {
  final List<String> titles;
  final List<String> images;
  final List<TestModel> info;
  final List<Activity> userPlayed;

  const RankPageRankList(
      {super.key,
      required this.userPlayed,
      required this.images,
      required this.titles,
      required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 350,
      width: double.maxFinite,
      child: PageView(
        children: [
          _buildRankList(context, 0, 5), // 1-4위
          _buildRankList(context, 5, 10), // 5-8위
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
            // BlocProvider.of<AppCubits>(context).MusicPlayPage(info[index]);
            mainNavigatorKey.currentState!.push(
              MaterialPageRoute(
                  builder: (context) => MusicPlayPage(
                        selectedActivity: userPlayed[rankIndex],
                        userPlayed: userPlayed,
                      )),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                SizedBox(width: 5),
                Container(
                  width: 40,
                  height: 60,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          '${rankIndex + 1}',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Icon(
                          Icons.trending_up,
                          color: Colors.red,
                          size: 17,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(
                          "http://192.168.219.106:3300/img/album/" +
                              userPlayed[rankIndex].albumIndex.toString() +
                              ".jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: userPlayed[rankIndex].song,
                              color: Colors.white,
                              size: 16,
                            ),
                            AppText(
                              text: userPlayed[rankIndex].singer,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.more_vert_sharp,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
