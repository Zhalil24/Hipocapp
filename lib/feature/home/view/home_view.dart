import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/drawer/view/drawer_view.dart';
import 'package:hipocapp/feature/home/view/mixin/home_view_mixin.dart';
import 'package:hipocapp/feature/home/view/widget/auto_sliding_group_container.dart';
import 'package:hipocapp/feature/home/view/widget/bottom_navigation_bar_widget.dart';
import 'package:hipocapp/feature/home/view/widget/content_card_skeleton_widget.dart';
import 'package:hipocapp/feature/home/view/widget/content_card_widget.dart';
import 'package:hipocapp/feature/home/view/widget/search_bar_widget.dart';
import 'package:hipocapp/feature/home/view_model/home_view_model.dart';
import 'package:hipocapp/feature/home/view_model/state/home_view_state.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/utility/enums/content_type.dart';
import 'package:hipocapp/product/widget/appbar/custom_appbar_widget.dart';
import 'package:hipocapp/product/widget/custom_card_widget/custom_card_skeleton_widget.dart';
import 'package:hipocapp/product/widget/custom_card_widget/custom_card_widget.dart';
import 'package:hipocapp/product/widget/login_popup/login_required_popup.dart';
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
      child: Stack(children: [
        Scaffold(
          appBar: const CustomAppBar(title: 'Anasayfa'),
          drawer: const DrawerView(),
          bottomNavigationBar: BottomNavigationBarWidget(
            onItemSelected: (value) => homeViewModel.handleNavigation(context, value),
          ),
          body: BlocBuilder<HomeViewModel, HomeViewState>(
            builder: (context, state) {
              if (state.contentType != ContentTypeEnum.home.value) {
                if (state.isLoading) {
                  return ListView.builder(
                    itemCount: 3,
                    itemBuilder: (_, __) => const ContentCardSkeleton(),
                  );
                }
                if (state.contentModel.isEmpty) {
                  return const Center(child: Text('İçerik Bulunmamaktadır'));
                }
                return ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.only(top: context.sized.normalValue * 5, left: context.sized.lowValue, right: context.sized.lowValue),
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
                              child: AutoSlidingGroupContainer(
                                groups: state.groupListModel ?? const [],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: context.sized.normalValue),
                              child: const EntryBarWidget(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: context.sized.lowValue * 2),
                              child: state.isLoading
                                  ? Column(
                                      children: List.generate(
                                        5,
                                        (_) => const CustomCardWidgetSkeleton(),
                                      ),
                                    )
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
                  Padding(
                    padding: EdgeInsets.only(top: context.sized.lowValue * 0.1),
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
        LoginRequiredPopup(
          onLoginPressed: () async {
            await context.router.push(const LoginRoute());
          },
        ),
      ]),
    );
  }
}
