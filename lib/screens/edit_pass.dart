import 'package:flutter/material.dart';
import 'package:warnersos/models/pass.dart';
import 'package:warnersos/widgets/screen.dart';
import 'package:warnersos/widgets/screen_button.dart';
import 'package:warnersos/widgets/screen_textfield.dart';

class EditPass extends StatefulWidget {
  final Pass pass;
  
  const EditPass({super.key, required this.pass});

  @override
  State<EditPass> createState() => _EditPassState();
}

class _EditPassState extends State<EditPass> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dataController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.pass.title;
    dataController.text = widget.pass.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: widget.pass.title,
      children: [
        ScreenTextfield(
          controller: titleController,
          hintText: 'Title',
        ),
        const SizedBox(height: 40),
        ScreenTextfield(
          controller: dataController,
          hintText: 'Data'
        ),
        const SizedBox(height: 40),
        ScreenButton(
          text: 'Save Pass',
          onPressed: (){},
        ),
      ],
    );
  }
}