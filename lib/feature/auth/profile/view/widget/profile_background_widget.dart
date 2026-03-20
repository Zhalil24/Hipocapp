import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class ProfileBackgroundWidget extends StatelessWidget {
  const ProfileBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppAmbientBackground(
      style: AppAmbientBackgroundStyle.profile,
    );
  }
}
