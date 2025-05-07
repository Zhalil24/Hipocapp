import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:kartal/kartal.dart'; // gen kullanıyorsan bunu unutma

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final circleColor = isDark ? Colors.white : Colors.black;

    return SizedBox(
      width: context.sized.height * 5,
      height: context.sized.height * 5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: context.sized.height * 5,
            height: context.sized.height * 5,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(circleColor),
            ),
          ),
          // Ortadaki logo
          Padding(
            padding: const EdgeInsets.all(6), // hafif içe al logo taşmasın
            child: Assets.images.logo.image(package: 'gen'),
          ),
        ],
      ),
    );
  }
}
