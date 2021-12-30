import 'package:flutter/material.dart';
import 'package:test_app/core/appData.dart';
import 'package:test_app/screens/loginScreen.dart';
import 'package:test_app/themes/darkTheme.dart';
import 'package:test_app/themes/lightTheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    AppData.themeManager.addListener(themeManagerListener);
    super.initState();
  }

  @override
  void dispose() {
    AppData.themeManager.removeListener(themeManagerListener);
    super.dispose();
  }

  themeManagerListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Simple",
      home: const LoginScreen(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: AppData.themeManager.themeMode,
      debugShowCheckedModeBanner: false,
    );
  }
}
