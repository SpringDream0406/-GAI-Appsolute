import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/test_model.dart';
import 'package:flutter_test_project/pages/music_list_page/music_list_page.dart';
import 'package:flutter_test_project/widgets/app_large_text.dart';
import 'package:flutter_test_project/widgets/app_text.dart';

class RankPageNewAlbumList extends StatelessWidget {
  final List<String> userimg;
  final List<TestModel> info;
  final List<dynamic> playList;

  const RankPageNewAlbumList(
      {super.key,
      required this.userimg,
      required this.info,
      required this.playList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      // height: MediaQuery.of(context).size.width/2,
      height: 250,
      width: double.maxFinite,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // BlocProvider.of<AppCubits>(context).detailPage(info[index]);

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MusicListPage(
                      info: info[index], playList: playList[index]),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15, top: 5),
                  width: MediaQuery.of(context).size.width / 2 - 25,
                  height: MediaQuery.of(context).size.width / 2 - 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[900],
                      image: DecorationImage(
                          image: AssetImage("assets/" + userimg[index]),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: 3,
                ),
                AppLargeText(
                  text: " 노래 제목 들어가는곳",
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(
                  height: 3,
                ),
                AppText(
                  text: " 앨범 제목",
                  color: Colors.white70,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
