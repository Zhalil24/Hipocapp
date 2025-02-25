import 'package:flutter/material.dart';
import 'package:gen/gen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: SizedBox(
            width: 60,
            height: 50,
            child: Assets.images.logo.image(package: 'gen'),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
