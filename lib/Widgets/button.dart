import 'package:flutter/material.dart';
class Widgets extends StatelessWidget {
  const Widgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
Widget build3DTextField(String labelText, bool isPassword) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black38,
          offset: Offset(4, 4),
          blurRadius: 8,
        ),
        BoxShadow(
          color: Colors.black12,
          offset: Offset(-4, -4),
          blurRadius: 8,
        ),
      ],
    ),
    child: TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.blue),
        border: InputBorder.none,
      ),
    ),
  );
}