import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/theme/custom_color_scheme.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:kartal/kartal.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({super.key});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends BaseState<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    final initialIndex = productViewModel.state.themeMode == ThemeMode.dark ? 1 : 0;
    return ToggleSwitch(
      minWidth: context.sized.width * 0.5,
      initialLabelIndex: initialIndex,
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.white,
      animate: true,
      totalSwitches: 2,
      labels: ['Light Theme', 'Dark Theme'],
      activeBgColors: [
        [CustomColorScheme.lightColorScheme.surface],
        [CustomColorScheme.darkColorScheme.tertiary],
      ],
      customTextStyles: const [
        TextStyle(color: Colors.black),
        TextStyle(color: Colors.white),
      ],
      onToggle: (index) {
        if (index == 0) {
          productViewModel.changeThemeMode(ThemeMode.light);
        } else {
          productViewModel.changeThemeMode(ThemeMode.dark);
        }
      },
    );
  }
}
