import 'package:flutter/material.dart';

extension FormDecoration on String {
  InputDecoration get formFieldDecoration => InputDecoration(
        labelText: this,
        border: const OutlineInputBorder(),
      );
}
