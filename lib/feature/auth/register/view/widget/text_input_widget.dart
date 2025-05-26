import 'package:flutter/material.dart';
import 'package:hipocapp/product/utility/extension/form_decoration.dart';

class TextInputWidget extends StatefulWidget {
  const TextInputWidget({super.key, required this.title, required this.controller, required this.validator});

  final String title;
  final TextEditingController controller;
  final String? Function(String?) validator;

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: widget.title.formFieldDecoration,
      validator: widget.validator,
    );
  }
}
