import 'package:flutter/material.dart';
import 'theme.dart'; // Doğru dosya yolu olduğundan emin olun

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.orange,  // 'primary' yerine 'backgroundColor'
        foregroundColor: AppColors.white,    // 'onPrimary' yerine 'foregroundColor'
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
    );
  }
}
