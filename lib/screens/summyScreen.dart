import 'package:flutter/material.dart';
import 'package:test_app/components/appComponents/appPageHeading.dart';
import 'package:test_app/components/appComponents/fabButton.dart';
import 'package:test_app/core/appData.dart';
import 'package:test_app/models/summyModel.dart';
import 'package:test_app/network/summyNetwork.dart';
import 'package:test_app/screens/homeScreen.dart';

class SummyScreen extends StatefulWidget {
  const SummyScreen({Key? key, required this.summy}) : super(key: key);
  final Summy summy;

  @override
  State<SummyScreen> createState() => _SummyScreenState();
}

class _SummyScreenState extends State<SummyScreen> {
  bool isDELLoading = false, isUPDLoading = false, isEditing = false;
  //String title = '', text = '';
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.summy.title ?? '';
    _summaryController.text = widget.summy.summary ?? '';
    super.initState();
  }

  delete() async {
    setState(() {
      isDELLoading = true;
    });
    SummyNetwork _smynw = SummyNetwork();
    var result = await _smynw.deleteSummary(widget.summy.id ?? '');
    setState(() {
      isDELLoading = false;
    });
    if (result == 'ok') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
    }
  }

  update() async {
    setState(() {
      isUPDLoading = true;
    });
    SummyNetwork _smynw = SummyNetwork();
    var result = await _smynw.updateSummary(
      widget.summy.id ?? '',
      _titleController.text,
      _summaryController.text,
    );
    setState(() {
      isUPDLoading = false;
    });
    if (result == 'ok') {
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FabButton(
              onPressed: () => setState(() => isEditing = !isEditing),
              icon: isEditing
                  ? const Icon(Icons.close_sharp, size: 34)
                  : const Icon(Icons.edit_rounded),
            ),
            const SizedBox(width: 20),
            FabButton(
              onPressed: delete,
              icon: !isDELLoading
                  ? const Icon(Icons.delete_rounded)
                  : const CircularProgressIndicator(
                      backgroundColor: AppColors.primary,
                      color: AppColors.secondary,
                    ),
            ),
            const SizedBox(width: 20),
            FabButton(
              onPressed: update,
              icon: !isUPDLoading
                  ? const Icon(Icons.save_rounded)
                  : const CircularProgressIndicator(
                      backgroundColor: AppColors.primary,
                      color: AppColors.secondary,
                    ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppPageHeading(title: widget.summy.title ?? 'Summary'),
            Container(
              margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.inputFill,
                borderRadius: BorderRadius.circular(20),
              ),
              child: !isEditing
                  ? Text(widget.summy.summary ?? '')
                  : TextField(
                      controller: _summaryController,
                      maxLines: 20,
                      //textAlign: _textAlign,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: AppColors.inputFill,
                        //hintText: 'Enter Text',
                        //hintStyle: const TextStyle(
                        //  color: AppColors.tertiary,
                        //),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
