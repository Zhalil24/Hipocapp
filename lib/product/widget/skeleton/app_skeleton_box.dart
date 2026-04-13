import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AppSkeletonBox extends StatelessWidget {
  const AppSkeletonBox({
    super.key,
    this.width,
    required this.height,
    this.radius,
    this.color,
  });

  final double? width;
  final double height;
  final double? radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(
          radius ?? context.sized.lowValue * 0.9,
        ),
      ),
    );
  }
}
