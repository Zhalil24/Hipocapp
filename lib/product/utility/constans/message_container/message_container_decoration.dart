import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/theme/custom_color_scheme.dart';
import 'package:kartal/kartal.dart';

BoxDecoration MessageContainerDecoration({required BuildContext context, required bool isMe}) {
  return BoxDecoration(
    color: isMe ? CustomColorScheme.darkColorScheme.primary : Colors.grey.shade300,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(context.sized.normalValue),
      topRight: Radius.circular(context.sized.normalValue),
      bottomLeft: Radius.circular(isMe ? context.sized.normalValue : 0),
      bottomRight: Radius.circular(isMe ? 0 : context.sized.normalValue),
    ),
  );
}
