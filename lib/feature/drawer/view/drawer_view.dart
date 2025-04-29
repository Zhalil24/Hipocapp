import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/drawer/view/mixin/drawer_viwe_mixin.dart';
import 'package:hipocapp/feature/drawer/view/widget/input_dialog_widget.dart';
import 'package:hipocapp/feature/drawer/view/widget/menu_button_text_widget.dart';
import 'package:hipocapp/feature/drawer/view/widget/toggle_button.dart';
import 'package:hipocapp/feature/drawer/view_model/drawer_view_model.dart';
import 'package:hipocapp/feature/drawer/view_model/state/drawer_view_state.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/utility/constans/titles/titles.dart';
import 'package:kartal/kartal.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends BaseState<DrawerView> with DrawerViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => drawerViewModel,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF7B1E3A),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ToggleButton(),
                    Text(
                      'Menü',
                      style: TextStyle(color: Colors.white, fontSize: context.sized.normalValue),
                    ),
                  ],
                ),
              ),
            ),

            // 🔽 Menü yapısı
            ...menuStructure.entries.map((mainEntry) {
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
                        await drawerViewModel.getHeaderId(backendValue);
                      },
                    ),
                  );
                }).toList(),
              );
            }),

            BlocBuilder<DrawerViewModel, DrawerViewState>(
              builder: (context, state) {
                if (!state.isSubItemSelected) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (context) => InputDialogWidget(
                            onSubmit: (title, desc) {
                              drawerViewModel.createEntry(title, desc);
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue),
                        ),
                        child: const Text(
                          'Başlık Aç',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              },
            ),

            // 🔽 Titles listesi
            BlocBuilder<DrawerViewModel, DrawerViewState>(
              builder: (context, state) {
                final titles = state.titles;

                if (titles.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Başlık Bulunmamaktadır'),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    const MenuButtonTextWidget(
                      text: 'Başlıklar:',
                    ),
                    ...titles.map((title) => TextButton(
                        onPressed: () {
                          context.router.push(EntryListRoute(
                            titleName: title.name ?? '',
                            headerId: title.headerId ?? 0,
                          ));
                        },
                        child: MenuButtonTextWidget(
                          text: '• ${title.name} >',
                        ))),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
