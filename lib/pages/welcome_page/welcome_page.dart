import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/cubit/app_cubits.dart';
import 'package:flutter_test_project/pages/welcome_page/widgets/producer.dart';
import 'package:flutter_test_project/pages/welcome_page/widgets/sign_up_toast.dart';
import 'package:flutter_test_project/pages/welcome_page/widgets/welcome_page_dot.dart';
import 'package:flutter_test_project/pages/welcome_page/widgets/welcome_page_login_join_input.dart';
import 'package:flutter_test_project/pages/welcome_page/widgets/welcome_page_sub2_sign_up_page.dart';
import 'package:flutter_test_project/services/sign_up_services.dart';
import 'package:flutter_test_project/services/sign_up_services.dart';
import 'package:flutter_test_project/widgets/app_large_text.dart';
import 'package:flutter_test_project/widgets/login_button.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';

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

  // 로그인 관련 도구
  late String message;

  final Map<String, String> _userData = {
    '_userId': '',
    '_userPw': '',
  };

  // 로그인 조건식
  bool _validateData() {
    // 모든 입력란이 비어있지 않은지 확인
    for (String key in _userData.keys) {
      if (_userData[key]!.isEmpty) {
        message = "모든 정보를 채워주세요.";
        return false;
      }
    }
    return true;
  }

  // 이미지 목록
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
                                      _userData['_userId'] = value;
                                    },
                                  ),
                                  SizeBoxH10(),
                                  CustomTextField(
                                    label: 'PASSWORD',
                                    hint: '패스워드를 입력하세요.',
                                    isObscure: true,
                                    onChanged: (value) {
                                      _userData['_userPw'] = value;
                                    },
                                  ),
                                  SizeBoxH15(),
                                  GestureDetector(
                                    onTap: () async {
                                      if (_validateData()) {
                                        await UserLoginService.login(
                                            userId: _userData['_userId']!,
                                            userPw: _userData['_userPw']!);
                                        BlocProvider.of<AppCubits>(context)
                                            .getData();
                                      } else {
                                        ShowToast("로그인에 실패하였습니다.");
                                      }
                                    },
                                    child: LoginButton(text: "Login"),
                                  ),
                                  SizeBoxH20(),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _pageController.animateToPage(
                                            1,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                        child: Text(
                                          " 회원 가입 ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                      ),
                                      Text(
                                        " / ",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      ),
                                      GestureDetector(
                                        child: Text(
                                          " 계정, 암호 찾기",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 250),
                                  GestureDetector(
                                    onTap: () {
                                      _pageController.animateToPage(
                                        2,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    child: Text(
                                      "- MADE ABSOLUTE",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 18),
                                    ),
                                  )
                                ],
                              ),
                            if (index == 1)
                              CustomSignUpPage(), // 가입페이지로 이동하는 페이지
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
