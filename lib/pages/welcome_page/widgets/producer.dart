import 'package:flutter/material.dart';
import 'package:flutter_test_project/widgets/app_large_text.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';

class ProducerBox extends StatefulWidget {
  const ProducerBox({super.key});

  @override
  State<ProducerBox> createState() => _ProducerBoxState();
}

class _ProducerBoxState extends State<ProducerBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controllerCard;
  late Animation<double> _animation;
  late Animation<Alignment> _gradientCenterAnimation;

  @override
  void initState() {
    super.initState();
    _controllerCard = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 30.0).animate(CurvedAnimation(
      // 처음과 끝의 각도를 조절하기 위한 것, - 0, 30
      parent: _controllerCard,
      curve: Curves.easeOut,
    ));
    _gradientCenterAnimation = Tween(
      begin: Alignment(-0.9, -0.7),
      end: Alignment(1.0, 1.0),
    ).animate(CurvedAnimation(
      parent: _controllerCard,
      curve: Curves.bounceOut,
    ))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controllerCard.dispose();
    super.dispose();
  }
  // 컨트롤러 삭제.

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dragPercentage = details.primaryDelta! / screenWidth;
    _controllerCard.value += dragPercentage.clamp(-1.0, 1.0);
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    _controllerCard.animateBack(
      0.0,
      duration: Duration(milliseconds: 700), // 효과의 지속시간 조절
      curve: Curves.bounceOut, // 탄성 곡선 적용, 튕기는 현상, 바운스아웃
    );
  }

  @override
  Widget build(BuildContext context) {
    final angleY = (_animation.value) * 0.03; // 드래그에 따른 Y축 회전
    // 가로 측의 회전
    final double initialAngleX = 0.0174533; // 초기 X축 회전 (대각선 방향), 라디안 단위
    final double initialAngleZ = -8 * 0.0174533; // 초기 Z축 회전 (대각선 방향), 라디안 단위
    // 카드의 각도를 조절, -8는 왼쪽으로 8도 기울기.

    final Alignment gradientCenter = _gradientCenterAnimation.value;

    // 광원에 따라 그림자의 위치를 계산함.
    final double shadowX = gradientCenter.x * -10; // 그림자 X 위치 조정
    final double shadowY = gradientCenter.y * -10; // 그림자 Y 위치 조정

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onHorizontalDragUpdate: _onHorizontalDragUpdate,
          onHorizontalDragEnd: _onHorizontalDragEnd,
          child: Container(
            width: MediaQuery.of(context).size.width - 100,
            height: MediaQuery.of(context).size.height - 200,
            child: Center(
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(initialAngleX)
                  ..rotateY(angleY)
                  ..rotateZ(initialAngleZ),
                alignment: Alignment.center,
                child: Container(
                  width: 260,
                  height: 390,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white,
                        Colors.purple,
                      ],
                      stops: [0.0, 0.6], // 색상 변화 지점 조정
                      center: gradientCenter,
                      radius: 2.0, // 반경 증가
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(shadowX, shadowY),
                        blurRadius: 30.0,
                        spreadRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 들어갈 내용은 아래에 들어간다. Column이 아니라 스택구조로 유연하게 해도 됨.
                      SizeBoxH20(),
                      AppLargeText(
                        text: " Producer",
                        size: 48,
                        color: Colors.white,
                      ),
                      SizeBoxH40(),
                      AppLargeText(
                          text: "  Yang ChunMo", size: 28, color: Colors.white),
                      SizeBoxH20(),
                      AppLargeText(
                          text: "  Lee DongHun", size: 28, color: Colors.white),
                      SizeBoxH20(),
                      AppLargeText(
                          text: "  Lee ChanYong",
                          size: 28,
                          color: Colors.white),
                      SizeBoxH20(),
                      AppLargeText(
                          text: "  Choi ByengMin",
                          size: 28,
                          color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
