import 'package:flutter/material.dart';
import 'package:flutter_test_project/pages/welcome_page/widgets/welcome_page_login_join_input.dart';
import 'package:flutter_test_project/services/sign_up_services.dart';
import 'package:flutter_test_project/widgets/app_large_text.dart';
import 'package:flutter_test_project/widgets/login_button.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';

import 'package:http/http.dart' as http;

class UserSignUpService {
  static Future<void> signUp({
    required String userId,
    required String userPw,
    required String userNick,
    required String userAge,
    required String userGender,
  }) async {
    // 서버 주소와 엔드포인트를 적절하게 설정
    final String serverUrl = 'http://192.168.70.65:3300';
    final String endpoint = '/user/join';

    // HTTP 요청 수행
    final response = await http.post(
      Uri.parse('$serverUrl$endpoint'),
      body: {
        'user_id': userId,
        'user_pw': userPw,
        'user_nick': userNick,
        'user_age': userAge,
        'user_gender': userGender,
      },
    );

    // 응답 처리
    if (response.statusCode == 200) {
      // 성공적으로 처리된 경우
      print('회원가입 성공');
    } else {
      // 실패한 경우
      print('회원가입 실패 - ${response.statusCode}');
    }
  }
}


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final Map<String, String> _userData = {
    'userId': '',
    'userPw': '',
    'userRePw': '',
    'userNick': '',
    'userAge': '',
    'userGender': '',
  };

  Widget _buildCustomTextField(
      String label, String hint, bool isObscure, String key) {
    return CustomTextField(
      label: label,
      hint: hint,
      isObscure: isObscure,
      onChanged: (value) {
        _userData[key] = value;
      },
    );
  }

  bool _validateData() {
    if (_userData['userPw'] != _userData['userRePw']) {
      print("패스워드가 일치하지 않습니다.");
      // 여기에 가입시키지 않을, 경우의 수를 넣어주면 됩니다.
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
              child: Container(
                margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppLargeText(text: "SEB'S MUSIC", size: 40),
                    AppLargeText(text: "회원가입", color: Colors.white),
                    SizeBoxH30(),
                    _buildCustomTextField('ID', '아이디를 입력하세요.', false, 'userId'),
                    SizeBoxH05(),
                    _buildCustomTextField(
                        'PASSWORD', '패스워드를 입력하세요.', true, 'userPw'),
                    SizeBoxH05(),
                    _buildCustomTextField(
                        'RE PASSWORD', '패스워드를 다시 입력하세요.', true, 'userRePw'),
                    SizeBoxH20(),
                    _buildCustomTextField(
                        '닉네임', '닉네임을 입력하세요.', false, 'userNick'),
                    SizeBoxH05(),
                    _buildCustomTextField('나이', '나이를 입력하세요.', false, 'userAge'),
                    SizeBoxH05(),
                    _buildCustomTextField(
                        '성별', '성별을 입력하세요.', false, 'userGender'),
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
                          // Navigator.pop(context);
                          // 이전페이지로 일단 돌아가게 했는데, 경우에 따라 다르게도 가능함.
                        }
                      },
                      child: LoginButton(text: "확인"),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_test_project/pages/welcome_page/widgets/welcome_page_login_join_input.dart';
// import 'package:flutter_test_project/services/sign_up_services.dart';
// import 'package:flutter_test_project/widgets/app_large_text.dart';
// import 'package:flutter_test_project/widgets/login_button.dart';
// import 'package:flutter_test_project/widgets/sized_box_widgets.dart';
//
// class SignUpPage extends StatelessWidget {
//   const SignUpPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     String userId = "";
//     String userPw = "";
//     String userRePw = "";
//     String userNick = "";
//     String userAge = "";
//     String userGender = "";
//
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Stack(
//         children: [
//           Positioned(
//             top: 0,
//             left: 0,
//             child: Container(
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               child: Container(
//                 width: double.maxFinite,
//                 height: double.maxFinite,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage("assets/backimg44.png"),
//                       fit: BoxFit.cover,
//                     )),
//                 child: Container(
//                   width: 500,
//                   height: MediaQuery.of(context).size.height,
//                   margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       AppLargeText(text: "SEB'S MUSIC", size: 40),
//                       AppLargeText(text: "회원가입", color: Colors.white),
//                       SizeBoxH30(),
//                       CustomTextField(
//                         label: 'ID',
//                         hint: '아이디를 입력하세요.',
//                         onChanged: (value) {
//                           userId = value;
//                         },
//                       ),
//                       SizeBoxH05(),
//                       CustomTextField(
//                         label: 'PASSWORD',
//                         hint: '패스워드를 입력하세요.',
//                         isObscure: true,
//                         onChanged: (value) {
//                           userPw = value;
//                         },
//                       ),
//                       SizeBoxH05(),
//                       CustomTextField(
//                         label: 'RE PASSWORD',
//                         hint: '패스워드를 다시 입력하세요.',
//                         isObscure: true,
//                         onChanged: (value) {
//                           userRePw = value;
//                         },
//                       ),
//                       SizeBoxH20(),
//                       CustomTextField(
//                         label: '닉네임',
//                         hint: '닉네임을 입력하세요.',
//                         onChanged: (value) {
//                           userNick = value;
//                         },
//                       ),
//                       SizeBoxH05(),
//                       CustomTextField(
//                         label: '나이',
//                         hint: '나이를 입력하세요.',
//                         onChanged: (value) {
//                           userAge = value;
//                         },
//                       ),
//                       SizeBoxH05(),
//                       CustomTextField(
//                         label: '성별',
//                         hint: '성별을 입력하세요.',
//                         onChanged: (value) {
//                           userGender = value;
//                         },
//                       ),
//                       SizeBoxH20(),
//                       GestureDetector(
//                         onTap: () async {
//                           // 유효성 검사, 비밀번호 일치 확인 등을 여기에 추가할 수 있습니다.
//                           if (userPw == userRePw) {
//                             await UserSignUpService.signUp(
//                               userId: userId,
//                               userPw: userPw,
//                               userNick: userNick,
//                               userAge: userAge,
//                               userGender: userGender,
//                             );
//                             Navigator.pop(context);
//                           } else {
//                             print("Passwords do not match");
//                           }
//                         },
//                         child: LoginButton(text: "확인"),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
