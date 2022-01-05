import 'package:flutter/material.dart';
import 'package:test_app/components/appComponents/appPageHeading.dart';
import 'package:test_app/core/appData.dart';
import 'package:test_app/models/summyModel.dart';

class SummyScreen extends StatelessWidget {
  const SummyScreen({Key? key, required this.summy}) : super(key: key);
  final Summy summy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppPageHeading(title: summy.title ?? 'Summary'),
            Container(
              margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.inputFill,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(summy.summary??''),
            ),
          ],
        ),
      ),
    );
  }
}
