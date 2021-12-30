import 'package:flutter/material.dart';

class AppInputFiled extends StatelessWidget {
  const AppInputFiled({Key? key, required this.onChanged, this.labelText, this.hintText}) : super(key: key);

  final Function(String) onChanged;
  final String? labelText;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Theme.of(context).backgroundColor.withBlue(100).withGreen(100).withRed(100),
        filled: true,
        //labelText: labelText ?? '',
        hintText: hintText ?? '',
      ),
      onChanged: onChanged,
    );
  }
}
