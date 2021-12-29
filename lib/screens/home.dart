import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:test_app/network/summyNetwork.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  uploadFile() async {
    print('upupuppuu');
    FilePickerResult? _pickedFile = await FilePicker.platform.pickFiles();

    if (_pickedFile != null) {
      File file = File(_pickedFile.files.single.path ?? '');
      print('anna ok');
      SummyNetwork _smynw = SummyNetwork();
      var result = await _smynw.uploadFile(file);
      print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      alignment: Alignment.center,
      color: Colors.deepPurple,
      // width: 200.0,
      // height: 100.0,
      // margin: EdgeInsets.all(15.0),
      // margin:  EdgeInsets.only(left: 25.0,top: 15.0),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              "Mzoilla",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: "Mozilla",
                  fontWeight: FontWeight.w600,
                  // fontStyle: FontStyle.ital,
                  color: Colors.white),
            ),
          ),
          MaterialButton(
            onPressed: uploadFile,
            child: const Text('uppi'),
          ),
          const Expanded(
            child: Text(
              "Firefox India China Limited",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: "Mozilla",
                  fontWeight: FontWeight.w600,
                  // fontStyle: FontStyle.ital,
                  color: Colors.white),
            ),
          )
        ],
      ),
    ));
  }
}
