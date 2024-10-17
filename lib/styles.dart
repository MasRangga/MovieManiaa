import 'package:flutter/material.dart';

class AppColors {
  static const Color darkGrey = Color(0xFF635C5C);
  static const Color darkBlue = Color.fromARGB(239, 4, 0, 255);
}

class TextStyles {
  static TextStyle title = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: AppColors.darkGrey
  );

  static TextStyle body = TextStyle(
      fontFamily: 'Outfit',
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: AppColors.darkGrey);
}

  