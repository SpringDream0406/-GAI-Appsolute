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
    'userGender': 'M',
  };

  bool hasValidIdLength = false;
  bool hasSpecialCharacter = false;
  bool hasUpperCase = false;
  bool hasValidLength = false;

  // 아이디 조건식
  Widget _buildIdRequirements(String id) {
    hasValidIdLength = id.length >= 4 && id.length <= 12;

    return Column(
      children: [
        SizeBoxH05(),
        Container(
          height: 30,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
              color: Colors.black54, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              _buildRequirementText("ID는 4글자 이상 ,  12글자 이하", hasValidIdLength),
            ],
          ),
        ),
      ],
    );
  }

  // 패스워드 조건식
  Widget _buildPasswordRequirements(String password) {
    hasSpecialCharacter = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    hasValidLength = password.length >= 8 && password.length <= 20;

    return Column(
      children: [
        SizeBoxH05(),
        Container(
          height: 30,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
              color: Colors.black54, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              _buildRequirementText("특수문자", hasSpecialCharacter),
              Text(" ,  ", style: TextStyle(color: Colors.white)),
              _buildRequirementText("대소문자", hasUpperCase),
              Text(" ,  ", style: TextStyle(color: Colors.white)),
              _buildRequirementText("8자 이상 - 20자 이하", hasValidLength),
            ],
          ),
        ),
      ],
    );
  }

  // 패스워드 일치 조건식
  Widget _buildPasswordMatchInfo() {
    String userPw = _userData['userPw'] ?? '';
    String userRePw = _userData['userRePw'] ?? '';

    String message;
    Color textColor;

    if (userRePw.isEmpty) {
      message = "패스워드를 재입력해주세요.";
      textColor = Colors.white;
    } else if (userPw == '') {
      message = "패스워드 먼저 입력해주세요.";
      textColor = Colors.red;
    } else if (userPw == userRePw) {
      message = "패스워드가 일치합니다.";
      textColor = Colors.green;
    } else {
      message = "패스워드가 일치하지 않습니다.";
      textColor = Colors.red;
    }

    return Column(
      children: [
        SizeBoxH05(),
        Container(
          height: 30,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 15, top: 5),
          decoration: BoxDecoration(
              color: Colors.black54, borderRadius: BorderRadius.circular(10)),
          child: Text(
            message,
            style: TextStyle(color: textColor),
          ),
        ),
      ],
    );
  }

  // 컬러 바꾸는 위젯.
  Widget _buildRequirementText(String text, bool isValid) {
    return Text(
      text,
      style: TextStyle(color: isValid ? Colors.green : Colors.red),
    );
  }

  Widget _buildCustomTextField(
      double width, String label, String hint, bool isObscure, String key) {
    return Column(
      children: [
        CustomTextField(
          width: width,
          label: label,
          hint: hint,
          isObscure: isObscure,
          onChanged: (value) {
            setState(() {
              _userData[key] = value;
              if (key == 'userPw') {
                // 비밀번호 필드가 변경될 때
                _buildPasswordRequirements(value);
              }
              if (key == 'userId') {
                // 아이디 필드가 변경될 때
                _buildIdRequirements(value);
              }
            });
          },
        ),
        if (key == 'userPw') _buildPasswordRequirements(_userData[key] ?? ''),
        if (key == 'userRePw') _buildPasswordMatchInfo(),
        // 비밀번호 재입력 필드에 대한 처리 추가
        if (key == 'userId') _buildIdRequirements(_userData[key] ?? ''),
      ],
    );
  }

  bool _validateData() {
    // 모든 입력란이 비어있지 않은지 확인
    for (String key in _userData.keys) {
      if (_userData[key]!.isEmpty) {
        message = "모든 정보를 채워주세요.";
        return false;
      }
    }

    // 아이디 길이 검증
    String? userId = _userData['userId'];
    if (userId == null || userId.length < 4 || userId.length > 12) {
      message = "아이디는 4자 이상 12자 이하로 설정해주세요.";
      return false;
    }

    // 비밀번호 길이 검증
    String? userPw = _userData['userPw'];
    if (userPw == null || userPw.length < 8 || userPw.length > 20) {
      message = "비밀번호는 8자 이상 20자 이하로 설정해주세요.";
      return false;
    }

    // 비밀번호에 특수 문자가 포함되어 있는지 확인
    if (!userPw.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      message = "비밀번호에는 특수 문자가 포함되어야 합니다.";
      return false;
    }

    // 비밀번호에 대문자가 포함되어 있는지 확인
    if (!userPw.contains(RegExp(r'[A-Z]'))) {
      message = "비밀번호에는 대문자가 포함되어야 합니다.";
      return false;
    }

    // 비밀번호 일치 여부 확인
    if (_userData['userPw'] != _userData['userRePw']) {
      message = "패스워드가 일치하지 않습니다.";
      return false;
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
                      SizeBoxH10(),
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
                              userId: _userData['userId']!,
                              // 이해를 돕기위해 작성함. userId는 UserSignUpService에 전달되는 매개변수입니다.즉 키.!는 널이 아니게 하기위해 넣었구요.
                              userPw: _userData['userPw']!, //
                              userNick: _userData['userNick']!,
                              userAge: _userData['userAge']!,
                              userGender: _userData['userGender']!,
                            );
                            Navigator.pop(context);
                            // 이전페이지로 일단 돌아가게 했는데, 경우에 따라 다르게도 가능함.
                          } else {
                            ShowToast(context, message);
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
