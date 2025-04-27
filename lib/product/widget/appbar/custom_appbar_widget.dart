import 'package:flutter/material.dart';
import 'package:gen/gen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDrawer;
  const CustomAppBar({super.key, this.isDrawer = true});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isDrawer
          ? IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            )
          : IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
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
