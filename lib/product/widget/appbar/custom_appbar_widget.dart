import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/state/view_model/prodcut_state.dart';
import 'package:hipocapp/product/state/view_model/product_view_model.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isDrawer;
  final String? title;

  const CustomAppBar({super.key, this.isDrawer = true, this.title});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends BaseState<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      title: Text(
        widget.title ?? '',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
      ),
      leading: widget.isDrawer
          ? IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
              color: colorScheme.onSurface,
            )
          : IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
              color: colorScheme.onSurface,
            ),
      actions: [
        BlocBuilder<ProductViewModel, ProdcutState>(
          buildWhen: (prev, curr) => prev.isLogin != curr.isLogin,
          builder: (context, state) {
            if (state.isLogin) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chat),
                    onPressed: () => context.router.push(ChatUserListRoute()),
                    color: colorScheme.onSurface,
                  ),
                  IconButton(
                    icon: const Icon(Icons.person),
                    onPressed: () => context.router.push(const ProfilRoute()),
                    color: colorScheme.onSurface,
                  ),
                ],
              );
            }
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () => context.router.push(const LoginRoute()),
                  child: const Text('Giriş Yap'),
                ),
                TextButton(
                  onPressed: () => context.router.push(const RegisterRoute()),
                  child: const Text('Kayıt Ol'),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
