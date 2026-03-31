import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class GroupSkeleton extends StatelessWidget {
  const GroupSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.sized.lowValue * 0.35),
      child: Container(
        width: double.infinity,
        height: context.sized.normalValue * 8.6,
        padding: EdgeInsets.all(context.sized.normalValue * 0.9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.sized.lowValue),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _line(width: context.sized.mediumValue * 4, context: context),
            SizedBox(height: context.sized.lowValue),
            _line(width: double.infinity, context: context),
            SizedBox(height: context.sized.lowValue),
            _line(width: context.sized.mediumValue * 4, context: context),
          ],
        ),
      ),
    );
  }

  Widget _line({required double width, BuildContext? context}) {
    return Container(
      width: width,
      height: context?.sized.lowValue,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
