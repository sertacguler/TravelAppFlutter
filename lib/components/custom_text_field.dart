import 'package:flutter/material.dart';
import 'theme.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;

  CustomTextField({required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.black),
      ),
    );
  }
}
