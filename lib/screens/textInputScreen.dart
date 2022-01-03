import 'package:flutter/material.dart';
import 'package:test_app/components/appComponents/appButton.dart';
import 'package:test_app/components/appComponents/appInput.dart';
import 'package:test_app/components/appComponents/appPageHeading.dart';
import 'package:test_app/core/appData.dart';
import 'package:flutter/services.dart';

class TextInputScreen extends StatefulWidget {
  const TextInputScreen({Key? key}) : super(key: key);

  @override
  _TextInputScreenState createState() => _TextInputScreenState();
}

class _TextInputScreenState extends State<TextInputScreen> {
  final _textController = TextEditingController();
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              var result = await Clipboard.getData('text/plain');
              _textController.text = result?.text ?? _textController.text;
            },
            heroTag: null,
            child: const Icon(Icons.paste_rounded),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            onPressed: () async {},
            heroTag: null,
            child: const Icon(Icons.send_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          const AppPageHeading(title: 'Get Summary'),
          TextField(
            controller: _textController,
            maxLines: 20,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColors.inputFill,
            ),
          ),
        ],
      ),
    );
  }
}
