import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/navigation/app_router.dart';

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
          icon: const Icon(Icons.chat),
          onPressed: () {
            context.router.push(const ChatUserListRoute());
          },
        ),
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            context.router.push(const ProfilRoute());
          },
        ),
      ],
    );
  }
}
