import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  AppText({
    super.key,
    this.size = 16,
    required this.text,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        overflow: TextOverflow.ellipsis,
        fontSize: size,
        // fontWeight: FontWeight.bold
      ),
    );
  }
}
