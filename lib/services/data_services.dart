import 'dart:convert';

import 'package:flutter_test_project/models/test_model.dart';
import 'package:http/http.dart' as http;

class DataServices {
  // AppCubits로 던집니다.
  String baseurl = "https://jsonplaceholder.typicode.com/users";

  Future<List<TestModel>> getInfo() async {
    // var apiurl = "20120101";
    http.Response res = await http.get(Uri.parse(baseurl));
    try {
      if (res.statusCode == 200) {
        List<dynamic> list = json.decode(res.body);
        // 사용법 - 작성자 : 이찬용
        // 파싱할 Url을 위에 작성해줍니다.
        // model 의 data_model 으로 이동.

        // 그럼 아래서 map함수로, 가져옵니다.
        return list.map((e) => TestModel.fromJson(e)).toList();
      } else {
        // 데이터가 없으면 빈 목록이 반환돼용.
        return <TestModel>[];
      }
    } catch (e) {
      print(e);
      return <TestModel>[];
    }
  }
}
