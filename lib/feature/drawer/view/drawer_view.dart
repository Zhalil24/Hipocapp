import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/drawer/view/mixin/drawer_viwe_mixin.dart';
import 'package:hipocapp/feature/drawer/view/widget/drawer_background_widget.dart';
import 'package:hipocapp/feature/drawer/view/widget/drawer_page_content_widget.dart';
import 'package:hipocapp/feature/drawer/view_model/drawer_view_model.dart';
import 'package:hipocapp/feature/drawer/view_model/state/drawer_view_state.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/state/view_model/prodcut_state.dart';
import 'package:hipocapp/product/state/view_model/product_view_model.dart';
import 'package:hipocapp/product/utility/constans/titles/titles.dart';
import 'package:hipocapp/product/utility/extension/service_snack_bar.dart';
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
      child: BlocListener<DrawerViewModel, DrawerViewState>(
        listenWhen: (prev, curr) =>
            prev.serviceResponseMessage != curr.serviceResponseMessage &&
            curr.serviceResponseMessage != null,
        listener: (context, state) {
          final msg = state.serviceResponseMessage;
          if (msg != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              createServiceSnackBar(msg),
            );
            context.read<DrawerViewModel>().clearServiceMessage();
          }
        },
        child: Drawer(
          width: context.sized.width > 480 ? 420 : context.sized.width * 0.88,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(28),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(28),
            ),
            child: Stack(
              children: [
                const Positioned.fill(
                  child: DrawerBackgroundWidget(),
                ),
                SafeArea(
                  child: BlocBuilder<ProductViewModel, ProdcutState>(
                    bloc: productViewModel,
                    builder: (context, productState) {
                      return BlocBuilder<DrawerViewModel, DrawerViewState>(
                        builder: (context, state) {
                          return DrawerPageContentWidget(
                            state: state,
                            menuStructure: menuStructure,
                            isLoggedIn: productState.isLogin,
                            userName: productState.userName,
                            themeMode: productState.themeMode,
                            scrollController: drawerScrollController,
                            contributionSectionKey: contributionSectionKey,
                            onThemeChanged: (mode) async {
                              await productViewModel.changeThemeMode(mode);
                            },
                            titleController: titleController,
                            descController: descController,
                            onItemSelected: (backendValue) async {
                              await drawerViewModel.getHeaderId(backendValue);
                              if (!mounted) return;
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                final targetContext =
                                    contributionSectionKey.currentContext;
                                if (targetContext == null) return;
                                Scrollable.ensureVisible(
                                  targetContext,
                                  duration: const Duration(milliseconds: 420),
                                  curve: Curves.easeOutCubic,
                                  alignment: 0.08,
                                );
                              });
                            },
                            onCreateEntry: (title, desc) async {
                              final userId = productState.currentUserId;
                              if (userId == null) {
                                return;
                              }
                              await drawerViewModel.createEntry(
                                title,
                                desc,
                                userId,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
