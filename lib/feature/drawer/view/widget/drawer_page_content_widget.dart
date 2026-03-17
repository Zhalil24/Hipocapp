import 'package:flutter/material.dart';
import 'package:hipocapp/feature/drawer/view/widget/custom_drawe_header.dart';
import 'package:hipocapp/feature/drawer/view/widget/menu_structure_widget.dart';
import 'package:hipocapp/feature/drawer/view/widget/sub_item_selection_widget.dart';
import 'package:hipocapp/feature/drawer/view/widget/titles_widget.dart';
import 'package:hipocapp/feature/drawer/view_model/state/drawer_view_state.dart';
import 'package:kartal/kartal.dart';

class DrawerPageContentWidget extends StatelessWidget {
  const DrawerPageContentWidget({
    super.key,
    required this.state,
    required this.menuStructure,
    required this.isLoggedIn,
    required this.userName,
    required this.themeMode,
    required this.onThemeChanged,
    required this.titleController,
    required this.descController,
    required this.onItemSelected,
    required this.onCreateEntry,
  });

  final DrawerViewState state;
  final Map<String, Map<String, String>> menuStructure;
  final bool isLoggedIn;
  final String? userName;
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;
  final TextEditingController titleController;
  final TextEditingController descController;
  final Future<void> Function(String) onItemSelected;
  final Future<void> Function(String, String) onCreateEntry;

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;
    final selectedHeaderText = state.headers.text?.trim();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        normal + (low * 0.35),
        normal + (low * 0.25),
        normal + (low * 0.55),
        normal * 1.4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomDrawerHeader(
            isLoggedIn: isLoggedIn,
            userName: userName,
            themeMode: themeMode,
            onThemeChanged: onThemeChanged,
          ),
          SizedBox(height: normal),
          MenuStructureWidget(
            menuStructure: menuStructure,
            selectedHeaderText: selectedHeaderText,
            onItemSelected: onItemSelected,
          ),
          if (state.isSubItemSelected) ...[
            SizedBox(height: normal),
            SubItemSelectionWidget(
              isSubItemSelected: state.isSubItemSelected,
              isLoggedIn: isLoggedIn,
              selectedHeaderText: selectedHeaderText,
              titleController: titleController,
              descController: descController,
              onCreateEntry: onCreateEntry,
            ),
          ],
          SizedBox(height: normal),
          DrawerTitlesWidget(
            titles: state.titles,
            isLoading: state.isLoading,
            selectedHeaderText: selectedHeaderText,
          ),
        ],
      ),
    );
  }
}
