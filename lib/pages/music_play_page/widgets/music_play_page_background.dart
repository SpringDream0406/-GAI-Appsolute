import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/globals/globals.dart';
import 'package:flutter_test_project/models/data_model.dart';

class MusicPlayPageBackground extends StatefulWidget {
  final List<Activity> images;
  final PageController musicpagecontroller;
  final int selectedIndex;
  const MusicPlayPageBackground(
      {super.key,
      required this.images,
      required this.musicpagecontroller,
      required this.selectedIndex});

  @override
  State<MusicPlayPageBackground> createState() =>
      _MusicPlayPageBackgroundState();
}

class _MusicPlayPageBackgroundState extends State<MusicPlayPageBackground> {
  final ValueNotifier<int> _pageIndexNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    int initialIndex =
        widget.selectedIndex >= 0 && widget.selectedIndex < widget.images.length
            ? widget.selectedIndex
            : 0;
    _pageIndexNotifier.value = initialIndex;
    widget.musicpagecontroller.addListener(_pageListener);
  }

  void _pageListener() {
    int currentPage = widget.musicpagecontroller.page?.round() ?? 0;
    if (_pageIndexNotifier.value != currentPage) {
      _pageIndexNotifier.value = currentPage;
    }
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
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
        child: ValueListenableBuilder<int>(
          valueListenable: _pageIndexNotifier,
          builder: (context, value, child) {
            String imageUrl =
                "${GlobalConfig.apiEndpoint}/img/album/${widget.images[value].albumIndex}.jpg";
            return ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.10), // 검은색 필터를 적용합니다.
                BlendMode.darken, // 블렌드 모드를 사용하여 필터 효과를 결합합니다.
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            );
          },
        ),
      ),
    );
  }
}
