import 'package:flutter/material.dart';
import 'package:test_app/screens/home.dart';
import 'package:test_app/screens/loginScreen.dart';

void main() {
  runApp(MaterialApp(
    title: "Simple",
    home: LoginScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
