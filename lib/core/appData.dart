import 'package:test_app/models/userModel.dart';
import 'package:test_app/themes/themeManager.dart';

class AppData {
  //static String baseURL = 'http://192.168.1.5:3000';
  static String baseURL = 'http://ec2-3-142-145-43.us-east-2.compute.amazonaws.com:3000';
  static ThemeManager themeManager = ThemeManager();
  static User user = User();
}
