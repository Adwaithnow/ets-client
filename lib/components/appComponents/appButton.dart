import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  AppButton({Key? key, required this.onPressed, this.child}) : super(key: key);

  final VoidCallback onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child ?? const Text("OK"),
      style: ButtonStyle(
        backgroundColor:
            Theme.of(context).elevatedButtonTheme.style?.backgroundColor,
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
