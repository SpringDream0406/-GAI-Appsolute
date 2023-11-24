import 'package:flutter/material.dart';

class MusicListPageAlbumJacketImg extends StatelessWidget {
  final String imgAsset;
  const MusicListPageAlbumJacketImg({super.key, required this.imgAsset});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 120,
      left: MediaQuery.of(context).size.width / 2 - 120,
      child: Container(
          width: 240,
          height: 240,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 15,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
              color: Colors.black54,
              image: DecorationImage(
                  image: NetworkImage(imgAsset), fit: BoxFit.cover))),
    );
  }
}
