import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/theme/custom_color_scheme.dart';

class InputButtonWidget extends StatefulWidget {
  const InputButtonWidget({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<InputButtonWidget> createState() => _InputButtonWidgetState();
}

class _InputButtonWidgetState extends State<InputButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColorScheme.darkColorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(Icons.send),
        color: Colors.white,
        onPressed: widget.onPressed,
      ),
    );
  }
}
