import 'package:flutter/material.dart';
import 'package:test_app/core/appData.dart';

class AppPageHeading extends StatelessWidget {
  AppPageHeading(
      {Key? key,
      this.title,
      this.prefix,
      this.suffix,
      this.automaticallyImplyBack = true})
      : super(key: key);
  Widget? prefix;
  final String? title;
  final Widget? suffix;
  final bool automaticallyImplyBack;

  @override
  Widget build(BuildContext context) {
    Widget backBtn = IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back),
    );
    prefix = prefix ?? backBtn;
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      alignment: Alignment.bottomLeft,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          prefix ?? const SizedBox(),
          Text(
            title ?? '',
            style: const TextStyle(color: AppColors.secondary, fontSize: 22),
          ),
          suffix ?? const SizedBox(),
        ],
      ),
    );
  }
}
