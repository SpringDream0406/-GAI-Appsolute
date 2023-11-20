import 'package:flutter/material.dart';

class MusicListAlbumPageTopBar extends StatelessWidget {
  const MusicListAlbumPageTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        width: MediaQuery.of(context).size.width - 20,
        left: 10,
        top: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.west,
                size: 30,
              ),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              color: Colors.white,
            )
          ],
        ));
  }
}
