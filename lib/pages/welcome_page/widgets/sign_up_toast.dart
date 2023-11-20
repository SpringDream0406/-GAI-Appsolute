import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void ShowToast(String massage) {
  Fluttertoast.showToast(
      msg: massage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 18.0);
}
