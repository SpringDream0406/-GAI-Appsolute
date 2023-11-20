import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/cubit/app_cubits.dart';
import 'package:flutter_test_project/pages/welcome_page/widgets/producer.dart';
import 'package:flutter_test_project/pages/welcome_page/widgets/signup_page.dart';
import 'package:flutter_test_project/pages/welcome_page/widgets/welcome_page_dot.dart';
import 'package:flutter_test_project/pages/welcome_page/widgets/welcome_page_login_join_input.dart';
import 'package:flutter_test_project/widgets/app_large_text.dart';
import 'package:flutter_test_project/widgets/login_button.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // 이미지 목록
  List images = ['backimg44.png', 'backimg22.png', 'backimg11.png'];

  // 사용자 입력을 저장할 변수
  String _userId = "";
  String _password = "";

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
                            if (index == 0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppLargeText(text: "인공지능 성향분석"),
                                  AppLargeText(text: "음악추천 플레이어"),
                                  AppLargeText(
                                      text: "SEB'S MUSIC",
                                      size: 40,
                                      color: Colors.white),
                                  SizeBoxH40(),
                                  AppLargeText(
                                      text: "로그인",
                                      size: 28,
                                      color: Colors.white),
                                  SizeBoxH20(),
                                  CustomTextField(
                                    label: 'ID',
                                    hint: '아이디를 입력하세요.',
                                    onChanged: (value) {
                                      _userId = value;
                                    },
                                  ),
                                  SizeBoxH10(),
                                  CustomTextField(
                                    label: 'PASSWORD',
                                    hint: '패스워드를 입력하세요.',
                                    isObscure: true,
                                    onChanged: (value) {
                                      _password = value;
                                    },
                                  ),
                                  SizeBoxH15(),
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<AppCubits>(context)
                                          .getData();
                                    },
                                    child: LoginButton(text: "Login"),
                                  ),
                                ],
                              ),
                            if (index == 1)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppLargeText(text: "인공지능 성향분석"),
                                  AppLargeText(text: "음악추천 플레이어"),
                                  AppLargeText(
                                      text: "SEB'S MUSIC",
                                      size: 40,
                                      color: Colors.white),
                                  SizeBoxH40(),
                                  AppLargeText(
                                      text: "회원가입",
                                      size: 28,
                                      color: Colors.white),
                                  SizeBoxH30(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              SignUpPage(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            const begin = Offset(1.0, 0.0);
                                            const end = Offset.zero;
                                            const curve = Curves.ease;

                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));
                                            var offsetAnimation =
                                                animation.drive(tween);

                                            return SlideTransition(
                                              position: offsetAnimation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: LoginButton(
                                      text: "Sign Up",
                                      circular: 10,
                                    ),
                                  ),
                                  SizeBoxH15(),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.7,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/kakao_login_large_narrow.png"),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.withOpacity(0.5)),
                                  ),
                                  SizeBoxH15(),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.7,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/google_login.png"),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.withOpacity(0.9)),
                                  ),
                                ],
                              ),
                            if (index == 2) ProducerBox(),
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
