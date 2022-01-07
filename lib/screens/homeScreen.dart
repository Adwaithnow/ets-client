import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:test_app/components/appComponents/appPageHeading.dart';
//import 'package:test_app/components/appComponents/fabButton.dart';
import 'package:test_app/core/appData.dart';
import 'package:test_app/models/summyModel.dart';
import 'package:test_app/models/userModel.dart';
import 'package:test_app/network/summyNetwork.dart';
import 'package:test_app/screens/loginScreen.dart';
import 'package:test_app/screens/summyScreen.dart';
import 'package:test_app/screens/textInputScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  bool isLoadingHistory = false;
  static List<Summy> _summyHistory = [];

  @override
  void initState() {
    getSummyHistory();
    super.initState();
  }

  @override
  setState(VoidCallback fn) => mounted ? super.setState(fn) : {};

  Future<void> getSummyHistory() async {
    setState(() => isLoadingHistory = true);
    SummyNetwork _smynw = SummyNetwork();
    var result = await _smynw.summyHistory();
    setState(() => isLoadingHistory = false);
    if (result == 'ok') _summyHistory = AppData.summyHistory;
    return;
  }

  uploadFile() async {
    setState(() {
      isLoading = true;
    });
    try {
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
          MaterialPageRoute(
            builder: (context) => TextInputScreen(
              initialText: AppData.myextracted,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result)));
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          HomePageButton(
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
              : HomePageButton(
                  name: 'OCR',
                  onPressed: uploadFile,
                ),
        ],
      ),
      //body: RefreshIndicator(
      //  onRefresh: getSummyHistory,
      //  child: Column(
      //    children: [
      //      const AppPageHeading(automaticallyImplyBack: false, title: 'HOME'),
      //      isLoadingHistory
      //        ? const LinearProgressIndicator(
      //            backgroundColor: AppColors.primary,
      //            color: AppColors.secondary,
      //          )
      //        : ListView.builder(
      //        itemCount: _summyHistory.length,
      //        itemBuilder: (context, index) {
      //          return SummyBox(summy: _summyHistory[index]);
      //        },
      //      ),
      //    ],
      //  ),
      //),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppPageHeading(
            title: 'HOME',
            automaticallyImplyBack: false,
            prefix: IconButton(
              onPressed: () {
                AppData.user = User();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false);
              },
              icon: const Icon(Icons.logout_rounded),
            ),
            suffix: IconButton(
              onPressed: getSummyHistory,
              icon: const Icon(Icons.refresh),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: isLoadingHistory
                  ? const LinearProgressIndicator(
                      backgroundColor: AppColors.primary,
                      color: AppColors.secondary,
                    )
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _summyHistory.length,
                      itemBuilder: (context, index) =>
                          SummyBox(summy: _summyHistory[index]),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePageButton extends StatelessWidget {
  const HomePageButton({Key? key, this.name, required this.onPressed})
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

class SummyBox extends StatelessWidget {
  const SummyBox({Key? key, required this.summy}) : super(key: key);
  final Summy summy;

  @override
  Widget build(BuildContext context) {
    DateTime _date = DateTime.parse(summy.updatedAt ?? '');
    String _timeStamp = '${_date.day}/${_date.month}/${_date.year}';
    //_timeStamp += _date.day;
    return Container(
      margin: const EdgeInsets.only(top: 5, right: 10, left: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SummyScreen(
                summy: summy,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              summy.title ?? '',
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              summy.summary ?? '',
              maxLines: 3,
              style: const TextStyle(
                  //color: AppColors.primary,
                  ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(_timeStamp),
            )
            //const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
