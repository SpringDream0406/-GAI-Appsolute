import 'dart:ui';
import 'package:flutter/material.dart';

class BackgroundConceptImg extends StatelessWidget {
  final String? imagePath;
  const BackgroundConceptImg({super.key, this.imagePath = null});

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          decoration: imagePath == null
              ? BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage("assets/bgimg/nomalbg1.jpeg"),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), // 반투명한 검은색
                      BlendMode.colorBurn, // 오버레이 모드
                    ),
                  ))
              : BoxDecoration(
                  image: DecorationImage(
                  image: AssetImage(imagePath!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2), // 반투명한 검은색
                    BlendMode.overlay, // 오버레이 모드
                  ),
                ))),
    );
  }
}
