import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:kartal/kartal.dart';

class LoginHeroPanelWidget extends StatelessWidget {
  const LoginHeroPanelWidget({
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
    final panelPadding = isCompact ? normal * 1.5 : normal * 2;
    final logoSize = isCompact ? context.sized.height * 0.07 : context.sized.height * 0.09;
    final sectionGap = isCompact ? normal * 1.5 : normal * 2.25;

    return Container(
      padding: EdgeInsets.all(panelPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(normal * 2),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary.withValues(alpha: isDark ? 0.82 : 0.92),
            colorScheme.secondary.withValues(alpha: isDark ? 0.88 : 0.78),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: isDark ? 0.28 : 0.16),
            blurRadius: normal * 2,
            offset: Offset(0, normal + (low * 0.25)),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: logoSize,
                height: logoSize,
                padding: EdgeInsets.all(low * 1.25),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: isDark ? 0.12 : 0.18),
                  borderRadius: BorderRadius.circular(low * 2.75),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.16),
                  ),
                ),
                child: Assets.images.logo.image(package: 'gen'),
              ),
              SizedBox(width: low * 1.75),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: low * 1.75,
                  vertical: low * 1.25,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: isDark ? 0.10 : 0.16),
                  borderRadius: BorderRadius.circular(context.sized.height),
                ),
                child: Text(
                  'Hipo topluluguna giris',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: sectionGap),
          Text(
            'Son kaldigin yerden devam et.',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              height: 1.05,
            ),
          ),
          SizedBox(height: low * 1.5),
          Text(
            'Basliklarini takip et, yeni icerikleri kesfet ve toplulukla ayni akista kal.',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.84),
              height: 1.45,
            ),
          ),
          SizedBox(height: isCompact ? normal * 1.5 : normal * 2),
          const _HeroFeatureTile(
            icon: Icons.auto_awesome_rounded,
            title: 'Daha temiz akis',
            description: 'Icerik, grup ve mesaj deneyimi tek yerden devam eder.',
          ),
          SizedBox(height: low * 1.75),
          const _HeroFeatureTile(
            icon: Icons.groups_2_rounded,
            title: 'Topluluk odakli',
            description: 'Gundem, sohbet ve etkilesimler giristen sonra sana gore sekillenir.',
          ),
          SizedBox(height: low * 1.75),
          const _HeroFeatureTile(
            icon: Icons.shield_rounded,
            title: 'Guvenli erisim',
            description: 'Hesabin ve kisisel akisin mevcut oturum mantigiyla korunur.',
          ),
        ],
      ),
    );
  }
}

class _HeroFeatureTile extends StatelessWidget {
  const _HeroFeatureTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final low = context.sized.lowValue;
    final normal = context.sized.normalValue;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: normal * 2.75,
          height: normal * 2.75,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(low * 2),
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        SizedBox(width: low * 1.75),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: low * 0.5),
              Text(
                description,
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.78),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
