import 'package:flutter/material.dart';

class AnimatedCoin extends StatefulWidget {
  final Color? cardColor; // 카드 색
  final double? zAngle; // 기울기 음수는 좌, 양수는 우
  final double? yAngle; // 회전 음수는 좌, 양수는 우
  final double width; // 카드 넓이
  final double height; // 카드 높이
  final Widget? widget; // 안에 넣고 싶은 것
  final double? radius;

  const AnimatedCoin(
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
  _AnimatedCoinState createState() => _AnimatedCoinState();
}

class _AnimatedCoinState extends State<AnimatedCoin>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _verticalMoveAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _rotationAnimation = Tween(begin: 0.0, end: 3 * 3.14159).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _verticalMoveAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: -100.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50.0,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -100.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50.0,
      ),
    ]).animate(_controller);

    _bounceAnimation = Tween<double>(begin: 0.0, end: -90.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.bounceOut),
      ),
    );

    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
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
    _controller.value = dragPercentage.clamp(-1.0, 1.0);
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final angleY = _rotationAnimation.value;

    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..translate(0.0,
                  _verticalMoveAnimation.value + _bounceAnimation.value, 0.0)
              ..rotateY(angleY),
            alignment: Alignment.center,
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.cardColor,
                gradient: RadialGradient(
                  colors: [Colors.white, widget.cardColor!],
                  stops: [0.0, 1.0],
                  center: Alignment(-0.9, -0.7),
                  radius: 2.0,
                ),
                borderRadius: BorderRadius.circular(widget.radius ?? 0),
              ),
              child: Center(child: widget.widget ?? Container()),
            ),
          );
        },
      ),
    );
  }
}
