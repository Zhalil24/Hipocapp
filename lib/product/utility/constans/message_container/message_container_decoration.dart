import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

BoxDecoration MessageContainerDecoration({required BuildContext context, required bool isMe}) {
  final colorScheme = Theme.of(context).colorScheme;
  return BoxDecoration(
    color: isMe ? colorScheme.primary : Colors.grey.shade300,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(context.sized.normalValue),
      topRight: Radius.circular(context.sized.normalValue),
      bottomLeft: Radius.circular(isMe ? context.sized.normalValue : 0),
      bottomRight: Radius.circular(isMe ? 0 : context.sized.normalValue),
    ),
  );
}
