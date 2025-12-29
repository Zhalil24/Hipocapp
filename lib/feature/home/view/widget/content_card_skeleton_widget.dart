import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:shimmer/shimmer.dart';

class ContentCardSkeleton extends StatelessWidget {
  const ContentCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey.shade300;
    final highlightColor = Colors.grey.shade100;

    return Container(
      margin: EdgeInsets.only(bottom: context.sized.normalValue),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.sized.lowValue),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(context.sized.lowValue),
              ),
              child: Container(
                width: double.infinity,
                height: context.sized.highValue * 3,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(context.sized.normalValue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _skeletonLine(
                    context,
                    width: context.sized.highValue * 5,
                    height: context.sized.normalValue,
                  ),
                  SizedBox(height: context.sized.lowValue),
                  _skeletonLine(
                    context,
                    width: context.sized.highValue * 2.5,
                    height: context.sized.lowValue * 1.4,
                  ),
                  SizedBox(height: context.sized.lowValue),
                  _skeletonLine(context, width: double.infinity, height: 12),
                  SizedBox(height: context.sized.lowValue * 0.6),
                  _skeletonLine(context, width: double.infinity, height: 12),
                  SizedBox(height: context.sized.lowValue * 0.6),
                  _skeletonLine(context, width: context.sized.highValue * 4, height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _skeletonLine(
    BuildContext context, {
    required double width,
    required double height,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
