import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/data_model.dart';
import 'package:flutter_test_project/models/test_model.dart';
import 'package:flutter_test_project/pages/music_list_album_page/music_list_album_page.dart';
import 'package:flutter_test_project/pages/music_list_artist_page/music_list_artist_page.dart';
import 'package:flutter_test_project/widgets/app_text.dart';

class myInfoListTextStyle extends StatelessWidget {
  final List<String> sing;
  final List<String> song;
  final List<int> randomNumberlist;
  final List<Activity> userLikeSong;
  final List<TestModel> info;

  const myInfoListTextStyle(
      {super.key,
      required this.song,
      required this.sing,
      required this.userLikeSong,
      required this.randomNumberlist,
      required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      height: 700,
      width: double.maxFinite,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 10,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {
              randomNumberlist[index] == 1
                  ? Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MusicListArtistPage(
                            title: userLikeSong[index].singer,
                            info: info[index],
                            imgAsset:
                                "http://192.168.219.106:3300/img/singer/" +
                                    userLikeSong[index].singerIndex.toString() +
                                    ".jpg"),
                      ),
                    )
                  : Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MusicListAlbumPage(
                            title: userLikeSong[index].album,
                            info: info[index],
                            imgAsset: "http://192.168.219.106:3300/img/album/" +
                                userLikeSong[index].albumIndex.toString() +
                                ".jpg"),
                      ),
                    );
            },
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            randomNumberlist[index] == 1 ? 100 : 10),
                        color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage(randomNumberlist[index] == 1
                              ? "http://192.168.219.106:3300/img/singer/" +
                                  userLikeSong[index].singerIndex.toString() +
                                  ".jpg"
                              : "http://192.168.219.106:3300/img/album/" +
                                  userLikeSong[index].albumIndex.toString() +
                                  ".jpg"),
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  text: randomNumberlist[index] == 1
                                      ? userLikeSong[index].singer
                                      : userLikeSong[index].album,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                AppText(
                                  text: randomNumberlist[index] == 1
                                      ? userLikeSong[index].album
                                      : userLikeSong[index].singer,
                                  color: Colors.grey,
                                  size: 15,
                                )
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.more_vert_sharp,
                                color: Colors.white,
                                size: 30,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
