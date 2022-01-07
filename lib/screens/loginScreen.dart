import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_app/components/appComponents/appButton.dart';
import 'package:test_app/components/appComponents/appInput.dart';
import 'package:test_app/core/appData.dart';
import 'package:test_app/network/authNetwork.dart';
import 'package:test_app/screens/homeScreen.dart';
import 'package:test_app/screens/registerationScreen.dart';

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
    var mq = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Container(
            height: mq * 0.4,
            width: mq,
            margin: EdgeInsets.only(top: mq * 0.1),
            padding: EdgeInsets.all(mq * 0.1),
            //color: Colors.red,
            child: Center(child: Image.asset('images/ETSLOGO.png')),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Container(
                  //  //width: 100,
                  //  height: 400,
                  //  color: Colors.red,
                  //  child: Center(
                  //    child: Container(
                  //      color: Colors.green,
                  //      child: SvgPicture.asset(
                  //        "images/ETSLOGO2.svg",
                  //        //width: 100,
                  //        //height: 100,
                  //      ),
                  //    ),
                  //  ),
                  //),
                  AppInputFiled(
                    onChanged: (value) {
                      userId = value;
                    },
                    hintText: 'Enter User Name',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppInputFiled(
                    onChanged: (value) {
                      password = value;
                    },
                    obscureText: true,
                    hintText: 'Enter Your Password',
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: Text('Login'),
                            ),
                          ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const RegistrationScreen(),
                    )),
                    child: const Text("Don't have an account ?"),
                  ),
                  // Container(
                  //   child:SvgPicture.asset("images/ETSLOGO.svg")
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
