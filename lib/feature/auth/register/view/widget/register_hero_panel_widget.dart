import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:kartal/kartal.dart';

class RegisterHeroPanelWidget extends StatelessWidget {
  const RegisterHeroPanelWidget({
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

    return Container(
      padding: EdgeInsets.all(panelPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(normal * 2),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.secondary.withValues(alpha: isDark ? 0.92 : 0.88),
            colorScheme.primary.withValues(alpha: isDark ? 0.84 : 0.78),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.secondary.withValues(alpha: isDark ? 0.26 : 0.16),
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
                width: context.sized.height * (isCompact ? 0.07 : 0.085),
                height: context.sized.height * (isCompact ? 0.07 : 0.085),
                padding: EdgeInsets.all(low * 1.25),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: isDark ? 0.14 : 0.18),
                  borderRadius: BorderRadius.circular(low * 2.5),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.18),
                  ),
                ),
                child: Assets.images.logo.image(package: 'gen'),
              ),
              SizedBox(width: low * 1.75),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: low * 1.75,
                  vertical: low * 1.1,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: isDark ? 0.12 : 0.14),
                  borderRadius: BorderRadius.circular(context.sized.height),
                ),
                child: Text(
                  'Yeni uye kaydi',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isCompact ? normal * 1.5 : normal * 2.25),
          Text(
            'Profilini olustur, topluluga katil.',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              height: 1.05,
            ),
          ),
          SizedBox(height: low * 1.5),
          Text(
            'Baslik ac, sohbetlere dahil ol ve dogrulanmis profilinle daha guvenli bir deneyim baslat.',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.84),
              height: 1.45,
            ),
          ),
          SizedBox(height: normal * 2),
          const _RegisterFeatureTile(
            icon: Icons.verified_user_rounded,
            title: 'Dogrulanmis kayit',
            description: 'Kurum kimligi yukleme adimi ile toplulukta daha guvenli bir profil olusturursun.',
          ),
          SizedBox(height: low * 1.75),
          const _RegisterFeatureTile(
            icon: Icons.groups_rounded,
            title: 'Topluluga hizli katilim',
            description: 'Kaydin tamamlandiginda basliklar, gruplar ve mesaj akisina dogrudan gecersin.',
          ),
          SizedBox(height: low * 1.75),
          const _RegisterFeatureTile(
            icon: Icons.tune_rounded,
            title: 'Sana gore profil',
            description: 'Derece ve hesap bilgilerinle daha anlamli, sana uygun bir kullanim deneyimi kurulur.',
          ),
        ],
      ),
    );
  }
}

class _RegisterFeatureTile extends StatelessWidget {
  const _RegisterFeatureTile({
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
                  color: Colors.white.withValues(alpha: 0.80),
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
