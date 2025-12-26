import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class InfoWidget extends StatefulWidget {
  const InfoWidget({super.key, required this.text});
  final String text;
  @override
  State<InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.sized.lowValue),
      margin: EdgeInsets.symmetric(
        vertical: context.sized.lowValue,
        horizontal: context.sized.normalValue,
      ),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.2),
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(context.sized.lowValue),
      ),
      child: Text(
        widget.text,
        style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.w500),
      ),
    );
  }
}
