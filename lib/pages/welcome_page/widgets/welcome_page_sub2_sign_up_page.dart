import 'package:flutter/material.dart';
import 'package:flutter_test_project/pages/welcome_page/widgets/signup_page.dart';
import 'package:flutter_test_project/widgets/app_large_text.dart';
import 'package:flutter_test_project/widgets/login_button.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';

class CustomSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppLargeText(text: "인공지능 성향분석"),
        AppLargeText(text: "음악추천 플레이어"),
        AppLargeText(text: "SEB'S MUSIC", size: 40, color: Colors.white),
        SizeBoxH40(),
        AppLargeText(text: "회원가입", size: 28, color: Colors.white),
        SizeBoxH30(),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    SignUpPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

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
          width: MediaQuery.of(context).size.width / 1.7,
          height: 50,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/kakao_login_large_narrow.png"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.withOpacity(0.5)),
        ),
        SizeBoxH15(),
        Container(
          width: MediaQuery.of(context).size.width / 1.7,
          height: 50,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/google_login.png"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.withOpacity(0.9)),
        ),
        SizeBoxH15(),
        Container(
          width: MediaQuery.of(context).size.width / 1.7,
          height: 50,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/naver_login.png"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.withOpacity(0.9)),
        ),
      ],
    );
  }
}
