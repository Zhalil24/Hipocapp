import 'package:flutter/material.dart';
import 'package:hipocapp/product/widget/skeleton/app_skeleton_box.dart';
import 'package:hipocapp/product/widget/skeleton/app_skeleton_card.dart';
import 'package:kartal/kartal.dart';

class RegisterPageSkeletonWidget extends StatelessWidget {
  const RegisterPageSkeletonWidget({
    super.key,
    this.showBackground = true,
  });

  final bool showBackground;

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;

    final content = SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        normal * 0.95,
        normal * 1.5,
        normal * 0.95,
        normal * 1.5,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 960;

              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: normal * 1.75),
                        child: const _RegisterHeroSkeleton(),
                      ),
                    ),
                    const Expanded(
                      child: _RegisterFormSkeleton(),
                    ),
                  ],
                );
              }

              return const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _RegisterHeroSkeleton(isCompact: true),
                  _RegisterFormSpacing(),
                  _RegisterFormSkeleton(),
                ],
              );
            },
          ),
        ),
      ),
    );

    if (!showBackground) {
      return ColoredBox(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.84),
        child: content,
      );
    }

    return content;
  }
}

class _RegisterHeroSkeleton extends StatelessWidget {
  const _RegisterHeroSkeleton({
    this.isCompact = false,
  });

  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return AppSkeletonCard(
      padding: EdgeInsets.all(context.sized.height * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSkeletonBox(
            width: context.sized.width * (isCompact ? 0.34 : 0.26),
            height: context.sized.height * 0.028,
          ),
          SizedBox(height: low * 0.7),
          AppSkeletonBox(
            width: context.sized.width * (isCompact ? 0.52 : 0.38),
            height: context.sized.height * 0.018,
          ),
          SizedBox(height: normal * 1.1),
          AppSkeletonBox(
            width: double.infinity,
            height: context.sized.height * (isCompact ? 0.16 : 0.22),
            radius: normal * 1.3,
          ),
          SizedBox(height: normal),
          AppSkeletonBox(
            width: context.sized.width * 0.3,
            height: context.sized.height * 0.018,
          ),
          SizedBox(height: low * 0.45),
          AppSkeletonBox(
            width: context.sized.width * 0.22,
            height: context.sized.height * 0.018,
          ),
        ],
      ),
    );
  }
}

class _RegisterFormSpacing extends StatelessWidget {
  const _RegisterFormSpacing();

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: context.sized.normalValue * 1.25);
  }
}

class _RegisterFormSkeleton extends StatelessWidget {
  const _RegisterFormSkeleton();

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return AppSkeletonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSkeletonBox(
            width: context.sized.width * 0.28,
            height: context.sized.height * 0.026,
          ),
          SizedBox(height: low * 0.55),
          AppSkeletonBox(
            width: context.sized.width * 0.48,
            height: context.sized.height * 0.018,
          ),
          SizedBox(height: normal * 1.2),
          AppSkeletonBox(
            width: double.infinity,
            height: context.sized.height * 0.082,
            radius: normal,
          ),
          SizedBox(height: normal),
          ...List.generate(
            6,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: normal),
              child: AppSkeletonBox(
                width: double.infinity,
                height: context.sized.height * 0.068,
                radius: normal,
              ),
            ),
          ),
          Row(
            children: [
              AppSkeletonBox(
                width: context.sized.height * 0.026,
                height: context.sized.height * 0.026,
                radius: low * 0.7,
              ),
              SizedBox(width: low * 0.6),
              AppSkeletonBox(
                width: context.sized.width * 0.36,
                height: context.sized.height * 0.016,
              ),
            ],
          ),
          SizedBox(height: normal * 1.15),
          AppSkeletonBox(
            width: double.infinity,
            height: context.sized.height * 0.058,
            radius: normal,
          ),
        ],
      ),
    );
  }
}
