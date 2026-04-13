import 'package:flutter/material.dart';
import 'package:hipocapp/product/widget/skeleton/app_skeleton_box.dart';
import 'package:hipocapp/product/widget/skeleton/app_skeleton_card.dart';
import 'package:kartal/kartal.dart';

class GroupSkeleton extends StatelessWidget {
  const GroupSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: low * 0.35),
      child: AppSkeletonCard(
        padding: EdgeInsets.all(normal * 1.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppSkeletonBox(
                  width: context.sized.width * 0.28,
                  height: context.sized.height * 0.024,
                ),
                const Spacer(),
                AppSkeletonBox(
                  width: context.sized.width * 0.12,
                  height: context.sized.height * 0.03,
                  radius: normal,
                ),
              ],
            ),
            SizedBox(height: normal),
            AppSkeletonBox(
              width: context.sized.width * 0.48,
              height: context.sized.height * 0.03,
            ),
            SizedBox(height: low * 0.55),
            AppSkeletonBox(
              width: double.infinity,
              height: context.sized.height * 0.016,
            ),
            SizedBox(height: low * 0.45),
            AppSkeletonBox(
              width: context.sized.width * 0.56,
              height: context.sized.height * 0.016,
            ),
            SizedBox(height: normal),
            Row(
              children: [
                Expanded(
                  child: AppSkeletonBox(
                    width: double.infinity,
                    height: context.sized.height * 0.056,
                    radius: normal,
                  ),
                ),
                SizedBox(width: low),
                AppSkeletonBox(
                  width: context.sized.height * 0.052,
                  height: context.sized.height * 0.052,
                  radius: context.sized.height * 0.026,
                ),
                SizedBox(width: low * 0.5),
                AppSkeletonBox(
                  width: context.sized.height * 0.052,
                  height: context.sized.height * 0.052,
                  radius: context.sized.height * 0.026,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
