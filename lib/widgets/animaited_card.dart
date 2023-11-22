import 'package:flutter/material.dart';

class AnimatedCard extends StatefulWidget {
  final Color? cardColor; // 카드 색
  final double? zAngle; // 카드 기울기 음수는 좌, 양수는 우
  final double? yAngle; // 카드 회전 음수는 좌, 양수는 우
  final double width; // 카드 넓이
  final double height; // 카드 높이
  final Widget? widget; // 안에 넣고 싶은 것, 그런데 하얀 글씨만 어울림.
  final double? radius;
  const AnimatedCard(
      {Key? key,
      this.cardColor = Colors.redAccent,
      this.zAngle = 0,
      this.yAngle = 30,
      this.widget,
      this.radius = 15,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  _AnimatedCardState createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<Alignment> _gradientCenterAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 30.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _gradientCenterAnimation = Tween(
      begin: Alignment(-0.9, -0.7),
      end: Alignment(1.0, 1.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dragPercentage = details.primaryDelta! / screenWidth;
    _controller.value += dragPercentage.clamp(-1.0, 1.0);
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    _controller.animateBack(
      0.0,
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final angleY = (_animation.value) * (widget.yAngle! / 1000);
    final double initialAngleX = 0.0174533;
    final double initialAngleZ = widget.zAngle! * 0.0174533;

    final Alignment gradientCenter = _gradientCenterAnimation.value;

    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(initialAngleX)
          ..rotateY(angleY)
          ..rotateZ(initialAngleZ),
        alignment: Alignment.center,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.cardColor,
            gradient: RadialGradient(
              colors: [Colors.white, widget.cardColor!],
              stops: [0.0, 0.5],
              center: gradientCenter,
              radius: 2.0,
            ),
            borderRadius: BorderRadius.circular(widget.radius!),
          ),
          child: widget.widget,
        ),
      ),
    );
  }
}
