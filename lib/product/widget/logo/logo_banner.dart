import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:kartal/kartal.dart';

class LogoBanner extends StatelessWidget {
  const LogoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.sized.mediumValue),
      child: SizedBox(
        width: context.sized.height * 0.3,
        height: context.sized.height * 0.3,
        child: Assets.images.logo.image(package: 'gen'),
      ),
    );
  }
}
