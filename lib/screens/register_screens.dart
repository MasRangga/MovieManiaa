import 'package:flutter/material.dart';
import 'package:moviemania/styles.dart'; // Pastikan TextStyles dan AppColors sudah didefinisikan dengan benar di sini
import 'package:moviemania/widgets/costum_textfield.dart'; // Sesuaikan dengan lokasi file widget
import 'package:moviemania/screens/login_screens.dart'; // Import halaman LoginScreens

class RegisterScreens extends StatefulWidget {
  const RegisterScreens({super.key});

  @override
  State<RegisterScreens> createState() => _RegisterScreensState();
}

class _RegisterScreensState extends State<RegisterScreens> {
  final emailController = TextEditingController();
  final usernameController =
      TextEditingController(); // Controller untuk Username
  final passwordController = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Menetapkan latar belakang menjadi putih
      appBar: AppBar(
        title: Text(
          "",
          style: TextStyles.title, // Terapkan style pada Text widget
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Menghilangkan tombol back
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/icons/Register_Ui.png'),
              const SizedBox(height: 16.0),
              Text(
                'Register to your account',
                style: TextStyles.title.copyWith(fontSize: 20.0),
              ),
              const SizedBox(height: 24.0),
              // Email
              CustomTextField(
                controller: emailController,
                hint: 'Enter your email address',
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16.0),
              // Username
              CustomTextField(
                controller: usernameController,
                hint: 'Enter your username', // Placeholder teks untuk Username
                textInputType: TextInputType.text, // Jenis input teks biasa
                textInputAction: TextInputAction.next,
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
              ),
              const SizedBox(height: 8.0),

              // Tombol Register
              const SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Register",
                  style: TextStyles.title.copyWith(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                'Already have an account?',
                style: TextStyles.body.copyWith(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  // Navigasi ke halaman LoginScreens
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreens(),
                    ),
                  );
                },
                child: Text(
                  'Sign In',
                  style: TextStyles.body.copyWith(
                    fontSize: 18.0,
                    color: AppColors.darkBlue,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
