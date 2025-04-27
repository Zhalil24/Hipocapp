import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/drawer/view/drawer_view.dart';
import 'package:hipocapp/feature/home/view/mixin/home_view_mixin.dart';
import 'package:hipocapp/feature/home/view_model/home_view_model.dart';
import 'package:hipocapp/feature/home/view_model/state/home_view_state.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/widget/appbar/custom_appbar_widget.dart';
import 'package:hipocapp/product/widget/custom_card_widget/custom_card_widget.dart';
import 'widget/entry_bar_widget.dart';

/// My Home Page
@RoutePage()
final class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeViewModel,
      child: Scaffold(
        appBar: CustomAppBar(),
        drawer: const DrawerView(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const EntryBarWidget(),
            Expanded(
              child: BlocBuilder<HomeViewModel, HomeViewState>(
                builder: (context, state) {
                  return state.isLastEntries ? const _LastEntriesList() : const _RandomEntriesList();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LastEntriesList extends StatelessWidget {
  const _LastEntriesList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeViewState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.lastEntries?.length ?? 0,
          itemBuilder: (context, index) {
            return CustomCardWidget(
              title: state.lastEntries![index].titleName.toString(),
              description: state.lastEntries![index].entryDescription.toString(),
              userName: 'Kullanıcı: ${state.lastEntries![index].userName}',
              date: 'Tarih: ${state.lastEntries![index].date}',
            );
          },
        );
      },
    );
  }
}

class _RandomEntriesList extends StatelessWidget {
  const _RandomEntriesList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeViewState>(
      builder: (context, state) {
        if (state.randomEntries == null) {
          context.read<HomeViewModel>().getRandomEntries();
          return const Center(child: CircularProgressIndicator());
        }
        if (state.randomEntries!.isEmpty) {
          return const Center(child: Text("Veri bulunamadı."));
        }
        return ListView.builder(
          itemCount: state.randomEntries!.length,
          itemBuilder: (context, index) {
            final entry = state.randomEntries![index];
            return CustomCardWidget(
              title: entry.titleName.toString(),
              description: entry.description.toString(),
              date: 'Tarih: ${entry.createDate}',
            );
          },
        );
      },
    );
  }
}
