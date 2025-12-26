// import 'package:flutter/material.dart';

// class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
//   const AppbarWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: const Center(
//         child: Text(
//           'Hipocapp',
//           style: TextStyle(
//             fontWeight: FontWeight.w700,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: AppBar(
          backgroundColor: colorScheme.surface.withValues(alpha: 0.6),
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
          title: Text(
            'Hipocapp',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
          iconTheme: IconThemeData(
            color: colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
