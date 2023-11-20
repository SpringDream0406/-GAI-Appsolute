import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/test_model.dart';
import 'package:flutter_test_project/pages/music_list_album_page/music_list_album_page.dart';
import 'package:flutter_test_project/pages/music_list_artist_page/music_list_artist_page.dart';
import 'package:flutter_test_project/pages/music_list_page/music_list_page.dart';
import 'package:flutter_test_project/widgets/app_large_text.dart';
import 'package:flutter_test_project/widgets/app_text.dart';

class MyInfoListIconStyle extends StatelessWidget {
  final List<String> sing;
  final List<String> song;
  final List<int> randomNumberlist;
  final List<TestModel> info;

  const MyInfoListIconStyle(
      {super.key,
      required this.song,
      required this.sing,
      required this.randomNumberlist,
      required this.info});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        height: 1000,
        child: GridView.builder(
          // shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(0),
          itemCount: 8,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 2.5,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                randomNumberlist[index] == 1
                    ? Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MusicListArtistPage(
                              info: info[index],
                              imgAsset: "assets/all/" + song[index]),
                        ),
                      )
                    : Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MusicListAlbumPage(
                              info: info[index],
                              imgAsset: "assets/sing/" + sing[index]),
                        ),
                      );
              },
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          randomNumberlist[index] == 1 ? 100 : 10,
                        ),
                        color: Colors.grey[800],
                        image: DecorationImage(
                          image: AssetImage(randomNumberlist[index] == 1
                              ? "assets/all/" + song[index]
                              : "assets/sing/" + sing[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    AppLargeText(
                        text: "타이틀이 들어감", color: Colors.white70, size: 18),
                    AppText(
                      text: "리스트 또는 작가이름",
                      color: Colors.white70,
                      size: 16,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
