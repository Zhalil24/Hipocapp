import 'package:flutter/material.dart';
import 'package:hipocapp/product/widget/skeleton/app_skeleton_box.dart';
import 'package:hipocapp/product/widget/skeleton/app_skeleton_card.dart';
import 'package:kartal/kartal.dart';

class ForgotPasswordPageSkeletonWidget extends StatelessWidget {
  const ForgotPasswordPageSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          normal + (low * 0.5),
          normal * 1.6,
          normal + (low * 0.5),
          normal * 1.6,
        ),
        child: Column(
          children: [
            AppSkeletonBox(
              width: context.sized.width * 0.42,
              height: context.sized.height * 0.09,
              radius: normal * 1.2,
            ),
            SizedBox(height: normal * 1.35),
            AppSkeletonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSkeletonBox(
                    width: context.sized.width * 0.32,
                    height: context.sized.height * 0.026,
                  ),
                  SizedBox(height: low * 0.55),
                  AppSkeletonBox(
                    width: context.sized.width * 0.52,
                    height: context.sized.height * 0.018,
                  ),
                  SizedBox(height: normal * 1.35),
                  AppSkeletonBox(
                    width: double.infinity,
                    height: context.sized.height * 0.07,
                    radius: normal,
                  ),
                  SizedBox(height: normal * 1.2),
                  AppSkeletonBox(
                    width: double.infinity,
                    height: context.sized.height * 0.058,
                    radius: normal,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
