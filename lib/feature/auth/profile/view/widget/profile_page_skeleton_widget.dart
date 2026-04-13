import 'package:flutter/material.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/profile_background_widget.dart';
import 'package:hipocapp/product/utility/enums/profile_tab_type.dart';
import 'package:kartal/kartal.dart';
import 'package:shimmer/shimmer.dart';
import 'package:widgets/widgets.dart';

class ProfilePageSkeletonWidget extends StatelessWidget {
  const ProfilePageSkeletonWidget({
    super.key,
    required this.isOwnProfile,
    required this.activeTab,
    this.showBackground = true,
  });

  final bool isOwnProfile;
  final ProfileTabType activeTab;
  final bool showBackground;

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final colorScheme = Theme.of(context).colorScheme;

    final skeletonContent = SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        normal * 0.82,
        normal * 1.2,
        normal * 0.82,
        normal * 1.5,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Shimmer.fromColors(
            baseColor:
                colorScheme.surfaceContainerHighest.withValues(alpha: 0.55),
            highlightColor: colorScheme.surface.withValues(alpha: 0.95),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ProfileHeaderSkeleton(isOwnProfile: isOwnProfile),
                SizedBox(height: normal * 1.25),
                _ProfileTabsSkeleton(isOwnProfile: isOwnProfile),
                SizedBox(height: normal * 1.25),
                _ProfileBodySkeleton(
                  isOwnProfile: isOwnProfile,
                  activeTab: activeTab,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (!showBackground) {
      return ColoredBox(
        color: colorScheme.surface.withValues(alpha: 0.84),
        child: skeletonContent,
      );
    }

    return Stack(
      children: [
        const Positioned.fill(child: ProfileBackgroundWidget()),
        Positioned.fill(child: skeletonContent),
      ],
    );
  }
}

class _ProfileHeaderSkeleton extends StatelessWidget {
  const _ProfileHeaderSkeleton({
    required this.isOwnProfile,
  });

  final bool isOwnProfile;

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;

    return AppSurfaceCard(
      padding: EdgeInsets.all(context.sized.height * 0.03),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = isOwnProfile && constraints.maxWidth >= 860;
          final summary = _ProfileSummarySkeleton(
            isOwnProfile: isOwnProfile,
          );
          final quickActions = const _ProfileQuickActionsSkeleton();

          if (!isOwnProfile) {
            return summary;
          }

          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: summary),
                SizedBox(width: normal * 1.1),
                Expanded(flex: 2, child: quickActions),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              summary,
              SizedBox(height: normal),
              quickActions,
            ],
          );
        },
      ),
    );
  }
}

class _ProfileSummarySkeleton extends StatelessWidget {
  const _ProfileSummarySkeleton({
    required this.isOwnProfile,
  });

  final bool isOwnProfile;

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProfileSkeletonBox(
              width: context.sized.height * 0.122,
              height: context.sized.height * 0.122,
              radius: context.sized.height * 0.061,
            ),
            SizedBox(width: normal),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProfileSkeletonBox(
                    width: context.sized.width * 0.24,
                    height: context.sized.height * 0.024,
                  ),
                  SizedBox(height: low * 0.45),
                  _ProfileSkeletonBox(
                    width: context.sized.width * 0.18,
                    height: context.sized.height * 0.02,
                  ),
                  if (isOwnProfile) ...[
                    SizedBox(height: low * 0.55),
                    _ProfileSkeletonBox(
                      width: context.sized.width * 0.28,
                      height: context.sized.height * 0.018,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: normal),
        Row(
          children: [
            Expanded(
              child: _ProfileSkeletonBox(
                height: context.sized.height * 0.072,
                radius: normal * 1.2,
              ),
            ),
            SizedBox(width: low * 0.75),
            Expanded(
              child: _ProfileSkeletonBox(
                height: context.sized.height * 0.072,
                radius: normal * 1.2,
              ),
            ),
          ],
        ),
        if (!isOwnProfile) ...[
          SizedBox(height: normal * 0.92),
          _ProfileSkeletonBox(
            width: double.infinity,
            height: context.sized.height * 0.056,
            radius: normal * 1.05,
          ),
        ],
      ],
    );
  }
}

class _ProfileQuickActionsSkeleton extends StatelessWidget {
  const _ProfileQuickActionsSkeleton();

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(normal * 0.68),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(normal * 1.08),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: _ProfileSkeletonBox(
                  height: context.sized.height * 0.06,
                  radius: normal,
                ),
              ),
              SizedBox(width: low * 0.72),
              Expanded(
                child: _ProfileSkeletonBox(
                  height: context.sized.height * 0.06,
                  radius: normal,
                ),
              ),
            ],
          ),
          SizedBox(height: normal * 0.58),
          _ProfileSkeletonBox(
            width: double.infinity,
            height: context.sized.height * 0.049,
            radius: normal,
          ),
        ],
      ),
    );
  }
}

class _ProfileTabsSkeleton extends StatelessWidget {
  const _ProfileTabsSkeleton({
    required this.isOwnProfile,
  });

  final bool isOwnProfile;

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final tabCount = isOwnProfile ? 4 : 2;

    return AppSurfaceCard(
      padding: EdgeInsets.symmetric(
        horizontal: normal * 0.72,
        vertical: normal * 0.66,
      ),
      child: Row(
        children: List.generate(tabCount * 2 - 1, (index) {
          if (index.isOdd) {
            return SizedBox(width: context.sized.lowValue * 0.6);
          }

          return Expanded(
            child: _ProfileSkeletonBox(
              height: context.sized.height * 0.048,
              radius: normal,
            ),
          );
        }),
      ),
    );
  }
}

class _ProfileBodySkeleton extends StatelessWidget {
  const _ProfileBodySkeleton({
    required this.isOwnProfile,
    required this.activeTab,
  });

  final bool isOwnProfile;
  final ProfileTabType activeTab;

  @override
  Widget build(BuildContext context) {
    switch (activeTab) {
      case ProfileTabType.profile:
        return _ProfileInfoSkeleton(isPublicProfile: !isOwnProfile);
      case ProfileTabType.editProfile:
        return const _EditProfileSkeleton();
      case ProfileTabType.changePassword:
        return const _ChangePasswordSkeleton();
      case ProfileTabType.entries:
        return const _ProfileEntriesSkeleton();
    }
  }
}

class _ProfileInfoSkeleton extends StatelessWidget {
  const _ProfileInfoSkeleton({
    required this.isPublicProfile,
  });

  final bool isPublicProfile;

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProfileSkeletonBox(
            width: context.sized.width * 0.24,
            height: context.sized.height * 0.024,
          ),
          if (!isPublicProfile) ...[
            SizedBox(height: low * 0.55),
            _ProfileSkeletonBox(
              width: context.sized.width * 0.46,
              height: context.sized.height * 0.018,
            ),
          ],
          SizedBox(height: normal * 1.1),
          ...List.generate(
            isPublicProfile ? 1 : 4,
            (index) => Padding(
              padding: EdgeInsets.only(
                bottom: index == (isPublicProfile ? 0 : 3) ? 0 : low * 0.75,
              ),
              child: _ProfileSkeletonBox(
                width: double.infinity,
                height: context.sized.height * 0.084,
                radius: normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditProfileSkeleton extends StatelessWidget {
  const _EditProfileSkeleton();

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;

    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProfileSkeletonBox(
            width: context.sized.width * 0.22,
            height: context.sized.height * 0.026,
          ),
          SizedBox(height: normal * 1.2),
          _ProfileSkeletonBox(
            width: double.infinity,
            height: context.sized.height * 0.09,
            radius: normal,
          ),
          SizedBox(height: normal),
          _ProfileSkeletonBox(
            width: double.infinity,
            height: context.sized.height * 0.16,
            radius: normal,
          ),
          SizedBox(height: normal * 1.2),
          _ProfileSkeletonBox(
            width: double.infinity,
            height: context.sized.height * 0.06,
            radius: normal,
          ),
          SizedBox(height: normal),
          _ProfileSkeletonBox(
            width: double.infinity,
            height: context.sized.height * 0.06,
            radius: normal,
          ),
          SizedBox(height: normal),
          _ProfileSkeletonBox(
            width: double.infinity,
            height: context.sized.height * 0.06,
            radius: normal,
          ),
          SizedBox(height: normal),
          _ProfileSkeletonBox(
            width: double.infinity,
            height: context.sized.height * 0.06,
            radius: normal,
          ),
          SizedBox(height: normal * 1.25),
          _ProfileSkeletonBox(
            width: double.infinity,
            height: context.sized.height * 0.056,
            radius: normal,
          ),
        ],
      ),
    );
  }
}

class _ChangePasswordSkeleton extends StatelessWidget {
  const _ChangePasswordSkeleton();

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProfileSkeletonBox(
            width: context.sized.width * 0.24,
            height: context.sized.height * 0.026,
          ),
          SizedBox(height: low * 0.55),
          _ProfileSkeletonBox(
            width: context.sized.width * 0.52,
            height: context.sized.height * 0.018,
          ),
          SizedBox(height: normal * 1.2),
          _ProfileSkeletonBox(
            width: double.infinity,
            height: context.sized.height * 0.09,
            radius: normal,
          ),
          SizedBox(height: normal * 1.2),
          _ProfileSkeletonBox(
            width: double.infinity,
            height: context.sized.height * 0.06,
            radius: normal,
          ),
          SizedBox(height: normal),
          _ProfileSkeletonBox(
            width: double.infinity,
            height: context.sized.height * 0.06,
            radius: normal,
          ),
          SizedBox(height: normal),
          _ProfileSkeletonBox(
            width: double.infinity,
            height: context.sized.height * 0.06,
            radius: normal,
          ),
          SizedBox(height: normal * 1.25),
          _ProfileSkeletonBox(
            width: double.infinity,
            height: context.sized.height * 0.056,
            radius: normal,
          ),
        ],
      ),
    );
  }
}

class _ProfileEntriesSkeleton extends StatelessWidget {
  const _ProfileEntriesSkeleton();

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;

    return Column(
      children: List.generate(
        3,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: index == 2 ? 0 : normal),
          child: AppSurfaceCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProfileSkeletonBox(
                  width: context.sized.width * 0.3,
                  height: context.sized.height * 0.022,
                ),
                SizedBox(height: normal * 0.9),
                _ProfileSkeletonBox(
                  width: double.infinity,
                  height: context.sized.height * 0.015,
                ),
                SizedBox(height: context.sized.lowValue * 0.45),
                _ProfileSkeletonBox(
                  width: double.infinity,
                  height: context.sized.height * 0.015,
                ),
                SizedBox(height: context.sized.lowValue * 0.45),
                _ProfileSkeletonBox(
                  width: context.sized.width * 0.62,
                  height: context.sized.height * 0.015,
                ),
                SizedBox(height: normal),
                Align(
                  alignment: Alignment.centerRight,
                  child: _ProfileSkeletonBox(
                    width: context.sized.width * 0.18,
                    height: context.sized.height * 0.042,
                    radius: normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileSkeletonBox extends StatelessWidget {
  const _ProfileSkeletonBox({
    this.width,
    required this.height,
    this.radius,
  });

  final double? width;
  final double height;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          radius ?? context.sized.lowValue * 0.9,
        ),
      ),
    );
  }
}
