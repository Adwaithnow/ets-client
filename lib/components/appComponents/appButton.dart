import 'package:flutter/material.dart';
import 'package:test_app/core/appData.dart';

class AppButton extends StatelessWidget {
  const AppButton({Key? key, required this.onPressed, this.child}) : super(key: key);

  final VoidCallback onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child ?? const Text("OK"),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.primary),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(800),
            //side: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
