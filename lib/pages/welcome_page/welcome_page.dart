import 'package:flutter/material.dart';
import 'package:flutter_test_project/pages/welcome_page/widgets/welcome_page_sub3_producer_page.dart';
import 'package:flutter_test_project/pages/welcome_page/widgets/welcome_page_dot.dart';
import 'package:flutter_test_project/pages/welcome_page/widgets/welcome_page_sub1_login_page.dart';
import 'package:flutter_test_project/pages/welcome_page/widgets/welcome_page_sub2_sign_up_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // 배경 이미지 목록
  List images = ['backimg44.png', 'backimg22.png', 'backimg11.png'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              color: Colors.black87,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: images.length,
                  itemBuilder: (_, index) {
                    return Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/" + images[index]),
                        fit: BoxFit.cover,
                      )),
                      child: Container(
                        width: 500,
                        height: MediaQuery.of(context).size.height,
                        margin: const EdgeInsets.only(
                            top: 120, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 첫번째 페이지 - 로그인 하는 페이지
                            if (index == 0)
                              LoginScreen(
                                pageController: _pageController,
                              ),
                            // 두번째 페이지 - 가입채널로 이동하는 페이지
                            if (index == 1) CustomSignUpPage(),
                            // 세번째 페이지 - 소개페이지
                            if (index == 2) ProducerBox(), // 팀원 소개 페이지
                            Column(
                              children: List.generate(3, (indexDots) {
                                return DotIndicator(
                                  index: indexDots,
                                  currentIndex: index,
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
