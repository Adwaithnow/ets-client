import 'package:flutter/material.dart';
import 'package:test_app/core/appData.dart';

class FabButton extends StatelessWidget {
  const FabButton({Key? key, this.icon, required this.onPressed})
      : super(key: key);

  final Widget? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: onPressed, heroTag: null, child: icon ?? const Icon(Icons.check));
  }
}
