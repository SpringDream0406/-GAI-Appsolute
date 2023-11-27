import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/cubit/app_cubits.dart';
import 'package:flutter_test_project/models/data_model.dart';
import 'package:flutter_test_project/models/test_model.dart';
import 'package:flutter_test_project/pages/music_list_page/music_list_page.dart';

class EmotionRecommendedPlaylist extends StatelessWidget {
  final List<TestModel> info;
  final List<Activity> playList;

  const EmotionRecommendedPlaylist(
      {super.key, required this.info, required this.playList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: playList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            // BlocProvider.of<AppCubits>(context).MusicListPage(info[index]);

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    MusicListPage(info: info[index], playList: playList),
                // fullscreenDialog: true,
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(right: 15, top: 10),
            width: 180,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage("assets/backimg33.png"),
                    fit: BoxFit.cover)),
          ),
        );
      },
    );
  }
}
