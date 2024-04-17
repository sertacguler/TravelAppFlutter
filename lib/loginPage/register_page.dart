import 'package:flutter/material.dart';
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';
import '../components/theme.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomTextField(hintText: "Email"),
              SizedBox(height: 20),
              CustomTextField(hintText: "Password"),
              SizedBox(height: 20),
              CustomTextField(hintText: "Confirm Password"),
              SizedBox(height: 40),
              CustomButton(
                text: "Register",
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');  // Adjust the route as needed
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/login'),
                child: Text(
                  "Already have an account? Login here",
                  style: TextStyle(color: AppColors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
