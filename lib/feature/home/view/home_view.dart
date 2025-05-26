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
import 'package:hipocapp/product/utility/constans/duration/duration_constants.dart';
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
        body: Stack(
          children: [
            _buildHomeBody(),
            AnimatedSlide(
              duration: DurationConstants.animatedSlideDuration,
              curve: Curves.fastOutSlowIn,
              offset: isBottomBarVisible ? Offset.zero : const Offset(0, 1),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: BottomNavigationBarWidget(
                  onItemSelected: (value) {
                    homeViewModel.handleNavigation(context, value);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BlocBuilder<HomeViewModel, HomeViewState> _buildHomeBody() {
    return BlocBuilder<HomeViewModel, HomeViewState>(
      builder: (context, state) {
        if (state.contentType != ContentTypeEnum.home.value) {
          return ContentWidget(
            scrollController: scrollController,
          );
        }
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: context.sized.mediumValue * 3.5),
              child: state.isLoading
                  ? const Center(child: CustomLoader())
                  : _HomeContent(
                      scrollController: scrollController,
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
  final ScrollController scrollController;
  const _HomeContent({required this.isLastEntries, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: isLastEntries
              ? _LastEntriesList(
                  scrollController: scrollController,
                )
              : _RandomEntriesList(
                  scrollController: scrollController,
                ),
        ),
      ],
    );
  }
}

class _LastEntriesList extends StatelessWidget {
  final ScrollController scrollController;
  const _LastEntriesList({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeViewState>(
      builder: (context, state) {
        return ListView.builder(
          controller: scrollController,
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
  final ScrollController scrollController;
  const _RandomEntriesList({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeViewState>(
      builder: (context, state) {
        return ListView.builder(
          controller: scrollController,
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
  final ScrollController scrollController;

  const ContentWidget({required this.scrollController});

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
          controller: scrollController,
          padding: const EdgeInsets.all(12),
          itemCount: state.contentModel.length,
          itemBuilder: (context, index) {
            final item = state.contentModel[index];
            return ContentCard(
              imageUrl: item.imageURL ?? '',
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
