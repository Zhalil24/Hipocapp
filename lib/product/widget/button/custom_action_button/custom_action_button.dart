import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomActionButton extends StatefulWidget {
  final VoidCallback onTop;

  final String text;

  const CustomActionButton({
    Key? key,
    required this.onTop,
    required this.text,
  }) : super(key: key);

  @override
  State<CustomActionButton> createState() => _CustomActionButtonState();
}

class _CustomActionButtonState extends State<CustomActionButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTop,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.sized.highValue,
          vertical: context.sized.lowValue,
        ),
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(context.sized.normalValue),
          border: Border.all(color: Colors.blue),
        ),
        child: Text(
          widget.text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
