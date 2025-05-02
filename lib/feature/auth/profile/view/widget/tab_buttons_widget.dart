import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/theme/custom_color_scheme.dart';
import 'package:hipocapp/product/utility/enums/profile_tab_type.dart';

class TabButtonsWidget extends StatefulWidget {
  const TabButtonsWidget({
    super.key,
    required this.onTap,
    required this.activeTabIndex,
  });
  final void Function(int) onTap;
  final int activeTabIndex;

  @override
  State<TabButtonsWidget> createState() => _TabButtonsWidgetState();
}

class _TabButtonsWidgetState extends State<TabButtonsWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: widget.activeTabIndex,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ButtonsTabBar(
            backgroundColor: CustomColorScheme.darkColorScheme.primary,
            unselectedBackgroundColor: Colors.grey[300],
            unselectedLabelStyle: TextStyle(color: Colors.black),
            labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            tabs: [
              Tab(
                icon: const Icon(Icons.person),
                text: ProfileTabType.profile.label,
              ),
              Tab(
                icon: const Icon(Icons.account_circle),
                text: ProfileTabType.editProfile.label,
              ),
              Tab(
                icon: const Icon(Icons.vpn_key),
                text: ProfileTabType.changePassword.label,
              ),
              Tab(
                icon: const Icon(Icons.library_books),
                text: ProfileTabType.entries.label,
              ),
            ],
            onTap: widget.onTap,
          ),
        ],
      ),
    );
  }
}
