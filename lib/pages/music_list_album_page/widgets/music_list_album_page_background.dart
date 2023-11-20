import 'dart:ui';
import 'package:flutter/material.dart';

class MusicListAlbumBackground extends StatelessWidget {
  final String imgAsset;
  const MusicListAlbumBackground({super.key, required this.imgAsset});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      child: ClipRRect(
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width + 50,
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.7), // 반투명한 검은색
                      BlendMode.overlay, // 오버레이 모드
                    ),
                    image: AssetImage(imgAsset),
                    fit: BoxFit.cover)),
          ),
        ),
      ),
    );
  }
}
