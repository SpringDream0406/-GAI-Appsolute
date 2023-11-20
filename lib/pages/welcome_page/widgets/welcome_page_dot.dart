import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  final int index;
  final int currentIndex;

  const DotIndicator({
    Key? key,
    required this.index,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      width: 8,
      height: currentIndex == index ? 25 : 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: currentIndex == index
            ? Colors.white
            : Colors.white.withOpacity(0.5),
      ),
    );
  }
}
