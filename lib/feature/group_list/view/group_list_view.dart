import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/group_list/view/mixin/group_list_mixin.dart';
import 'package:hipocapp/feature/group_list/view/widget/skeleton_card_widget.dart';
import 'package:hipocapp/feature/group_list/view_model/group_list_view_model.dart';
import 'package:hipocapp/feature/group_list/view_model/state/group_list_view_state.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/widget/appbar/custom_appbar_widget.dart';
import 'package:hipocapp/product/widget/button/custom_action_button/custom_action_button.dart';
import 'package:hipocapp/product/widget/custom_snackbar/service_snack_bar.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';

@RoutePage()
class GroupListView extends StatefulWidget {
  const GroupListView({super.key});

  @override
  State<GroupListView> createState() => _GroupListViewState();
}

class _GroupListViewState extends BaseState<GroupListView> with GroupListMixin {
  @override
  Widget build(BuildContext context) {
    String formatDate(String date) {
      final parsed = DateTime.parse(date);
      return DateFormat('dd.MM.yyyy').format(parsed);
    }

    return BlocProvider(
      create: (_) => groupListViewModel,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Kanal Listesi',
          isDrawer: false,
        ),
        body: BlocBuilder<GroupListViewModel, GroupListViewState>(
          builder: (context, state) {
            if (state.isLoading) {
              return ListView.builder(
                padding: EdgeInsets.all(context.sized.lowValue),
                itemCount: 5,
                itemBuilder: (_, __) => Padding(
                  padding: EdgeInsets.only(bottom: context.sized.lowValue),
                  child: const SkeletonCardWidget(),
                ),
              );
            }
            if (state.groupListModel?.isEmpty ?? true) {
              return const Center(
                child: Text('Gösterilecek kanal yok'),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(context.sized.lowValue),
              itemCount: state.groupListModel!.length,
              itemBuilder: (context, index) {
                final group = state.groupListModel![index];

                return Padding(
                  padding: EdgeInsets.only(bottom: context.sized.lowValue),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.sized.lowValue),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(context.sized.normalValue),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            group.groupName ?? 'İsimsiz Kanal',
                            style: TextStyle(
                              fontSize: context.sized.normalValue * 1.05,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (group.createdOn != null)
                            Text(
                              formatDate(group.createdOn!),
                              style: TextStyle(
                                fontSize: context.sized.normalValue * 0.7,
                              ),
                            ),
                          SizedBox(height: context.sized.lowValue),
                          Text(
                            group.description ?? 'Açıklama bulunmuyor.',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: context.sized.lowValue * 1.2),
                          if (productViewModel.state.isLogin)
                            Align(
                              alignment: Alignment.centerRight,
                              child: CustomActionButton(
                                onTop: () async {
                                  final resp = await groupListViewModel.sendGroupRequest(
                                    group.id ?? 0,
                                    productViewModel.state.currentUserId ?? 0,
                                  );

                                  if (!context.mounted) return;

                                  ServiceSnackBar.show(
                                    context,
                                    resp.message ?? 'Bir hata oluştu',
                                  );
                                },
                                text: 'Kanala Katıl',
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
