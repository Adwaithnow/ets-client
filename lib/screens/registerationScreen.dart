import 'package:flutter/material.dart';
import 'package:test_app/components/appComponents/appButton.dart';
import 'package:test_app/components/appComponents/appInput.dart';
import 'package:test_app/core/appData.dart';
import 'package:test_app/network/authNetwork.dart';
import 'package:test_app/screens/homeScreen.dart';
import 'package:test_app/screens/loginScreen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String 
    errorText = '',
    userId = '',
    email = '',
    password = '',
    confirmpassword = '';
  bool isLoading = false, showError = false;

  register() async {
    setState(() {
      isLoading = true;
      showError = false;
      errorText = '';
    });
    if(password != confirmpassword){
    setState(() {
      isLoading = false;
      showError = true;
      errorText = 'Passwords do not match!!';
    });
    }
    AuthNetwork _anw = AuthNetwork();
    var result = await _anw.register(email, userId, password);
    setState(() {
      isLoading = false;
    });
    if (result == 'ok') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              !showError
                ? const SizedBox()
                : Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.errorColor)
                  ),
                  child: Text(
                    errorText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.errorColor),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
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
                  email = value;
                },
                hintText: 'Enter Your Email',
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
              const SizedBox(
                height: 20,
              ),
              AppInputFiled(
                onChanged: (value) {
                  confirmpassword = value;
                },
                obscureText: true,
                hintText: 'Confirm Your Password',
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: isLoading
                    ? const CircularProgressIndicator(
                        backgroundColor: AppColors.background,
                        color: AppColors.primary,
                      )
                    : AppButton(
                        onPressed: register,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: Text('Register'),
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
