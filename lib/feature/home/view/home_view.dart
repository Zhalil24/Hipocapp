import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/drawer/view/drawer_view.dart';
import 'package:hipocapp/feature/home/view/mixin/home_view_mixin.dart';
import 'package:hipocapp/feature/home/view/widget/bottom_navigation_bar_widget.dart';
import 'package:hipocapp/feature/home/view/widget/content_card_widget.dart';
import 'package:hipocapp/feature/home/view/widget/search_bar_widget.dart';
import 'package:hipocapp/feature/home/view_model/home_view_model.dart';
import 'package:hipocapp/feature/home/view_model/state/home_view_state.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/utility/enums/content_type.dart';
import 'package:hipocapp/product/widget/appbar/custom_appbar_widget.dart';
import 'package:hipocapp/product/widget/custom_card_widget/custom_card_widget.dart';
import 'package:hipocapp/product/widget/custom_loader/custom_loader_widget.dart';
import 'package:kartal/kartal.dart';
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
        appBar: const CustomAppBar(
          title: 'Anasayfa',
        ),
        drawer: const DrawerView(),
        bottomNavigationBar: BottomNavigationBarWidget(
          onItemSelected: (value) {
            homeViewModel.handleNavigation(context, value);
          },
        ),
        body: _buildHomeBody(),
      ),
    );
  }

  BlocBuilder<HomeViewModel, HomeViewState> _buildHomeBody() {
    return BlocBuilder<HomeViewModel, HomeViewState>(
      builder: (context, state) {
        if (state.contentType != ContentTypeEnum.home.value) {
          return const ContentWidget();
        }
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: context.sized.mediumValue * 3.5),
              child: state.isLoading
                  ? const Center(child: CustomLoader())
                  : _HomeContent(
                      isLastEntries: state.isLastEntries,
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(top: context.sized.mediumValue * 2),
              child: const EntryBarWidget(),
            ),
            SearchBarWidget(
              (String value) {
                if (value.isEmpty) {
                  homeViewModel.clearTitleResults();
                  return;
                }
                timer?.cancel();
                timer = Timer(const Duration(milliseconds: 500), () {
                  homeViewModel.searchEntriesByTitleName(value);
                });
              },
              textController,
              state.titleModel,
              state.isLoadingSearchbar,
            ),
          ],
        );
      },
    );
  }
}

class _HomeContent extends StatelessWidget {
  final bool isLastEntries;

  const _HomeContent({required this.isLastEntries});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: isLastEntries ? const _LastEntriesList() : const _RandomEntriesList(),
        ),
      ],
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
              userName: state.lastEntries![index].userName,
              date: 'Tarih: ${state.lastEntries![index].date}',
              userId: state.lastEntries![index].userId,
              isHomeCard: true,
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
        return ListView.builder(
          itemCount: state.randomEntries!.length,
          itemBuilder: (context, index) {
            final entry = state.randomEntries![index];
            return CustomCardWidget(
              isHomeCard: false,
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

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeViewState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CustomLoader(),
          );
        }
        if (state.contentModel.isEmpty) {
          return const Center(
            child: Text('İçerik Bulunmamaktadır'),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: state.contentModel.length,
          itemBuilder: (context, index) {
            final item = state.contentModel[index];
            return ContentCard(
              imageUrl: 'https:${item.imageURL}',
              title: item.title ?? '',
              link: item.link ?? '',
              description: item.description ?? '',
            );
          },
        );
      },
    );
  }
}
