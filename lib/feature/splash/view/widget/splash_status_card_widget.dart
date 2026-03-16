import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class SplashStatusCardWidget extends StatelessWidget {
  const SplashStatusCardWidget({
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

    return AppSurfaceCard(
      padding: EdgeInsets.all(isCompact ? normal * 1.55 : normal * 1.9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: low * 1.5,
              vertical: low,
            ),
            decoration: BoxDecoration(
              color:
                  colorScheme.primary.withValues(alpha: isDark ? 0.14 : 0.10),
              borderRadius: BorderRadius.circular(context.sized.height),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: low * 1.35,
                  height: low * 1.35,
                  child: CircularProgressIndicator(
                    strokeWidth: low * 0.26,
                    color: colorScheme.primary,
                  ),
                ),
                SizedBox(width: low),
                Text(
                  'Hazirlaniyor',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: normal * 1.2),
          Text(
            'Seni uygun acilis akisina yonlendiriyoruz.',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          SizedBox(height: low * 1.2),
          Text(
            'Kayitli tercihlerin ve karsilama adimlarin kontrol ediliyor. '
            'Tamamlandiginda bir sonraki ekrana otomatik gecis yapilacak.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.72),
              height: 1.5,
            ),
          ),
          SizedBox(height: normal * 1.25),
          ClipRRect(
            borderRadius: BorderRadius.circular(low * 1.5),
            child: LinearProgressIndicator(
              minHeight: low * 0.78,
              backgroundColor:
                  colorScheme.primary.withValues(alpha: isDark ? 0.12 : 0.08),
            ),
          ),
          SizedBox(height: normal * 1.15),
          Text(
            'Su anda yapilanlar',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: low * 1.2),
          const _SplashStatusTile(
            icon: Icons.color_lens_outlined,
            title: 'Tema tercihi yukleniyor',
            description:
                'Kayitli gorunum secimin uygulama geneline aktariliyor.',
          ),
          SizedBox(height: low),
          const _SplashStatusTile(
            icon: Icons.route_outlined,
            title: 'Karsilama akisi kontrol ediliyor',
            description:
                'Onboarding gerekip gerekmedigi sessizce belirleniyor.',
          ),
          SizedBox(height: low),
          const _SplashStatusTile(
            icon: Icons.dashboard_customize_outlined,
            title: 'Ana deneyim hazirlaniyor',
            description:
                'Seni bir sonraki uygun sayfaya temiz bir gecisle tasiyoruz.',
          ),
        ],
      ),
    );
  }
}

class _SplashStatusTile extends StatelessWidget {
  const _SplashStatusTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final low = context.sized.lowValue;
    final normal = context.sized.normalValue;

    return Container(
      padding: EdgeInsets.all(low * 1.2),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest
            .withValues(alpha: isDark ? 0.42 : 0.58),
        borderRadius: BorderRadius.circular(normal * 0.95),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: normal * 2.4,
            height: normal * 2.4,
            decoration: BoxDecoration(
              color:
                  colorScheme.primary.withValues(alpha: isDark ? 0.16 : 0.10),
              borderRadius: BorderRadius.circular(low * 1.4),
            ),
            child: Icon(
              icon,
              color: colorScheme.primary,
              size: low * 2,
            ),
          ),
          SizedBox(width: low * 1.2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: low * 0.45),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.72),
                    height: 1.4,
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
