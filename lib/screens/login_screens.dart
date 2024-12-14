import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviemania/styles.dart'; // Sesuaikan dengan lokasi styles.dart
import 'package:moviemania/screens/homescreen.dart'; // Sesuaikan dengan lokasi homescreen.dart
import 'package:moviemania/screens/register_screens.dart'; // Sesuaikan dengan lokasi register_screens.dart
import 'package:moviemania/widgets/costum_textfield.dart'; // Sesuaikan dengan lokasi costum_textfield.dart

class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;
  bool isLoading = false; // Flag untuk menampilkan indikator loading
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>(); // Key untuk validasi form

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      // Jika validasi gagal
      return;
    }

    setState(() {
      isLoading = true; // Menampilkan indikator loading
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } catch (e) {
      setState(() {
        isLoading = false; // Menyembunyikan indikator loading
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Login Failed"),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login", style: TextStyles.title),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.darkBlue,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/icons/Login_Ui.png'),
              const SizedBox(height: 16.0),
              Text('Login to your account',
                  style: TextStyles.title.copyWith(fontSize: 20.0)),
              const SizedBox(height: 24.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Email
                    CustomTextField(
                      controller: emailController,
                      hint: 'Email Address',
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // Cek format email
                        String pattern = r'\w+@\w+\.\w+';
                        RegExp regExp = RegExp(pattern);
                        if (!regExp.hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    // Password
                    CustomTextField(
                      controller: passwordController,
                      hint: 'Password',
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      isObscure: isObscure,
                      hasSuffix: true,
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      onPressed: isLoading
                          ? null
                          : _login, // Disable button when loading
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white) // Show loading indicator
                          : Text("Login",
                              style: TextStyles.title.copyWith(
                                  fontSize: 20.0, color: Colors.white)),
                    ),
                    const SizedBox(height: 24.0),
                    Text("Don't have an account?",
                        style: TextStyles.body.copyWith(fontSize: 18.0),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 8.0),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreens()),
                        );
                      },
                      child: Text('Sign Up',
                          style: TextStyles.body.copyWith(
                              fontSize: 18.0, color: AppColors.darkBlue),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
