import 'package:flutter/material.dart';
import 'package:test_app/screens/loginScreen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ETS",
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
    );
  }
}