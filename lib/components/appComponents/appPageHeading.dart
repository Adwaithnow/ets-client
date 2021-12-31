import 'package:flutter/material.dart';
import 'package:test_app/core/appData.dart';

class AppPageHeading extends StatelessWidget {
  const AppPageHeading({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      alignment: Alignment.bottomLeft,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black))),
      child: Text(
        title??'',
        style: const TextStyle(color: AppColors.secondary, fontSize: 22),
      ),
    );
  }
}
