import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/pages/welcome_page/widgets/sign_up_toast.dart';
import 'package:flutter_test_project/pages/welcome_page/widgets/welcome_page_login_join_input.dart';
import 'package:flutter_test_project/services/sign_up_services.dart';
import 'package:flutter_test_project/widgets/login_button.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';

import '../../../cubit/app_cubits.dart';
import '../../../widgets/app_large_text.dart';

class LoginScreen extends StatelessWidget {
  final PageController pageController;
  const LoginScreen({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    // 유효성 검사 결과가 담길 메세지
    late String message;

    final Map<String, String> _userData = {
      '_userId': '',
      '_userPw': '',
    };

    // 로그인 유효성 검사 조건식
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppLargeText(text: "인공지능 성향분석"),
        AppLargeText(text: "음악추천 플레이어"),
        AppLargeText(text: "SEB'S MUSIC", size: 40, color: Colors.white),
        SizeBoxH40(),
        AppLargeText(text: "로그인", size: 28, color: Colors.white),
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
          onTap:
              //     () async {
              //   if (_validateData()) {
              //     await UserLoginService.login(
              //         userId: _userData['_userId']!, userPw: _userData['_userPw']!);
              //     BlocProvider.of<AppCubits>(context).getData();
              //   } else {
              //     ShowToast("로그인에 실패하였습니다.");
              //   }
              // }
              () async {
            if (_validateData()) {
              var result = await UserLoginService.login(
                  userId: _userData['_userId']!, userPw: _userData['_userPw']!);

              if (result.success) {
                BlocProvider.of<AppCubits>(context).getData();
              } else {
                ShowToast(context, result.message);
              }
            } else {
              ShowToast(context, "모든 정보를 채워주세요.");
            }
          },
          child: LoginButton(text: "Login"),
        ),
        SizeBoxH20(),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                pageController.animateToPage(
                  1,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Text(
                " 회원 가입 ",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            Text(
              " / ",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            GestureDetector(
              child: Text(
                " 계정, 암호 찾기",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ],
        ),
        SizedBox(height: 250),
        GestureDetector(
          onTap: () {
            pageController.animateToPage(
              2,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          child: Text(
            "- MADE ABSOLUTE",
            style: TextStyle(color: Colors.white54, fontSize: 16),
          ),
        )
      ],
    );
  }
}
