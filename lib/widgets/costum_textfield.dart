import 'package:flutter/material.dart';
import 'package:moviemania/styles.dart'; // Pastikan TextStyles sudah didefinisikan dengan benar di sini

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.controller,
    required this.textInputType,
    required this.textInputAction,
    required this.hint,
    this.isObscure = false,
    this.hasSuffix = false,
    this.onPressed,
    this.validator, // Tambahkan validator
    super.key,
  });

  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final String hint;
  final bool isObscure;
  final bool hasSuffix;
  final VoidCallback? onPressed;
  final String? Function(String?)? validator; // Validator tambahan

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: TextStyles.body, // Pastikan TextStyles.body sudah didefinisikan
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      obscureText: widget.isObscure,
      focusNode: _focusNode,
      validator:
          widget.validator, // Integrasikan validator ke dalam TextFormField
      decoration: InputDecoration(
        labelText: widget.hint, // Menambahkan label text
        labelStyle: TextStyles.body.copyWith(
          color: _focusNode.hasFocus
              ? AppColors.darkBlue
              : Colors.grey, // Warna label saat fokus
        ),
        filled: true, // Mengaktifkan pengisian warna latar belakang
        fillColor:
            Colors.grey[200], // Menetapkan warna latar belakang abu-abu muda
        suffixIcon: widget.hasSuffix
            ? IconButton(
                onPressed: widget.onPressed,
                icon: Icon(
                  widget.isObscure ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.darkBlue,
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: 1.0,
              color: AppColors
                  .darkGrey), // Pastikan AppColors.darkGrey sudah didefinisikan
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.0,
            color: AppColors.darkBlue, // Ubah warna border saat fokus
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        hintText: null, // Menghilangkan hint text
        hintStyle: TextStyles.body,
      ),
    );
  }
}
