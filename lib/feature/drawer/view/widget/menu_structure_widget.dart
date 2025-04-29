import 'package:flutter/material.dart';
import 'package:hipocapp/feature/drawer/view/widget/menu_button_text_widget.dart';

class MenuStructureWidget extends StatelessWidget {
  final Map<String, Map<String, dynamic>> menuStructure;
  final void Function(String) onItemSelected;

  const MenuStructureWidget({
    Key? key,
    required this.menuStructure,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: menuStructure.entries.map((mainEntry) {
        final mainTitle = mainEntry.key;
        final subItems = mainEntry.value;

        return ExpansionTile(
          leading: const Icon(Icons.arrow_right),
          title: MenuButtonTextWidget(
            text: mainTitle,
          ),
          children: subItems.entries.map((subEntry) {
            final visibleText = subEntry.key;
            final backendValue = subEntry.value;

            return Builder(
              builder: (context) => ListTile(
                title: MenuButtonTextWidget(text: visibleText),
                onTap: () async {
                  onItemSelected(backendValue.toString());
                },
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
