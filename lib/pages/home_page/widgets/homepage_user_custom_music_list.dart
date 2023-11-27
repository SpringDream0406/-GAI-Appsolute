import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/data_model.dart';
import 'package:flutter_test_project/models/test_model.dart';
import 'package:flutter_test_project/pages/music_list_page/music_list_page.dart';

class UserCustomMusicList extends StatelessWidget {
  final List<TestModel> info;
  final List<dynamic> playList;

  const UserCustomMusicList(
      {super.key, required this.info, required this.playList});

  @override
  Widget build(BuildContext context) {
    List userimg = [
      "userlist1.png",
      "userlist2.png",
      "userlist3.png",
      "userlist4.png",
      "userlist5.png"
    ];

    return Container(
      padding: const EdgeInsets.only(left: 15),
      height: 200,
      width: double.maxFinite,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MusicListPage(
                      info: info[index], playList: playList[index]),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 15, top: 5),
              width: 181,
              height: 181,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[900],
                  image: DecorationImage(
                      image: AssetImage("assets/" + userimg[index]),
                      fit: BoxFit.cover)),
            ),
          );
        },
      ),
    );
  }
}
