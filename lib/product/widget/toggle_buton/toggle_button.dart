import 'package:flutter/material.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final initialIndex = productViewModel.state.themeMode == ThemeMode.dark ? 1 : 0;
    return ToggleSwitch(
      minWidth: context.sized.width * 0.5,
      initialLabelIndex: initialIndex,
      totalSwitches: 2,
      animate: true,
      labels: const ['Light Theme', 'Dark Theme'],
      activeBgColors: [
        [colorScheme.primary],
        const [Colors.black],
      ],
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey.shade300,
      inactiveFgColor: Colors.black,
      onToggle: (index) async {
        if (index == 0) {
          await productViewModel.changeThemeMode(ThemeMode.light);
        } else {
          await productViewModel.changeThemeMode(ThemeMode.dark);
        }
      },
    );
  }
}
