import 'package:flutter/material.dart';
import '../constants.dart';

class TextBox extends StatelessWidget {
  TextBox({
    super.key,
    required this.onChanged,
    required this.hintText,
  });
  Function onChanged;
  String hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        //Do something with the user input.
        onChanged;
      },
      decoration: kTextFieldDecoration,
    );
  }
}
