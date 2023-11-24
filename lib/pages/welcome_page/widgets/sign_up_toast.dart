import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void ShowToast(BuildContext context, String message) {
  final snackBar = SnackBar(
    margin: EdgeInsets.only(left: 30, right: 30, bottom: 40),
    padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
    backgroundColor: Colors.redAccent.withOpacity(0.9),
    duration: Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    content: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 10,
        ),
        Text(
          message,
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ],
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
