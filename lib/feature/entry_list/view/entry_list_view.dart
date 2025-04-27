import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/entry_list/view/mixin/entry_list_view_mixin.dart';
import 'package:hipocapp/feature/entry_list/view_model/entry_list_view_model.dart';
import 'package:hipocapp/feature/entry_list/view_model/state/entry_list_view_state.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/widget/appbar/custom_appbar_widget.dart';
import 'package:hipocapp/product/widget/custom_card_widget/custom_card_widget.dart';

@RoutePage()
class EntryListView extends StatefulWidget {
  final String titleName;
  const EntryListView({super.key, required this.titleName});

  @override
  State<EntryListView> createState() => _EntryListViewState();
}

class _EntryListViewState extends BaseState<EntryListView> with EntryListViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => entryListViewModel,
      child: Scaffold(
        appBar: const CustomAppBar(isDrawer: false),
        body: Column(
          children: [
            Expanded(
              // ListView'ı kapsasın diye
              child: BlocBuilder<EntryListViewModel, EntryListViewState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.entryListModel == null || state.entryListModel!.isEmpty) {
                    return const Center(child: Text("Entry bulunamadı."));
                  }

                  return ListView.builder(
                    itemCount: state.entryListModel!.length,
                    itemBuilder: (context, index) {
                      return CustomCardWidget(
                        title: state.entryListModel![index].titleName.toString(),
                        description: state.entryListModel![index].entryDescription.toString(),
                        userName: '${state.entryListModel![index].userName}',
                        date: '${state.entryListModel![index].date}',
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
