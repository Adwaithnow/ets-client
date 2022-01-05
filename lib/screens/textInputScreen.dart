import 'package:flutter/material.dart';
import 'package:test_app/components/appComponents/appInput.dart';
import 'package:test_app/components/appComponents/appPageHeading.dart';
import 'package:test_app/core/appData.dart';
import 'package:flutter/services.dart';
import 'package:test_app/network/summyNetwork.dart';

class TextInputScreen extends StatefulWidget {
  const TextInputScreen({Key? key, this.initialText = ''}) : super(key: key);
  final String initialText;

  @override
  _TextInputScreenState createState() => _TextInputScreenState();
}

class _TextInputScreenState extends State<TextInputScreen> {
  final _textController = TextEditingController();
  bool isLoading = false;
  String title = '';
  TextAlign _textAlign = TextAlign.start;
  @override
  void dispose() {
    _textController.dispose();
    //_textController.removeListener(() {});
    super.dispose();
  }

  @override
  void initState() {
    setTextAlign();
    if (widget.initialText != '') {
      setState(() => _textController.text = widget.initialText);
    }
    _textController.addListener(() => setTextAlign());
    super.initState();
  }

  setTextAlign() {
    setState(() {
      _textAlign =
          _textController.text == '' ? TextAlign.center : TextAlign.start;
    });
  }

  getSummary() async {
    setState(() {
      isLoading = true;
    });
    SummyNetwork _smynw = SummyNetwork();
    var result = await _smynw.getSummary(title, _textController.text);
    setState(() {
      isLoading = false;
      _textController.text = AppData.mysummary;
    });
    if (result == 'ok') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TextInputScreen(
            initialText: AppData.mysummary,
          ),
        ),
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
          AppPageHeading(
              title: widget.initialText != '' ? 'RESULT' : 'Get Summary'),
          AppInputFiled(
            onChanged: (val) => title = val,
            hintText: 'Enter Title',
          ),
          TextField(
            controller: _textController,
            maxLines: 20,
            textAlign: _textAlign,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColors.inputFill,
              hintText: 'Enter Text',
              hintStyle: const TextStyle(
                color: AppColors.tertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
