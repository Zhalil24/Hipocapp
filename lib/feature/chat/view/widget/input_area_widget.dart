import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class InputAreaWidget extends StatelessWidget {
  final TextEditingController controller;

  const InputAreaWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Mesaj yaz...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.sized.mediumValue),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.sized.normalValue,
          vertical: context.sized.normalValue,
        ),
      ),
    );
  }
}
