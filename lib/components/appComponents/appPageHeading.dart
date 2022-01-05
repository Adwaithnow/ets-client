import 'package:flutter/material.dart';
import 'package:test_app/core/appData.dart';

class AppPageHeading extends StatelessWidget {
  const AppPageHeading({Key? key, this.title, this.automaticallyImplyBack = true}) : super(key: key);
  final String? title;
  final bool automaticallyImplyBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      alignment: Alignment.bottomLeft,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black))),
      child: Row(
        children: [
          !automaticallyImplyBack ? const SizedBox() : IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back)),
          Text(
            title ?? '',
            style: const TextStyle(color: AppColors.secondary, fontSize: 22),
          ),
        ],
      ),
    );
  }
}
