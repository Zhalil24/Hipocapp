import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/theme/custom_color_scheme.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:kartal/kartal.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key, required this.onItemSelected});
  final ValueChanged<int> onItemSelected;
  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends BaseState<BottomNavigationBarWidget> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
        backgroundColor: CustomColorScheme.lightColorScheme.primary,
        height: context.sized.height * 0.055,
        initialActiveIndex: _selectedIndex,
        items: const [
          TabItem(icon: Icons.home, title: 'Anasayfa'),
          TabItem(icon: Icons.shop, title: 'Market'),
          TabItem(icon: Icons.notifications, title: 'İlanlar'),
          TabItem(icon: Icons.group, title: 'Partnerler'),
          TabItem(icon: Icons.auto_stories, title: 'Eğitimler'),
        ],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          widget.onItemSelected(index);
        });
  }
}
