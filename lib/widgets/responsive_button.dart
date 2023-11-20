import 'package:flutter/material.dart';
import 'package:flutter_test_project/widgets/app_text.dart';

class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;
  final Color? color;
  final String? text;
  Icon? icon;
  ResponsiveButton(
      {super.key,
      this.text,
      this.color,
      this.width = 120,
      this.isResponsive = false,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
      width: isResponsive == true ? double.infinity : width,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: color == null ? Colors.white70 : color),
      child: Row(
        mainAxisAlignment: isResponsive == true
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          isResponsive == true
              ? Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: AppText(text: text.toString()))
              : Container(),
          Icon(
            Icons.double_arrow_rounded,
            size: 40,
            color: Colors.white,
          )
        ],
      ),
    ));
  }
}
