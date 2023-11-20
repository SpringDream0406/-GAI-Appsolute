import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isObscure;
  final IconData? icon;
  final Function(String) onChanged;
  final double? width;
  final int? maxLength;

  const CustomTextField(
      {Key? key,
      this.maxLength = 12,
      this.width = 1.7,
      required this.label,
      required this.hint,
      this.isObscure = false,
      required this.onChanged,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / width!,
      height: 50,
      child: TextField(
        maxLength: maxLength,
        obscureText: isObscure,
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.bottom,
        style: TextStyle(
            color: Colors.white, fontSize: 18, decorationThickness: 0),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.black54,
          labelText: label,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white),
          labelStyle: TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
