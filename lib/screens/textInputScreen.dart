import 'package:flutter/material.dart';
import 'package:test_app/components/appComponents/appInput.dart';
import 'package:test_app/components/appComponents/appPageHeading.dart';
import 'package:test_app/core/appData.dart';
import 'package:flutter/services.dart';
import 'package:test_app/network/summyNetwork.dart';

class TextInputScreen extends StatefulWidget {
  const TextInputScreen({Key? key, this.showResult = false}) : super(key: key);
  final bool showResult;

  @override
  _TextInputScreenState createState() => _TextInputScreenState();
}

class _TextInputScreenState extends State<TextInputScreen> {
  final _textController = TextEditingController();
  bool isLoading = false;
  bool showResult = false;
  String title = '';
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.showResult) {
      setState(() => _textController.text = AppData.mysummary);
    }
    setState(() => showResult = widget.showResult);
    super.initState();
  }

  getSummary() async {
    setState(() {
      isLoading = true;
    });
    SummyNetwork _smynw = SummyNetwork();
    var result = await _smynw.getSummary(title, _textController.text);
    setState(() {
      isLoading = false;
      showResult = true;
      _textController.text = AppData.mysummary;
    });
    if (result == 'ok') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const TextInputScreen(
                  showResult: true,
                )),
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
          FloatingActionButton(
              onPressed: () async {
                await Clipboard.setData(
                    ClipboardData(text: _textController.text));
              },
              heroTag: null,
              child: const Icon(Icons.copy_rounded)),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () async {
              var result = await Clipboard.getData('text/plain');
              _textController.text = result?.text ?? _textController.text;
            },
            heroTag: null,
            child: const Icon(Icons.paste_rounded),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: getSummary,
            heroTag: null,
            child: !isLoading
                ? const Icon(Icons.send_rounded)
                : const CircularProgressIndicator(
                    backgroundColor: AppColors.primary,
                    color: AppColors.secondary,
                  ),
          ),
        ],
      ),
      body: Column(
        children: [
          AppPageHeading(title: showResult ? 'RESULT' : 'Get Summary'),
          showResult
              ? const SizedBox()
              : AppInputFiled(
                  onChanged: (val) => title = val,
                  hintText: 'Enter Title',
                ),
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
