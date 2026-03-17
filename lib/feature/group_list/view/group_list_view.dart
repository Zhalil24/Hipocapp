import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/group_list/view/mixin/group_list_mixin.dart';
import 'package:hipocapp/feature/group_list/view/widget/group_list_background_widget.dart';
import 'package:hipocapp/feature/group_list/view/widget/group_list_page_content_widget.dart';
import 'package:hipocapp/feature/group_list/view_model/group_list_view_model.dart';
import 'package:hipocapp/feature/group_list/view_model/state/group_list_view_state.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/widget/appbar/custom_appbar_widget.dart';
import 'package:hipocapp/product/widget/custom_snackbar/service_snack_bar.dart';

@RoutePage()
class GroupListView extends StatefulWidget {
  const GroupListView({super.key});

  @override
  State<GroupListView> createState() => _GroupListViewState();
}

class _GroupListViewState extends BaseState<GroupListView> with GroupListMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => groupListViewModel,
      child: Stack(
        children: [
          const Positioned.fill(
            child: GroupListBackgroundWidget(),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: const CustomAppBar(
              title: 'Kanal Listesi',
              isDrawer: false,
            ),
            body: BlocBuilder<GroupListViewModel, GroupListViewState>(
              builder: (context, state) {
                return GroupListPageContentWidget(
                  state: state,
                  isLoggedIn: productViewModel.state.isLogin,
                  onRefresh: groupListViewModel.getGroupList,
                  onJoinGroup: _joinGroup,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _joinGroup(int groupId) async {
    final userId = productViewModel.state.currentUserId;
    if (userId == null) {
      ServiceSnackBar.show(
        context,
        'Kanala katilmak icin once giris yapman gerekiyor.',
      );
      return;
    }

    final response = await groupListViewModel.sendGroupRequest(groupId, userId);

    if (!mounted) return;

    ServiceSnackBar.show(
      context,
      response.message ?? 'Katilim talebin su an islenemedi.',
    );
  }
}
