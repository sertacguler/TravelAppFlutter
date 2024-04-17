import 'package:flutter/material.dart';

import 'splashPage/splash_screen.dart';

import 'loginPage/login_page.dart';    // Import for LoginPage
import 'loginPage/register_page.dart'; // Import for RegisterPage
import 'loginPage/reminder_page.dart'; // Import for ReminderPage

import 'components/theme.dart';

import 'pages/home_page.dart';
import 'pages/station_list_page.dart';
import 'pages/place_list_page.dart';
import 'pages/map_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Travel App',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => SplashScreen());
          case '/login':
            return MaterialPageRoute(builder: (_) => LoginPage());
          case '/register':
            return MaterialPageRoute(builder: (_) => RegisterPage());
          case '/reminder':
            return MaterialPageRoute(builder: (_) => ReminderPage());
          case '/home':
            return MaterialPageRoute(builder: (_) => HomePage());
          case '/stationList':
            final String placeId = settings.arguments as String;
            return MaterialPageRoute(builder: (_) => StationListPage(placeId: placeId));
          case '/placeList':
            return MaterialPageRoute(builder: (_) => PlaceListPage());
          case '/mapPage':
            final args = settings.arguments as Map<String, dynamic>?;
            double? lat = args?['latitude'];
            double? lng = args?['longitude'];
            String pId = args?['placeId'];
            return MaterialPageRoute(
              builder: (_) => MapPage(
                placeId: pId,
                initialLat: lat,
                initialLng: lng,
              ),
            );
          default:
            return MaterialPageRoute(builder: (_) => SplashScreen());
        }
      },
    );
  }
}
