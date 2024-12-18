import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moviemania/screens/homescreen.dart';
import 'package:moviemania/widgets/splash_screen.dart'; // Widget SplashScreen
import 'package:moviemania/screens/welcome_screens.dart'; // Halaman WelcomeScreens

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Mania',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreenWithDelay(),
    );
  }
}

class SplashScreenWithDelay extends StatelessWidget {
  const SplashScreenWithDelay({Key? key}) : super(key: key);

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen(); // Menampilkan SplashScreen saat loading
        } else {
          return const GetStartedScreens(); // Setelah SplashScreen, tampilkan WelcomeScreens
        }
      },
    );
  }
}
