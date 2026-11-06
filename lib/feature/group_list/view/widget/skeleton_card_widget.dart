import 'package:flutter/material.dart';
import 'package:hipocapp/product/widget/skeleton/app_skeleton_box.dart';
import 'package:hipocapp/product/widget/skeleton/app_skeleton_card.dart';
import 'package:kartal/kartal.dart';

class SkeletonCardWidget extends StatelessWidget {
  const SkeletonCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final low = context.sized.lowValue;
    final normal = context.sized.normalValue;

    return AppSkeletonCard(
      padding: EdgeInsets.all(context.sized.height * 0.024),
      margin: EdgeInsets.only(bottom: low * 0.9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSkeletonBox(
            height: context.sized.height * 0.028,
            width: context.sized.width * 0.42,
          ),
          SizedBox(height: low * 0.9),
          AppSkeletonBox(
            height: context.sized.height * 0.018,
            width: context.sized.width * 0.26,
          ),
          SizedBox(height: normal),
          AppSkeletonBox(
            height: context.sized.height * 0.016,
            width: double.infinity,
          ),
          SizedBox(height: low * 0.75),
          AppSkeletonBox(
            height: context.sized.height * 0.016,
            width: context.sized.width * 0.58,
          ),
          SizedBox(height: normal),
          AppSkeletonBox(
            height: context.sized.height * 0.052,
            width: double.infinity,
            radius: normal,
          ),
        ],
      ),
    );
  }
}
