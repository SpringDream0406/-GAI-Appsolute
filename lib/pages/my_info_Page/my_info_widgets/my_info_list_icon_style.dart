import 'package:flutter/material.dart';
import 'package:flutter_test_project/globals/globals.dart';
import 'package:flutter_test_project/models/data_model.dart';
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
  final List<Activity> userLikeSong;

  const MyInfoListIconStyle(
      {super.key,
      required this.userLikeSong,
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
        height: 1200,
        child: GridView.builder(
          // shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(0),
          itemCount: 10,
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
                              title: userLikeSong[index].singer,
                              info: info[index],
                              imgAsset:
                                  "${GlobalConfig.apiEndpoint}/img/singer/" +
                                      userLikeSong[index]
                                          .singerIndex
                                          .toString() +
                                      ".jpg"),
                        ),
                      )
                    : Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MusicListAlbumPage(
                              title: userLikeSong[index].album,
                              info: info[index],
                              imgAsset:
                                  "${GlobalConfig.apiEndpoint}/img/album/" +
                                      userLikeSong[index]
                                          .albumIndex
                                          .toString() +
                                      ".jpg"),
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
                          image: NetworkImage(randomNumberlist[index] == 1
                              ? "${GlobalConfig.apiEndpoint}/img/singer/" +
                                  userLikeSong[index].singerIndex.toString() +
                                  ".jpg"
                              : "${GlobalConfig.apiEndpoint}/img/album/" +
                                  userLikeSong[index].albumIndex.toString() +
                                  ".jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    AppLargeText(
                        text: randomNumberlist[index] == 1
                            ? userLikeSong[index].singer
                            : userLikeSong[index].album,
                        color: Colors.white70,
                        size: 18),
                    AppText(
                      text: randomNumberlist[index] == 1
                          ? userLikeSong[index].album
                          : userLikeSong[index].singer,
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
