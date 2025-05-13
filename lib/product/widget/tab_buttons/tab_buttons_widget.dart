import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/theme/custom_color_scheme.dart';

class TabButtonsWidget<T> extends StatelessWidget {
  const TabButtonsWidget({
    super.key,
    required this.onTap,
    required this.activeTabIndex,
    required this.tabs,
  });

  final void Function(int) onTap;
  final int activeTabIndex;
  final List<T> tabs;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: activeTabIndex,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ButtonsTabBar(
            backgroundColor: CustomColorScheme.darkColorScheme.primary,
            unselectedBackgroundColor: Colors.grey[300],
            unselectedLabelStyle: const TextStyle(color: Colors.black),
            labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            tabs: tabs.map((tab) {
              final label = (tab as dynamic).label as String;
              final icon = (tab as dynamic).icon as IconData;
              return Tab(icon: Icon(icon), text: label);
            }).toList(),
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
