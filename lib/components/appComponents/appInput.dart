import 'package:flutter/material.dart';
import 'package:test_app/core/appData.dart';

class AppInputFiled extends StatelessWidget {
  const AppInputFiled({
    Key? key,
    required this.onChanged,
    this.hintText,
    this.obscureText,
    this.maxLines,
  }) : super(key: key);

  final Function(String) onChanged;
  final String? hintText;
  final bool? obscureText;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      maxLines: maxLines ?? 1,
      obscureText: obscureText ?? false,
      textAlign: TextAlign.center,
      style: const TextStyle(color: AppColors.tertiary),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.inputFill,
          hintText: hintText ?? '',
          hintStyle: const TextStyle(color: AppColors.tertiary)),
    );
  }
}
