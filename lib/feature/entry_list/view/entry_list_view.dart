import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/entry_list/view/mixin/entry_list_view_mixin.dart';
import 'package:hipocapp/feature/entry_list/view_model/entry_list_view_model.dart';
import 'package:hipocapp/feature/entry_list/view_model/state/entry_list_view_state.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/widget/appbar/custom_appbar_widget.dart';
import 'package:hipocapp/product/widget/button/custom_action_button/custom_action_button.dart';
import 'package:hipocapp/product/widget/custom_card_widget/custom_card_widget.dart';
import 'package:kartal/kartal.dart';

@RoutePage()
class EntryListView extends StatefulWidget {
  final String titleName;
  final int headerId;

  const EntryListView({
    super.key,
    required this.titleName,
    required this.headerId,
  });

  @override
  State<EntryListView> createState() => _EntryListViewState();
}

class _EntryListViewState extends BaseState<EntryListView> with EntryListViewMixin {
  final TextEditingController _entryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => entryListViewModel,
      child: Scaffold(
        appBar: const CustomAppBar(isDrawer: false),
        body: Column(
          children: [
            // 🆕 Entry yazma alanı
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.padding.horizontalLow.horizontal,
                vertical: context.padding.verticalLow.vertical,
              ),
              child: BlocBuilder<EntryListViewModel, EntryListViewState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: _entryController,
                        minLines: 2,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          hintText: 'Yeni entry yaz...',
                          border: OutlineInputBorder(),
                        ),
                      )),
                      const SizedBox(width: 8),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     final text = _entryController.text.trim();
                      //     if (text.isNotEmpty) {
                      //       entryListViewModel.createEntry(
                      //         widget.titleName,
                      //         text,
                      //         widget.headerId,
                      //       );
                      //       _entryController.clear();
                      //     }
                      //   },
                      //   child: const Text('Ekle'),
                      // ),
                      CustomActionButton(
                        onTop: () {
                          final text = _entryController.text.trim();
                          if (text.isNotEmpty) {
                            entryListViewModel.createEntry(
                              widget.titleName,
                              text,
                              widget.headerId,
                            );
                            _entryController.clear();
                          }
                        },
                        text: 'Ekle',
                        message: state.serviceResultMessage ?? '',
                      )
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
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.entryListModel == null || state.entryListModel!.isEmpty) {
                    return const Center(child: Text("Entry bulunamadı."));
                  }

                  return ListView.builder(
                    itemCount: state.entryListModel!.length,
                    itemBuilder: (context, index) {
                      final entry = state.entryListModel![index];
                      return CustomCardWidget(
                        title: entry.titleName.toString(),
                        description: entry.entryDescription.toString(),
                        userName: '${entry.userName}',
                        date: '${entry.date}',
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
