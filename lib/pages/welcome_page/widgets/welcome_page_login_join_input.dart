import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isObscure;
  final IconData? icon;
  final Function(String) onChanged;

  const CustomTextField(
      {Key? key,
      required this.label,
      required this.hint,
      this.isObscure = false,
      required this.onChanged,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.7,
      height: 50,
      child: TextField(
        obscureText: isObscure,
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black54,
          labelText: label,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white),
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
