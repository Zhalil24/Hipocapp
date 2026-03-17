import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class SkeletonCardWidget extends StatelessWidget {
  const SkeletonCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final low = context.sized.lowValue;
    final normal = context.sized.normalValue;
    final placeholderColor =
        colorScheme.surfaceContainerHighest.withValues(alpha: 0.75);

    return AppSurfaceCard(
      padding: EdgeInsets.all(context.sized.height * 0.024),
      margin: EdgeInsets.only(bottom: low * 0.9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: context.sized.height * 0.028,
            width: context.sized.width * 0.42,
            decoration: BoxDecoration(
              color: placeholderColor,
              borderRadius: BorderRadius.circular(low),
            ),
          ),
          SizedBox(height: low * 0.9),
          Container(
            height: context.sized.height * 0.018,
            width: context.sized.width * 0.26,
            decoration: BoxDecoration(
              color: placeholderColor,
              borderRadius: BorderRadius.circular(low * 0.9),
            ),
          ),
          SizedBox(height: normal),
          Container(
            height: context.sized.height * 0.016,
            width: double.infinity,
            decoration: BoxDecoration(
              color: placeholderColor,
              borderRadius: BorderRadius.circular(low * 0.9),
            ),
          ),
          SizedBox(height: low * 0.75),
          Container(
            height: context.sized.height * 0.016,
            width: context.sized.width * 0.58,
            decoration: BoxDecoration(
              color: placeholderColor,
              borderRadius: BorderRadius.circular(low * 0.9),
            ),
          ),
          SizedBox(height: normal),
          Container(
            height: context.sized.height * 0.052,
            width: double.infinity,
            decoration: BoxDecoration(
              color: placeholderColor,
              borderRadius: BorderRadius.circular(normal),
            ),
          ),
        ],
      ),
    );
  }
}
