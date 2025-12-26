import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/entry_list/view/mixin/entry_list_view_mixin.dart';
import 'package:hipocapp/feature/entry_list/view_model/entry_list_view_model.dart';
import 'package:hipocapp/feature/entry_list/view_model/state/entry_list_view_state.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/utility/extension/service_snack_bar.dart';
import 'package:hipocapp/product/utility/validator/validator.dart';
import 'package:hipocapp/product/widget/appbar/custom_appbar_widget.dart';
import 'package:hipocapp/product/widget/button/custom_action_button/custom_action_button.dart';
import 'package:hipocapp/product/widget/custom_card_widget/custom_card_widget.dart';
import 'package:hipocapp/product/widget/custom_loader/custom_loader_widget.dart';
import 'package:kartal/kartal.dart';

@RoutePage()
class EntryListView extends StatefulWidget {
  final String titleName;
  final int headerId;
  final int userId;

  const EntryListView({
    super.key,
    required this.titleName,
    required this.headerId,
    required this.userId,
  });

  @override
  State<EntryListView> createState() => _EntryListViewState();
}

class _EntryListViewState extends BaseState<EntryListView> with EntryListViewMixin {
  final TextEditingController _entryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => entryListViewModel,
      child: BlocListener<EntryListViewModel, EntryListViewState>(
        listenWhen: (prev, curr) => prev.serviceResponseMessage != curr.serviceResponseMessage && curr.serviceResponseMessage != null,
        listener: (context, state) {
          final msg = state.serviceResponseMessage;
          if (msg != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              createServiceSnackBar(msg),
            );
            context.read<EntryListViewModel>().clearServiceMessage();
          }
        },
        child: Scaffold(
          appBar: CustomAppBar(
            isDrawer: false,
            title: widget.titleName,
          ),
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.only(
                    left: context.sized.normalValue,
                    right: context.sized.normalValue,
                    top: context.sized.normalValue,
                  ),
                  child: BlocBuilder<EntryListViewModel, EntryListViewState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          if (productViewModel.state.isLogin) ...[
                            Expanded(
                                child: TextFormField(
                              validator: Validators.notEmpty,
                              controller: _entryController,
                              minLines: 2,
                              maxLines: 10,
                              decoration: const InputDecoration(
                                hintText: 'Yeni entry yaz...',
                                border: OutlineInputBorder(),
                              ),
                            )),
                            SizedBox(width: context.sized.lowValue),
                            CustomActionButton(
                              text: 'Ekle',
                              onTop: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  final text = _entryController.text.trim();
                                  entryListViewModel.createEntry(
                                    widget.titleName,
                                    text,
                                    widget.headerId,
                                    productViewModel.state.currentUserId!,
                                  );
                                  _entryController.clear();
                                }
                              },
                            ),
                          ]
                        ],
                      );
                    },
                  ),
                ),

                // Liste bölümü
                Expanded(
                  child: BlocBuilder<EntryListViewModel, EntryListViewState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CustomLoader());
                      }

                      if (state.entryListModel == null || state.entryListModel!.isEmpty) {
                        return const Center(child: Text("Entry bulunamadı."));
                      }

                      return ListView.builder(
                        itemCount: state.entryListModel!.length,
                        itemBuilder: (context, index) {
                          final entry = state.entryListModel![index];
                          return CustomCardWidget(
                            isHomeCard: true,
                            title: entry.titleName.toString(),
                            description: entry.entryDescription.toString(),
                            userName: '${entry.userName}',
                            date: '${entry.date}',
                            userId: widget.userId,
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
