import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/drawer/view/drawer_view.dart';
import 'package:hipocapp/feature/home/view/mixin/home_view_mixin.dart';
import 'package:hipocapp/feature/home/view/widget/auto_sliding_group_container.dart';
import 'package:hipocapp/feature/home/view/widget/bottom_navigation_bar_widget.dart';
import 'package:hipocapp/feature/home/view/widget/content_card_skeleton_widget.dart';
import 'package:hipocapp/feature/home/view/widget/content_card_widget.dart';
import 'package:hipocapp/feature/home/view/widget/entry_bar_widget.dart';
import 'package:hipocapp/feature/home/view/widget/home_background_widget.dart';
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
import 'package:widgets/widgets.dart';

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
      child: Stack(
        children: [
          const Positioned.fill(
            child: HomeBackgroundWidget(),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: const CustomAppBar(title: 'Anasayfa'),
            drawer: const DrawerView(),
            bottomNavigationBar: BottomNavigationBarWidget(
              onItemSelected: (value) =>
                  homeViewModel.handleNavigation(context, value),
            ),
            body: BlocBuilder<HomeViewModel, HomeViewState>(
              builder: (context, state) {
                if (state.contentType != ContentTypeEnum.home.value) {
                  return _buildContentListView(context, state);
                }
                return _buildHomeView(context, state);
              },
            ),
          ),
          LoginRequiredPopup(
            onLoginPressed: () async {
              await context.router.navigate(const LoginRoute());
            },
          ),
        ],
      ),
    );
  }

  /// Builds the content list view for non-home content types
  Widget _buildContentListView(BuildContext context, HomeViewState state) {
    if (state.isLoading) {
      return ListView.builder(
        itemCount: 3,
        itemBuilder: (_, __) => const ContentCardSkeleton(),
      );
    }

    if (state.contentModel.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(context.sized.normalValue * 1.5),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: context.sized.width * 0.78,
            ),
            child: const AppEmptyStateCard(
              icon: Icons.inbox_outlined,
              title: 'Icerik bulunamadi',
              message: 'Bu bolum icin gosterilecek icerik su anda hazir degil. '
                  'Daha sonra yeniden kontrol edebilirsin.',
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.symmetric(
        vertical: context.sized.normalValue * 2,
        horizontal: context.sized.lowValue,
      ),
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

  /// Builds the main home view
  Widget _buildHomeView(BuildContext context, HomeViewState state) {
    return Stack(
      children: [
        _buildHomeContent(context, state),
        _buildFloatingSearchBar(context, state),
      ],
    );
  }

  /// Builds the main content of home view
  Widget _buildHomeContent(BuildContext context, HomeViewState state) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            controller: scrollController,
            children: [
              _buildGroupsSection(context, state),
              SizedBox(height: context.sized.normalValue * 1.5),
              _buildEntryFilterBar(context),
              SizedBox(height: context.sized.normalValue),
              _buildEntriesSection(context, state),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the groups carousel section
  Widget _buildGroupsSection(BuildContext context, HomeViewState state) {
    return Padding(
      padding: EdgeInsets.only(top: context.sized.normalValue * 3.5),
      child: AutoSlidingGroupContainer(
        groups: state.groupListModel ?? const [],
      ),
    );
  }

  /// Builds the entry filter bar
  Widget _buildEntryFilterBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.sized.lowValue),
      child: const EntryBarWidget(),
    );
  }

  /// Builds the entries list section
  Widget _buildEntriesSection(BuildContext context, HomeViewState state) {
    if (state.isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: context.sized.lowValue),
        child: Column(
          children: List.generate(
            5,
            (_) => const CustomCardWidgetSkeleton(),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: context.sized.lowValue),
      itemCount: state.isLastEntries
          ? (state.lastEntries?.length ?? 0)
          : (state.randomEntries?.length ?? 0),
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
    );
  }

  /// Builds the floating search bar
  Widget _buildFloatingSearchBar(BuildContext context, HomeViewState state) {
    return SearchBarWidget(
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
    );
  }
}
