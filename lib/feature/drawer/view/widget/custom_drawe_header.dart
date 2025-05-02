import 'package:flutter/material.dart';
import 'package:hipocapp/product/widget/toggle_buton/toggle_button.dart';
import 'package:kartal/kartal.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Color(0xFF7B1E3A),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ToggleButton(),
            Text(
              'Menü',
              style: TextStyle(color: Colors.white, fontSize: context.sized.normalValue),
            ),
          ],
        ),
      ),
    );
  }
}
