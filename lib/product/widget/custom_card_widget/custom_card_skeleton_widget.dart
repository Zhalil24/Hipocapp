import 'package:flutter/material.dart';
import 'package:hipocapp/product/widget/skeleton/app_skeleton_box.dart';
import 'package:hipocapp/product/widget/skeleton/app_skeleton_card.dart';
import 'package:kartal/kartal.dart';

class CustomCardWidgetSkeleton extends StatelessWidget {
  const CustomCardWidgetSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        AppSkeletonCard(
          margin: EdgeInsets.symmetric(
            horizontal: low * 0.2,
            vertical: low * 0.75,
          ),
          padding: EdgeInsets.fromLTRB(
            normal * 0.78,
            low * 0.9,
            normal * 0.78,
            low * 0.75,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSkeletonBox(
                    width: maxWidth * 0.52,
                    height: context.sized.height * 0.024,
                  ),
                  SizedBox(height: low * 0.95),
                  AppSkeletonBox(
                    width: maxWidth,
                    height: context.sized.height * 0.015,
                  ),
                  SizedBox(height: low * 0.45),
                  AppSkeletonBox(
                    width: maxWidth,
                    height: context.sized.height * 0.015,
                  ),
                  SizedBox(height: low * 0.45),
                  AppSkeletonBox(
                    width: maxWidth * 0.88,
                    height: context.sized.height * 0.015,
                  ),
                  SizedBox(height: low * 0.45),
                  AppSkeletonBox(
                    width: maxWidth * 0.74,
                    height: context.sized.height * 0.015,
                  ),
                  SizedBox(height: normal * 0.8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AppSkeletonBox(
                      width: maxWidth * 0.3,
                      height: context.sized.height * 0.042,
                      radius: normal,
                    ),
                  ),
                  SizedBox(height: low * 0.8),
                  Wrap(
                    spacing: normal,
                    runSpacing: low * 0.5,
                    children: [
                      _SkeletonMetaItem(
                        width: maxWidth * 0.22,
                      ),
                      _SkeletonMetaItem(
                        width: maxWidth * 0.18,
                      ),
                    ],
                  ),
                  SizedBox(height: normal * 0.95),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AppSkeletonBox(
                      width: maxWidth * 0.38,
                      height: context.sized.height * 0.052,
                      radius: normal * 1.1,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Divider(
          height: low * 1.8,
          indent: low * 0.2,
          endIndent: low * 0.2,
          color: colorScheme.outlineVariant.withValues(alpha: 0.45),
        ),
      ],
    );
  }
}

class _SkeletonMetaItem extends StatelessWidget {
  const _SkeletonMetaItem({
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSkeletonBox(
          width: normal,
          height: normal,
          radius: normal,
        ),
        SizedBox(width: low),
        AppSkeletonBox(
          width: width,
          height: context.sized.height * 0.014,
        ),
      ],
    );
  }
}
