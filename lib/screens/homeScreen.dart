import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:test_app/components/appComponents/appPageHeading.dart';
import 'package:test_app/core/appData.dart';
import 'package:test_app/network/summyNetwork.dart';
import 'package:test_app/screens/textInputScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  uploadFile() async {
    setState(() {
      isLoading = true;
    });
    FilePickerResult? _pickedFile = await FilePicker.platform.pickFiles();
    if (_pickedFile == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    File file = File(_pickedFile.files.single.path ?? '');
    SummyNetwork _smynw = SummyNetwork();
    var result = await _smynw.uploadFile(file);
    setState(() {
      isLoading = false;
    });
    if (result == 'ok') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TextInputScreen(showResult: true,)),
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
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            HomeButton(
              name: 'TEXT',
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TextInputScreen(),
                  )),
            ),
            const SizedBox(width: 20),
            isLoading
                ? FloatingActionButton(
                    onPressed: () {},
                    heroTag: null,
                    backgroundColor: AppColors.primary,
                    child: const CircularProgressIndicator(
                      backgroundColor: AppColors.primary,
                      color: AppColors.secondary,
                    ),
                  )
                : HomeButton(
                    name: 'OCR',
                    onPressed: uploadFile,
                  ),
          ],
        ),
        body: Column(
          children: const [
            AppPageHeading(
              automaticallyImplyBack: false,
              title: 'HOME'
            ),
            Text('Recents n stuff'),
          ],
        ));
  }
}

class HomeButton extends StatelessWidget {
  const HomeButton({Key? key, this.name, required this.onPressed})
      : super(key: key);

  final String? name;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      isExtended: true,
      tooltip: name,
      heroTag: name,
      backgroundColor: AppColors.primary,
      label: Text(name ?? ''),
    );
  }
}
