import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class RegisterBackgroundWidget extends StatelessWidget {
  const RegisterBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppAmbientBackground(
      style: AppAmbientBackgroundStyle.register,
    );
  }
}
