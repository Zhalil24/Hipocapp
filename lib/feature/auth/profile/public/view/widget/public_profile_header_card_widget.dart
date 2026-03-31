import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/widget/circle_avatar/custom_circle_avatar.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class PublicProfileHeaderCardWidget extends StatelessWidget {
  const PublicProfileHeaderCardWidget({
    super.key,
    required this.profileModel,
    this.fallbackUsername,
  });

  final ProfileModel? profileModel;
  final String? fallbackUsername;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;
    final userName = _resolveUserName(context);

    return AppSurfaceCard(
      padding: EdgeInsets.all(context.sized.height * 0.03),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 640;
          final avatar = Container(
            padding: EdgeInsets.all(low * 0.55),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary.withValues(alpha: 0.24),
                  colorScheme.secondary.withValues(alpha: 0.14),
                ],
              ),
            ),
            child: CustomCircleAvatar(
              imageURL: profileModel?.photoURL ?? '',
              radius: context.sized.height * 0.06,
              icon: Icons.person_outline_rounded,
              backgroundColor: colorScheme.primary.withValues(alpha: 0.12),
            ),
          );

          final content = Column(
            crossAxisAlignment:
                isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              Text(
                userName,
                textAlign: isWide ? TextAlign.start : TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          );

          if (isWide) {
            return Row(
              children: [
                avatar,
                SizedBox(width: normal * 1.15),
                Expanded(child: content),
              ],
            );
          }

          return Column(
            children: [
              avatar,
              SizedBox(height: normal),
              content,
            ],
          );
        },
      ),
    );
  }

  String _resolveUserName(BuildContext context) {
    final profileName = profileModel?.username?.trim() ?? '';
    if (profileName.isNotEmpty) {
      return profileName;
    }

    final fallback = fallbackUsername?.trim() ?? '';
    if (fallback.isNotEmpty) {
      return fallback;
    }

    return LocaleKeys.general_fallback_unknown_user.tr();
  }
}
