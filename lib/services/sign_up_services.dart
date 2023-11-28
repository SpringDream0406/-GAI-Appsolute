import 'package:flutter_test_project/globals/globals.dart';
import 'package:flutter_test_project/models/data_model.dart';
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
    var url = Uri.parse('${GlobalConfig.apiEndpoint}/user/join');

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'user_pw': userPw,
          'user_nick': userNick,
          'user_age': userAge,
          'user_gender': userGender,
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

class LoginResult {
  final bool success;
  final String message;

  LoginResult({required this.success, this.message = ''});
}

class UserLoginService {
  static var lastResponseBody;

  static Future<LoginResult> login({
    required String userId,
    required String userPw,
  }) async {
    var url = Uri.parse('${GlobalConfig.apiEndpoint}/user/login');
    print(url);

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'user_pw': userPw,
        }),
      );

      if (response.statusCode == 200) {
        lastResponseBody = response.body;
        return LoginResult(success: true);
      } else {
        return LoginResult(success: false, message: response.body);
      }
    } catch (e) {
      print('에러 원인: ${e.toString()}');
      return LoginResult(success: false, message: '에러 원인: ${e.toString()}');
    }

    return LoginResult(success: false, message: '알 수 없는 오류 발생');
  }

  Future<DataModel> getDataModel() async {
    try {
      if (lastResponseBody != null) {
        Map<String, dynamic> jsonData = jsonDecode(lastResponseBody!);

        return DataModel.fromJson(jsonData);
      } else {
        print("아무거나222");
        return DataModel(
            user: User(played: [], liked: [], singer: []),
            recommend: Recommend(activity: [], emotion: [], time: []));
      }
    } catch (e) {
      print(e);
      return DataModel(
          user: User(played: [], liked: [], singer: []),
          recommend: Recommend(activity: [], emotion: [], time: []));
    }
  }
}
