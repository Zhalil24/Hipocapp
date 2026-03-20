import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/entry_list/view/mixin/entry_list_view_mixin.dart';
import 'package:hipocapp/feature/entry_list/view/widget/entry_list_background_widget.dart';
import 'package:hipocapp/feature/entry_list/view/widget/entry_list_page_content_widget.dart';
import 'package:hipocapp/feature/entry_list/view_model/entry_list_view_model.dart';
import 'package:hipocapp/feature/entry_list/view_model/state/entry_list_view_state.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/utility/extension/service_snack_bar.dart';
import 'package:hipocapp/product/widget/appbar/custom_appbar_widget.dart';

@RoutePage()
class EntryListView extends StatefulWidget {
  const EntryListView({
    required this.titleName,
    required this.headerId,
    required this.userId,
    super.key,
  });

  final String titleName;
  final int headerId;
  final int userId;

  @override
  State<EntryListView> createState() => _EntryListViewState();
}

class _EntryListViewState extends BaseState<EntryListView>
    with EntryListViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => entryListViewModel,
      child: BlocListener<EntryListViewModel, EntryListViewState>(
        listenWhen: (prev, curr) =>
            prev.serviceResponseMessage != curr.serviceResponseMessage &&
            curr.serviceResponseMessage != null,
        listener: (context, state) {
          final message = state.serviceResponseMessage;
          if (message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              createServiceSnackBar(message),
            );
            context.read<EntryListViewModel>().clearServiceMessage();
          }
        },
        child: Stack(
          children: [
            const Positioned.fill(
              child: EntryListBackgroundWidget(),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: CustomAppBar(
                isDrawer: false,
                title: widget.titleName,
              ),
              body: BlocBuilder<EntryListViewModel, EntryListViewState>(
                builder: (context, state) {
                  return EntryListPageContentWidget(
                    titleName: widget.titleName,
                    entries: state.entryListModel ?? const [],
                    isLoading: state.isLoading,
                    isLoggedIn: productViewModel.state.isLogin,
                    userId: widget.userId,
                    formKey: formKey,
                    entryController: entryController,
                    entryFocusNode: entryFocusNode,
                    onSubmitEntry: submitEntry,
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
