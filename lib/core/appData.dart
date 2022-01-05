import 'package:flutter/material.dart';
import 'package:test_app/models/summyModel.dart';
import 'package:test_app/models/userModel.dart';

class AppData {
  //static String baseURL = 'http://192.168.1.5:3000';
  static String baseURL =
      'http://ec2-3-142-145-43.us-east-2.compute.amazonaws.com:3000';
  static User user = User();
  static String mysummary = '';
  static String myextracted = '';
  static List<Summy> summyHistory = [];
}

class AppColors {
  static const background = Color(0xff14181b);
  static const primary = Color(0xff00968a);
  static const secondary = Color(0xffffffff);
  static const tertiary = Color(0xff9d9e9f);
  static const inputFill = Color(0xff111417);
}
