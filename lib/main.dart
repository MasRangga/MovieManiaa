import 'package:flutter/material.dart';
import 'package:moviemania/screens/welcome_screens.dart';
import 'package:moviemania/widgets/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinema Collection',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreenWithDelay(),
    );
  }
}

class SplashScreenWithDelay extends StatelessWidget {
  const SplashScreenWithDelay({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 4)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else {
          return const GetStartedScreens();
        }
      },
    );
  }
}
