import 'Screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart' as constants;
import 'screens/Onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final int total = 60;
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: constants.pageColor, body: SplashScreen()));
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  void checkTokens(BuildContext context) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      String? refreshToken = prefs.getString('refreshToken');

      if (accessToken != null && refreshToken != null) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Home(),
        ));
      } else {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const OnBoarding(),
        ));
      }
    }


  @override
  Widget build(BuildContext context) {
    checkTokens(context);
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: constants.pageColor,
            body: CircularProgressIndicator()));
  }
}
