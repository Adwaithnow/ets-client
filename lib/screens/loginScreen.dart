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
      appBar: AppBar(
        title: const Center(child: Text("LOGIN")),
        actions: [
          IconButton(
            onPressed: () => AppData.themeManager.toggleTheme(
              AppData.themeManager.themeMode != ThemeMode.dark),
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
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                  hintText: 'Enter Your Name',
                ),
                onChanged: (value) {
                  userId = value;
                }, // da one sec ippo varam ahda
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password',
                  hintText: 'Enter Your password',
                ),
                onChanged: (value) {
                  password = value;
                }, // da one sec ippo varam ahda
              ),
              isLoading
                  ? const CircularProgressIndicator()
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
