import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

// 사용자 정의 위젯 정의
class MarqueeAppLargeText extends StatefulWidget {
  final double size;
  final String text;
  final Color color;

  MarqueeAppLargeText({
    Key? key,
    this.size = 30,
    required this.text,
    this.color = Colors.white70,
  }) : super(key: key);

  @override
  _MarqueeAppLargeTextState createState() => _MarqueeAppLargeTextState();
}

class _MarqueeAppLargeTextState extends State<MarqueeAppLargeText> {
  @override
  Widget build(BuildContext context) {
    return Marquee(
      text: widget.text,
      style: TextStyle(
        color: widget.color,
        fontSize: widget.size,
        fontWeight: FontWeight.bold,
      ),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      blankSpace: 20.0,
      velocity: 100.0,
      pauseAfterRound: Duration(seconds: 1),
      startPadding: 10.0,
      accelerationDuration: Duration(seconds: 1),
      accelerationCurve: Curves.linear,
      decelerationDuration: Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
    );
  }
}
