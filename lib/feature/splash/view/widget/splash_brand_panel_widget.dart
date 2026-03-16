import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:kartal/kartal.dart';

class SplashBrandPanelWidget extends StatelessWidget {
  const SplashBrandPanelWidget({
    super.key,
    this.isCompact = false,
  });

  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final low = context.sized.lowValue;
    final normal = context.sized.normalValue;
    final panelPadding = isCompact ? normal * 1.6 : normal * 2.2;
    final logoSize = context.sized.height * (isCompact ? 0.085 : 0.11);

    return Container(
      padding: EdgeInsets.all(panelPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(normal * 2.2),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary.withValues(alpha: isDark ? 0.88 : 0.94),
            colorScheme.tertiary.withValues(alpha: isDark ? 0.82 : 0.74),
            colorScheme.secondary.withValues(alpha: isDark ? 0.92 : 0.84),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: isDark ? 0.28 : 0.16),
            blurRadius: normal * 2.2,
            offset: Offset(0, normal + (low * 0.25)),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: low * 1.75,
              vertical: low * 1.05,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: isDark ? 0.14 : 0.18),
              borderRadius: BorderRadius.circular(context.sized.height),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.18),
              ),
            ),
            child: Text(
              'HipocApp acilis deneyimi',
              style: theme.textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: normal * 1.25),
          Container(
            width: logoSize,
            height: logoSize,
            padding: EdgeInsets.all(low * 1.35),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: isDark ? 0.14 : 0.20),
              borderRadius: BorderRadius.circular(low * 2.8),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.20),
              ),
            ),
            child: Assets.images.logo.image(package: 'gen'),
          ),
          SizedBox(height: normal),
          Text(
            'HipocApp',
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.92),
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(height: low * 1.25),
          Text(
            'Saglik toplulugunla bulusman icin akisi hazirliyoruz.',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              height: 1.05,
            ),
          ),
          SizedBox(height: low * 1.5),
          Text(
            'Tema secimin, karsilama adimlarin ve temel uygulama '
            'kontrolleri arka planda tamamlanirken seni en dogru ekrana '
            'yonlendirecegiz.',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.84),
              height: 1.45,
            ),
          ),
          SizedBox(height: normal * 1.8),
          Wrap(
            spacing: low,
            runSpacing: low,
            children: const [
              _SplashFeatureChip(
                icon: Icons.palette_outlined,
                label: 'Tema senkronu',
              ),
              _SplashFeatureChip(
                icon: Icons.verified_user_outlined,
                label: 'Oturum kontrolu',
              ),
              _SplashFeatureChip(
                icon: Icons.auto_awesome_outlined,
                label: 'Ilk deneyim akisi',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SplashFeatureChip extends StatelessWidget {
  const _SplashFeatureChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final low = context.sized.lowValue;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: low * 1.35,
        vertical: low,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(context.sized.height),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.16),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: low * 1.9,
          ),
          SizedBox(width: low * 0.8),
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.92),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
