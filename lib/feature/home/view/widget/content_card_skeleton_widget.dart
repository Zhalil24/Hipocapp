import 'package:flutter/material.dart';
import 'package:hipocapp/product/widget/skeleton/app_skeleton_box.dart';
import 'package:hipocapp/product/widget/skeleton/app_skeleton_card.dart';
import 'package:kartal/kartal.dart';

class ContentCardSkeleton extends StatelessWidget {
  const ContentCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return AppSkeletonCard(
      margin: EdgeInsets.only(bottom: normal * 1.15),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSkeletonBox(
            width: double.infinity,
            height: context.sized.height * 0.24,
            radius: 0,
          ),
          Padding(
            padding: EdgeInsets.all(normal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSkeletonBox(
                  width: context.sized.width * 0.42,
                  height: context.sized.height * 0.03,
                ),
                SizedBox(height: low * 0.8),
                Row(
                  children: [
                    AppSkeletonBox(
                      width: normal,
                      height: normal,
                      radius: normal,
                    ),
                    SizedBox(width: low * 0.5),
                    Expanded(
                      child: AppSkeletonBox(
                        width: double.infinity,
                        height: context.sized.height * 0.018,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: normal),
                Container(
                  padding: EdgeInsets.all(low * 0.9),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest
                        .withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(low * 0.8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSkeletonBox(
                        width: double.infinity,
                        height: context.sized.height * 0.015,
                      ),
                      SizedBox(height: low * 0.45),
                      AppSkeletonBox(
                        width: double.infinity,
                        height: context.sized.height * 0.015,
                      ),
                      SizedBox(height: low * 0.45),
                      AppSkeletonBox(
                        width: context.sized.width * 0.4,
                        height: context.sized.height * 0.015,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
