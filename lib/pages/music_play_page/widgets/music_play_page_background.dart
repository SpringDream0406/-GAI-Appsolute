import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/data_model.dart';

class MusicPlayPageBackground extends StatefulWidget {
  final List<Activity> images;
  final PageController musicpagecontroller;
  const MusicPlayPageBackground(
      {super.key, required this.images, required this.musicpagecontroller});

  @override
  State<MusicPlayPageBackground> createState() =>
      _MusicPlayPageBackgroundState();
}

class _MusicPlayPageBackgroundState extends State<MusicPlayPageBackground> {
  final ValueNotifier<int> _pageIndexNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    widget.musicpagecontroller.addListener(_pageListener);
  }

  void _pageListener() {
    _pageIndexNotifier.value = widget.musicpagecontroller.page!.round();
  }

  @override
  void dispose() {
    widget.musicpagecontroller.removeListener(_pageListener);
    _pageIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      child: ClipRRect(
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ValueListenableBuilder<int>(
              valueListenable: _pageIndexNotifier,
              builder: (context, value, child) {
                String imageUrl =
                    "http://192.168.219.106:3300/img/album/${widget.images[value].albumIndex}.jpg";
                print("Loading image: $imageUrl");
                return Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
