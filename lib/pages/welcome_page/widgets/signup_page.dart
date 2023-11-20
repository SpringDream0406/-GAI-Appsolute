import 'package:flutter/material.dart';
import 'package:flutter_test_project/pages/welcome_page/widgets/gender_select_widget.dart';
import 'package:flutter_test_project/pages/welcome_page/widgets/sign_up_toast.dart';
import 'package:flutter_test_project/pages/welcome_page/widgets/welcome_page_login_join_input.dart';
import 'package:flutter_test_project/services/sign_up_services.dart';
import 'package:flutter_test_project/widgets/app_large_text.dart';
import 'package:flutter_test_project/widgets/login_button.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String message;

  final Map<String, String> _userData = {
    'userId': '',
    'userPw': '',
    'userRePw': '',
    'userNick': '',
    'userAge': '',
    'userGender': '',
  };

  Widget _buildCustomTextField(
      double width, String label, String hint, bool isObscure, String key) {
    return CustomTextField(
      width: width,
      label: label,
      hint: hint,
      isObscure: isObscure,
      onChanged: (value) {
        _userData[key] = value;
      },
    );
  }

  bool _validateData() {
    // 비밀번호 일치 여부 확인
    if (_userData['userPw'] != _userData['userRePw']) {
      message = "패스워드가 일치하지 않습니다.";
      return false;
    }
    // 모든 입력란이 비어있지 않은지 확인
    for (String key in _userData.keys) {
      if (_userData[key]!.isEmpty) {
        message = "모든 정보를 채워주세요.";
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/backimg44.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 30),
                child: Container(
                  margin: const EdgeInsets.only(top: 70, left: 40, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLargeText(text: "SEB'S MUSIC", size: 40),
                      AppLargeText(text: "회원가입", color: Colors.white),
                      SizeBoxH30(),
                      _buildCustomTextField(
                          1, 'ID', '아이디를 입력하세요.', false, 'userId'),
                      SizeBoxH10(),
                      _buildCustomTextField(
                          1, 'PASSWORD', '패스워드를 입력하세요.', true, 'userPw'),
                      SizeBoxH10(),
                      _buildCustomTextField(1, 'RE PASSWORD', '패스워드를 다시 입력하세요.',
                          true, 'userRePw'),
                      SizeBoxH20(),
                      _buildCustomTextField(
                          1, '닉네임', '닉네임을 입력하세요.', false, 'userNick'),
                      SizeBoxH10(),
                      _buildCustomTextField(
                          1, '나이', '나이를 입력하세요.', false, 'userAge'),
                      SizeBoxH10(),
                      GenderSelector(
                        onGenderChanged: (value) {
                          _userData['userGender'] = value;
                        },
                      ),
                      SizeBoxH20(),
                      GestureDetector(
                        onTap: () async {
                          if (_validateData()) {
                            await UserSignUpService.signUp(
                              userId: _userData[
                                  'userId']!, // 이해를 돕기위해 작성함. userId는 UserSignUpService에 전달되는 매개변수입니다.즉 키.!는 널이 아니게 하기위해 넣었구요.
                              userPw: _userData['userPw']!, //
                              userNick: _userData['userNick']!,
                              userAge: _userData['userAge']!,
                              userGender: _userData['userGender']!,
                            );
                            Navigator.pop(context);
                            // 이전페이지로 일단 돌아가게 했는데, 경우에 따라 다르게도 가능함.
                          } else {
                            ShowToast(message);
                          }
                        },
                        child: LoginButton(width: 1, text: "확인"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
