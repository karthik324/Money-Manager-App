import 'dart:async';
import 'package:flutter/material.dart';
import 'package:money_manager_app/main.dart';
import 'package:money_manager_app/screens/login/screen_login.dart';
import 'package:money_manager_app/screens/onboarding/screen_onboardings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int? initScreen;
  String finalName = '';
  @override
  initState() {
    super.initState();
    // getValidationData();
    // Timer(
    //     Duration(seconds: 3),
    //     () => Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) =>
    //                 finalName == null ? LoginScreen() : HomeScreen())));
    onboardingOrLogin();
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // initScreen = await preferences.getInt('initScreen');
    // await preferences.setInt('initScreen', 1);
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: ((context) => initScreen == 0 || initScreen == null
              ? const OnboardingScreen1()
              : const LoginScreen()),
        ),
      ),
    );
  }

  onboardingOrLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    initScreen = preferences.getInt('initScreen');
    await preferences.setInt('initScreen', 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Image.asset('assets/images/splash.jpeg'),
            Text(
              'FIN Trac',
              style: TextStyle(fontSize: 25, fontWeight: bold),
            ),
            const Spacer(),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
