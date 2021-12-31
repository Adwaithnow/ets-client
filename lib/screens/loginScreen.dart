import 'package:flutter/material.dart';
import 'package:test_app/components/appComponents/appButton.dart';
import 'package:test_app/components/appComponents/appInput.dart';
import 'package:test_app/core/appData.dart';
import 'package:test_app/network/authNetwork.dart';
import 'package:test_app/screens/homeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String summary = '', userId = '', password = '';
  bool isLoading = false;

  login() async {
    setState(() {
      isLoading = true;
    });
    AuthNetwork _anw = AuthNetwork();
    var result = await _anw.login(userId, password);
    setState(() {
      isLoading = false;
      summary = AppData.user.username ?? '...';
    });
    if (result == 'ok') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Center(child: Text("LOGIN")),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          // color: Colors.red,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppInputFiled(
                onChanged: (value) {
                  userId = value;
                }, // da one sec ippo varam ahda
                labelText: 'User Name',
                hintText: 'Enter Your Name',
              ),
              const SizedBox(
                height: 20,
              ),
              AppInputFiled(
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                labelText: 'password',
                hintText: 'Enter Your password',
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: isLoading
                    ? const CircularProgressIndicator(
                      backgroundColor: AppColors.background,
                      color: AppColors.primary,
                    )
                    : AppButton(
                      onPressed: login,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        child: Text('Login'),
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
