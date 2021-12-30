import 'package:flutter/material.dart';
import 'package:test_app/components/appComponents/appButton.dart';
import 'package:test_app/components/appComponents/appInput.dart';
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
        MaterialPageRoute(builder: (context) => const home()),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Center(child: Text("LOGIN")),
        actions: [
          IconButton(
            onPressed: () => AppData.themeManager
                .toggleTheme(AppData.themeManager.themeMode != ThemeMode.dark),
            icon: AppData.themeManager.themeMode == ThemeMode.dark
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode),
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
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
                height: 10,
              ),
              AppInputFiled(
                onChanged: (value) {
                  password = value;
                }, // da one sec ippo varam ahda
                labelText: 'password',
                hintText: 'Enter Your password',
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: isLoading
                    ? CircularProgressIndicator(
                      backgroundColor: Theme.of(context).backgroundColor,
                      color: Theme.of(context).primaryColor,
                    )
                    : AppButton(
                      onPressed: login,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
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
