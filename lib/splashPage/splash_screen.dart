import 'package:flutter/material.dart';
import '../components/theme.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/login');
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Travel.',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.5 / "Travel.".length * 2,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '.',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.5 / "Travel.".length * 2,
                color: AppColors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
