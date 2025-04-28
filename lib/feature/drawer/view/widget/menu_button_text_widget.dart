import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class MenuButtonTextWidget extends StatefulWidget {
  final String text;
  const MenuButtonTextWidget({super.key, required this.text});

  @override
  State<MenuButtonTextWidget> createState() => _MenuButtonTextWidgetState();
}

class _MenuButtonTextWidgetState extends State<MenuButtonTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        fontSize: context.sized.normalValue,
        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
      ),
    );
  }
}
