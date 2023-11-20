import 'package:flutter/material.dart';
import 'package:flutter_test_project/widgets/sized_box_widgets.dart';

class LoginButton extends StatelessWidget {
  final double? width;
  final String text;
  final double circular;
  const LoginButton(
      {super.key, this.width = 1.7, required this.text, this.circular = 15});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      width: MediaQuery.of(context).size.width / width!,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple),
        color: Colors.black87,
        borderRadius: BorderRadius.circular(circular),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizeBoxW10(),
          Icon(
            Icons.double_arrow_rounded,
            color: Colors.white70,
          ),
        ],
      ),
    );
  }
}
