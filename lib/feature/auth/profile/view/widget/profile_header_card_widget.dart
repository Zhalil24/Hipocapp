import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/product/widget/circle_avatar/custom_circle_avatar.dart';
import 'package:hipocapp/product/state/view_model/prodcut_state.dart';
import 'package:hipocapp/product/state/view_model/product_view_model.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class ProfileHeaderCardWidget extends StatelessWidget {
  const ProfileHeaderCardWidget({
    super.key,
    required this.profileModel,
    required this.selectedPhoto,
    required this.onLogout,
  });

  final ProfileModel? profileModel;
  final File? selectedPhoto;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final displayName = _displayName;
    final entryCount = profileModel?.entries?.length ?? 0;

    return AppSurfaceCard(
      padding: EdgeInsets.all(context.sized.height * 0.032),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 860;
          final profileSummary = _ProfileSummary(
            displayName: displayName,
            handle: '@${profileModel?.username ?? 'hipocapp'}',
            email: profileModel?.email ?? 'Mail bilgisi eklenmedi',
            degree: profileModel?.degreeModel?.degreeName ?? 'Topluluk uyesi',
            entryCount: entryCount,
            selectedPhoto: selectedPhoto,
            imageUrl: profileModel?.photoURL ?? '',
          );
          final quickActions = _ProfileQuickActions(
            onLogout: onLogout,
          );

          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: profileSummary),
                SizedBox(width: normal * 1.5),
                Expanded(flex: 2, child: quickActions),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profileSummary,
              SizedBox(height: normal * 1.25),
              quickActions,
            ],
          );
        },
      ),
    );
  }

  String get _displayName {
    final name = profileModel?.name?.trim() ?? '';
    final surname = profileModel?.surname?.trim() ?? '';
    final fullName = '$name $surname'.trim();
    return fullName.isEmpty ? 'Profilini tamamla' : fullName;
  }
}

class _ProfileSummary extends StatelessWidget {
  const _ProfileSummary({
    required this.displayName,
    required this.handle,
    required this.email,
    required this.degree,
    required this.entryCount,
    required this.selectedPhoto,
    required this.imageUrl,
  });

  final String displayName;
  final String handle;
  final String email;
  final String degree;
  final int entryCount;
  final File? selectedPhoto;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(low * 0.45),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary.withValues(alpha: 0.28),
                    colorScheme.secondary.withValues(alpha: 0.18),
                  ],
                ),
              ),
              child: selectedPhoto != null
                  ? CircleAvatar(
                      radius: context.sized.height * 0.055,
                      backgroundImage: FileImage(selectedPhoto!),
                    )
                  : CustomCircleAvatar(
                      imageURL: imageUrl,
                      radius: context.sized.height * 0.055,
                      backgroundColor: colorScheme.primary.withValues(alpha: 0.12),
                      icon: Icons.person_outline_rounded,
                    ),
            ),
            SizedBox(width: normal),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: low * 0.35),
                  Text(
                    handle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: low * 0.5),
                  Text(
                    email,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: normal * 1.2),
        Wrap(
          spacing: low * 0.75,
          runSpacing: low * 0.75,
          children: [
            _ProfileMetricChip(
              icon: Icons.badge_outlined,
              label: degree,
            ),
            _ProfileMetricChip(
              icon: Icons.auto_stories_rounded,
              label: '$entryCount entry',
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfileQuickActions extends StatelessWidget {
  const _ProfileQuickActions({
    required this.onLogout,
  });

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return Container(
      padding: EdgeInsets.all(normal),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(normal * 1.35),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hizli ayarlar',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: low * 0.55),
          Text(
            'Tema modunu degistir veya hesabindan guvenli sekilde cikis yap.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          SizedBox(height: normal),
          BlocBuilder<ProductViewModel, ProdcutState>(
            buildWhen: (prev, curr) => prev.themeMode != curr.themeMode,
            builder: (context, state) {
              final selectedMode = state.themeMode == ThemeMode.dark
                  ? ThemeMode.dark
                  : ThemeMode.light;

              return SegmentedButton<ThemeMode>(
                segments: const [
                  ButtonSegment(
                    value: ThemeMode.light,
                    icon: Icon(Icons.light_mode_rounded),
                    label: Text('Acik'),
                  ),
                  ButtonSegment(
                    value: ThemeMode.dark,
                    icon: Icon(Icons.dark_mode_rounded),
                    label: Text('Koyu'),
                  ),
                ],
                selected: {selectedMode},
                onSelectionChanged: (values) async {
                  await context.read<ProductViewModel>().changeThemeMode(
                        values.first,
                      );
                },
                style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  side: WidgetStatePropertyAll(
                    BorderSide(
                      color: colorScheme.outline.withValues(alpha: 0.22),
                    ),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(normal),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: normal),
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonalIcon(
              onPressed: onLogout,
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Guvenli cikis yap'),
              style: FilledButton.styleFrom(
                minimumSize: Size.fromHeight(context.sized.height * 0.062),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(normal * 1.1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileMetricChip extends StatelessWidget {
  const _ProfileMetricChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final low = context.sized.lowValue;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.sized.normalValue * 0.8,
        vertical: low * 0.85,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.84),
        borderRadius: BorderRadius.circular(context.sized.normalValue * 1.4),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: context.sized.normalValue,
            color: colorScheme.primary,
          ),
          SizedBox(width: low * 0.55),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
