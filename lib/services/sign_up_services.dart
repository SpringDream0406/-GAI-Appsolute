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
    var url =
        Uri.parse('http://192.168.70.65:3300/user/join'); // HTTPS URL로 변경해야 함~~

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

class UserLoginService {
  static var lastResponseBody;

  static Future<void> login({
    required String userId,
    required String userPw,
  }) async {
    var url = Uri.parse(
        'http://192.168.70.65:3300/user/Login'); // HTTPS URL로 변경해야 함~~

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        // headers: {'Accept': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'user_pw': userPw,
        }),
      );

      if (response.statusCode == 200) {
        lastResponseBody = response.body;
      } else {
        print('로그인 실패.,');
      }
    } catch (e) {
      print("에러 원인 :  " + e.toString());
    }
  }

  Future<DataModel> getDataModel() async {
    try {
      if (lastResponseBody != null) {
        Map<String, dynamic> jsonData = jsonDecode(lastResponseBody);

        return DataModel.fromJson(jsonData);
      } else {
        print("아무거나222");
        return DataModel(
            user: User(played: [], liked: [], singer: []),
            recommen: Recommen(condition: [], emotion: [], time: []));
      }
    } catch (e) {
      print(e);
      return DataModel(
          user: User(played: [], liked: [], singer: []),
          recommen: Recommen(condition: [], emotion: [], time: []));
    }
  }
}
