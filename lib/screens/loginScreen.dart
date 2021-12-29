import 'package:flutter/material.dart';
import 'package:test_app/core/appData.dart';
import 'package:test_app/network/authNetwork.dart';
import 'package:test_app/screens/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String summary = '', userId = '', password = '';
  bool isLoading = false;
  // AppData appData = AppData();
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
        MaterialPageRoute(builder: (context) => home()),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("LOGIN")),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          // color: Colors.red,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                  hintText: 'Enter Your Name',
                ),
                onChanged: (value) {
                  userId = value;
                }, // da one sec ippo varam ahda
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password',
                  hintText: 'Enter Your password',
                ),
                onChanged: (value) {
                  password = value;
                }, // da one sec ippo varam ahda
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : MaterialButton(
                      color: Colors.cyanAccent,
                      onPressed: login,
                      child: const Text("Login"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
