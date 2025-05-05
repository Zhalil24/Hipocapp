import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/drawer/view/mixin/drawer_viwe_mixin.dart';
import 'package:hipocapp/feature/drawer/view/widget/custom_drawe_header.dart';
import 'package:hipocapp/feature/drawer/view/widget/menu_structure_widget.dart';
import 'package:hipocapp/feature/drawer/view/widget/sub_item_selection_widget.dart';
import 'package:hipocapp/feature/drawer/view/widget/titles_widget.dart';
import 'package:hipocapp/feature/drawer/view_model/drawer_view_model.dart';
import 'package:hipocapp/feature/drawer/view_model/state/drawer_view_state.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/utility/constans/titles/titles.dart';

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
            const CustomDrawerHeader(),
            MenuStructureWidget(
              menuStructure: menuStructure,
              onItemSelected: (backendValue) async {
                await drawerViewModel.getHeaderId(backendValue);
              },
            ),
            BlocBuilder<DrawerViewModel, DrawerViewState>(
              builder: (context, state) {
                return SubItemSelectionWidget(
                  descController: descController,
                  titleController: titleController,
                  message: state.serviceResultMessage,
                  isSubItemSelected: state.isSubItemSelected,
                  onCreateEntry: (title, desc) {
                    drawerViewModel.createEntry(title, desc);
                  },
                );
              },
            ),
            BlocBuilder<DrawerViewModel, DrawerViewState>(
              builder: (context, state) {
                return DrawerTitlesWidget(
                  titles: state.titles,
                  isLoading: state.isLoading,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
