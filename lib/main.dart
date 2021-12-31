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
      title: "Simple",
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
    );
  }
}

/*

  final TextStyle _textStyle = const TextStyle(color: AppColors.secondary);
.copyWith(
        textTheme: TextTheme(
          bodyText1: _textStyle,
          bodyText2: _textStyle,
          headline1: _textStyle,
          headline2: _textStyle,
          headline3: _textStyle,
          headline4: _textStyle,
          headline5: _textStyle,
          headline6: _textStyle,
          overline: _textStyle,
          subtitle1: _textStyle,
          subtitle2: _textStyle,
          caption: _textStyle,
          button: _textStyle,
        ),
      ),

      */