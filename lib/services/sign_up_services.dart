import 'package:http/http.dart' as http;
import 'dart:convert';

class UserSignUpService {
  static Future<void> signUp({
    required String userId,
    required String userPw,
    required String userNick,
    required String userAge,
    required String userGender,
  }) async {
    var url =
        Uri.parse('http://192.168.70.65:3300/user/join'); // HTTPS URL로 변경해야 함~~

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'password': userPw,
          'nickname': userNick,
          'age': userAge,
          'gender': userGender,
        }),
      );

      if (response.statusCode == 200) {
        print('가입성공');
      } else {
        print('가입실패,');
      }
    } catch (e) {
      print("에러 원인 :  " + e.toString());
    }
  }
}
