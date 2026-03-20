import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:kartal/kartal.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({
    super.key,
    required this.onItemSelected,
  });

  final ValueChanged<int> onItemSelected;

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: colorScheme.primary,
            width: 0.5,
          ),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: context.sized.normalValue,
        selectedFontSize: context.sized.lowValue * 1.3,
        unselectedFontSize: context.sized.lowValue,
        backgroundColor: colorScheme.onPrimary,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurface.withValues(alpha: 0.6),
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          widget.onItemSelected(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: LocaleKeys.home_bottom_nav_home.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shop_outlined),
            activeIcon: const Icon(Icons.shop),
            label: LocaleKeys.home_bottom_nav_market.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications_none),
            activeIcon: const Icon(Icons.notifications),
            label: LocaleKeys.home_bottom_nav_announcements.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.group_outlined),
            activeIcon: const Icon(Icons.group),
            label: LocaleKeys.home_bottom_nav_partners.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.auto_stories_outlined),
            activeIcon: const Icon(Icons.auto_stories),
            label: LocaleKeys.home_bottom_nav_trainings.tr(),
          ),
        ],
      ),
    );
  }
}
