import 'package:flutter/material.dart';
import 'package:moviemania/styles.dart'; // Pastikan TextStyles dan AppColors sudah didefinisikan dengan benar di sini
import 'package:moviemania/widgets/costum_textfield.dart'; // Sesuaikan dengan lokasi file widget
import 'package:moviemania/screens/register_screens.dart'; // Import halaman RegisterScreens
import 'package:moviemania/screens/homescreen.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Menetapkan latar belakang menjadi putih
      appBar: AppBar(
        title: Text(
          "", // Jika ingin judul kosong, bisa dibiarkan kosong
          style: TextStyles.title, // Terapkan style pada Text widget
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors
            .darkBlue, // Mengubah warna teks pada AppBar menjadi sesuai
        automaticallyImplyLeading: false, // Menghilangkan tombol back
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/icons/Login_Ui.png'),
              const SizedBox(height: 16.0),
              Text(
                'Login to your account',
                style: TextStyles.title.copyWith(fontSize: 20.0),
              ),
              const SizedBox(height: 24.0),
              // Email
              CustomTextField(
                controller: emailController,
                hint: 'Email Address',
                textInputType: TextInputType.emailAddress,
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
              const SizedBox(
                  height: 24.0), // Jarak lebih besar untuk memisahkan elemen
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  // Navigasi ke halaman HomeScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                child: Text(
                  "Login",
                  style: TextStyles.title.copyWith(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                'Don\'t have an account?',
                style: TextStyles.body.copyWith(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0), // Menambahkan jarak antara teks
              TextButton(
                onPressed: () {
                  // Navigasi ke halaman RegisterScreens
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreens(),
                    ),
                  );
                },
                child: Text(
                  'Sign Up',
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
