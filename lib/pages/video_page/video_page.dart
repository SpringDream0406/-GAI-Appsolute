import 'package:flutter/material.dart';
import 'package:flutter_test_project/widgets/background_concept_color.dart';
import '../../widgets/app_our_bar.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key});

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>
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
      duration: Duration(milliseconds: 700), // 효과의 지속시간 조절
      curve: Curves.bounceOut, // 탄성 곡선 적용
    );
  }

  @override
  Widget build(BuildContext context) {
    final angleY = (_animation.value) * 0.03; // 드래그에 따른 Y축 회전
    final double initialAngleX = 0.0174533; // 초기 X축 회전 (대각선 방향), 라디안 단위
    final double initialAngleZ = -15 * 0.0174533; // 초기 Z축 회전 (대각선 방향), 라디안 단위

    final Alignment gradientCenter = _gradientCenterAnimation.value;

    return Scaffold(
      body: Stack(
        children: [
          BackgroundConceptColor(),
          CustomScrollView(
            slivers: <Widget>[
              OurAppBar(),
              SliverToBoxAdapter(
                child: GestureDetector(
                  onHorizontalDragUpdate: _onHorizontalDragUpdate,
                  onHorizontalDragEnd: _onHorizontalDragEnd,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 150,
                    child: Center(
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateX(initialAngleX)
                          ..rotateY(angleY)
                          ..rotateZ(initialAngleZ),
                        alignment: Alignment.center,
                        child: Container(
                          width: 200,
                          height: 300,
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              gradient: RadialGradient(
                                colors: [
                                  Colors.white, // 중심 색상을 더 투명하게
                                  Colors.redAccent, // 끝 색상을 더 투명하고 부드럽게
                                ],
                                stops: [0.0, 0.5], // 색상 변화 지점 조정
                                center: gradientCenter,
                                radius: 2.0, // 반경 증가
                              ),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
