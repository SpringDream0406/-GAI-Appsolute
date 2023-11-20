import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/test_model.dart';
import 'package:flutter_test_project/pages/music_list_page/music_list_page.dart';

class PlaceRecommendedPlaylist extends StatelessWidget {
  final List<TestModel> info;

  const PlaceRecommendedPlaylist({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      itemCount: info.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MusicListPage(info: info[index]),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(right: 15, top: 5),
            width: 180,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[900],
                image: DecorationImage(
                    image: AssetImage("assets/backimg22.png"),
                    fit: BoxFit.cover)),
          ),
        );
      },
    );
  }
}
