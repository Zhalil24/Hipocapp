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
    return BlocProvider<HomeViewModel>(
      create: (_) => homeViewModel,
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Anasayfa'),
        drawer: const DrawerView(),
        bottomNavigationBar: BottomNavigationBarWidget(
          onItemSelected: (value) => homeViewModel.handleNavigation(context, value),
        ),
        body: SafeArea(
          child: BlocBuilder<HomeViewModel, HomeViewState>(
            builder: (context, state) {
              if (state.contentType != ContentTypeEnum.home.value) {
                if (state.isLoading) {
                  return const Center(child: CustomLoader());
                }
                if (state.contentModel.isEmpty) {
                  return const Center(child: Text('İçerik Bulunmamaktadır'));
                }
                return ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.all(context.sized.normalValue),
                  itemCount: state.contentModel.length,
                  itemBuilder: (ctx, i) {
                    final item = state.contentModel[i];
                    return ContentCard(
                      imageUrl: item.imageURL ?? '',
                      title: item.title ?? '',
                      link: item.link ?? '',
                      description: item.description ?? '',
                    );
                  },
                );
              }
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: context.sized.mediumValue * 2),
                              child: const EntryBarWidget(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: context.sized.lowValue),
                              child: state.isLoading
                                  ? Center(
                                      child: Padding(
                                      padding: EdgeInsets.only(top: context.sized.highValue * 2.5),
                                      child: const CustomLoader(),
                                    ))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: state.isLastEntries ? (state.lastEntries?.length ?? 0) : (state.randomEntries?.length ?? 0),
                                      itemBuilder: (ctx, i) {
                                        if (state.isLastEntries) {
                                          final entry = state.lastEntries![i];
                                          return CustomCardWidget(
                                            isHomeCard: true,
                                            title: entry.titleName ?? ' ',
                                            description: entry.entryDescription ?? ' ',
                                            userName: entry.userName,
                                            date: 'Tarih: ${entry.date}',
                                            userId: entry.userId,
                                          );
                                        } else {
                                          final entry = state.randomEntries![i];
                                          return CustomCardWidget(
                                            isHomeCard: true,
                                            title: entry.titleName ?? ' ',
                                            description: entry.description ?? ' ',
                                            date: 'Tarih: ${entry.createDate}',
                                          );
                                        }
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.sized.highValue * 10,
                    child: SearchBarWidget(
                      (value) {
                        if (value.isEmpty) {
                          homeViewModel.clearTitleResults();
                          return;
                        }
                        timer?.cancel();
                        timer = Timer(
                          const Duration(milliseconds: 500),
                          () => homeViewModel.searchEntriesByTitleName(value),
                        );
                      },
                      textController,
                      state.titleModel,
                      state.isLoadingSearchbar,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
