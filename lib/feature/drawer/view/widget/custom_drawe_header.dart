import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/product/widget/toggle_buton/toggle_button.dart';
import 'package:kartal/kartal.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DrawerHeader(
      decoration: BoxDecoration(
        color: colorScheme.primary,
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: context.sized.height * 0.06,
                  height: context.sized.height * 0.06,
                  child: Assets.images.logo.image(package: 'gen'),
                ),
                Text(
                  'HipocApp',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: context.sized.mediumValue,
                  ),
                )
              ],
            ),
            const ToggleButton(),
            Text(
              'Menü',
              style: TextStyle(
                color: Colors.white,
                fontSize: context.sized.normalValue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
