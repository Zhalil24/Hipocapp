import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/drawer/view/drawer_view.dart';
import 'package:hipocapp/feature/home/view/mixin/home_view_mixin.dart';
import 'package:hipocapp/feature/home/view/widget/auto_sliding_group_container.dart';
import 'package:hipocapp/feature/home/view/widget/bottom_navigation_bar_widget.dart';
import 'package:hipocapp/feature/home/view/widget/content_card_skeleton_widget.dart';
import 'package:hipocapp/feature/home/view/widget/content_card_widget.dart';
import 'package:hipocapp/feature/home/view/widget/entry_bar_widget.dart';
import 'package:hipocapp/feature/home/view/widget/home_background_widget.dart';
import 'package:hipocapp/feature/home/view/widget/home_content_search_card_widget.dart';
import 'package:hipocapp/feature/home/view/widget/search_bar_widget.dart';
import 'package:hipocapp/feature/home/view_model/home_view_model.dart';
import 'package:hipocapp/feature/home/view_model/state/home_view_state.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/utility/enums/content_type.dart';
import 'package:hipocapp/product/widget/appbar/custom_appbar_widget.dart';
import 'package:hipocapp/product/widget/custom_card_widget/custom_card_skeleton_widget.dart';
import 'package:hipocapp/product/widget/custom_card_widget/custom_card_widget.dart';
import 'package:hipocapp/product/widget/login_popup/login_required_popup.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

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
      child: BlocBuilder<HomeViewModel, HomeViewState>(
        builder: (context, state) {
          return Stack(
            children: [
              const Positioned.fill(
                child: HomeBackgroundWidget(),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: CustomAppBar(
                  showLeading:
                      state.contentType == ContentTypeEnum.home.value,
                  title: _resolveAppBarTitle(state.contentType),
                ),
                drawer: const DrawerView(),
                bottomNavigationBar: BottomNavigationBarWidget(
                  onItemSelected: (value) {
                    contentSearchController.clear();
                    homeViewModel.handleNavigation(value);
                  },
                ),
                body: state.contentType != ContentTypeEnum.home.value
                    ? _buildContentListView(context, state)
                    : _buildHomeView(context, state),
              ),
              LoginRequiredPopup(
                onLoginPressed: () async {
                  await context.router.navigate(const LoginRoute());
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContentListView(BuildContext context, HomeViewState state) {
    final visibleItems = state.filteredContentModel;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            context.sized.normalValue * 0.82,
            context.sized.normalValue * 0.7,
            context.sized.normalValue * 0.82,
            context.sized.lowValue * 0.8,
          ),
          child: HomeContentSearchCardWidget(
            controller: contentSearchController,
            hintText: _resolveContentSearchHint(state.contentType),
            onChanged: homeViewModel.filterContentList,
          ),
        ),
        Expanded(
          child: _buildContentListBody(
            context: context,
            state: state,
            visibleItems: visibleItems,
          ),
        ),
      ],
    );
  }

  Widget _buildContentListBody({
    required BuildContext context,
    required HomeViewState state,
    required List<ContentModel> visibleItems,
  }) {
    if (state.isLoading) {
      return ListView.builder(
        itemCount: 3,
        itemBuilder: (_, __) => const ContentCardSkeleton(),
      );
    }

    if (visibleItems.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(context.sized.normalValue * 1.25),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: context.sized.width * 0.78,
            ),
            child: AppEmptyStateCard(
              icon: Icons.inbox_outlined,
              title: LocaleKeys.home_content_empty_title.tr(),
              message: LocaleKeys.home_content_empty_message.tr(),
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.symmetric(
        vertical: context.sized.normalValue * 1.25,
        horizontal: context.sized.lowValue * 0.35,
      ),
      itemCount: visibleItems.length,
      itemBuilder: (ctx, i) {
        final item = visibleItems[i];
        return ContentCard(
          imageUrl: item.imageURL ?? '',
          title: item.title ?? '',
          link: item.link ?? '',
          description: item.description ?? '',
        );
      },
    );
  }

  Widget _buildHomeView(BuildContext context, HomeViewState state) {
    return Stack(
      children: [
        _buildHomeContent(context, state),
        _buildFloatingSearchBar(context, state),
      ],
    );
  }

  Widget _buildHomeContent(BuildContext context, HomeViewState state) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            controller: scrollController,
            children: [
              _buildGroupsSection(context, state),
              SizedBox(height: context.sized.normalValue * 1.2),
              _buildEntryFilterBar(context),
              SizedBox(height: context.sized.normalValue * 0.85),
              _buildEntriesSection(context, state),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGroupsSection(BuildContext context, HomeViewState state) {
    return Padding(
      padding: EdgeInsets.only(top: context.sized.normalValue * 3.5),
      child: AutoSlidingGroupContainer(
        groups: state.groupListModel ?? const [],
      ),
    );
  }

  Widget _buildEntryFilterBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.sized.lowValue * 0.35),
      child: const EntryBarWidget(),
    );
  }

  Widget _buildEntriesSection(BuildContext context, HomeViewState state) {
    if (state.isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: context.sized.lowValue * 0.25),
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
      padding: EdgeInsets.symmetric(horizontal: context.sized.lowValue * 0.25),
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
            date: entry.date ?? '',
            userId: entry.userId,
          );
        }

        final entry = state.randomEntries![i];
        return CustomCardWidget(
          isHomeCard: true,
          title: entry.titleName ?? ' ',
          description: entry.description ?? ' ',
          userId: entry.userId,
          date: entry.createDate ?? '',
        );
      },
    );
  }

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

  String _resolveAppBarTitle(String contentType) {
    if (contentType == ContentTypeEnum.getCampains.value) {
      return LocaleKeys.home_bottom_nav_market.tr();
    }
    if (contentType == ContentTypeEnum.getJobAdvertisements.value) {
      return LocaleKeys.home_bottom_nav_announcements.tr();
    }
    if (contentType == ContentTypeEnum.getThesisConsultation.value) {
      return LocaleKeys.home_bottom_nav_partners.tr();
    }
    if (contentType == ContentTypeEnum.getDraws.value) {
      return LocaleKeys.home_bottom_nav_trainings.tr();
    }
    return LocaleKeys.home_title.tr();
  }

  String _resolveContentSearchHint(String contentType) {
    final isTurkish = context.locale.languageCode == 'tr';

    if (contentType == ContentTypeEnum.getCampains.value) {
      return isTurkish
          ? 'Market i\u00e7i ara'
          : LocaleKeys.home_content_search_market.tr();
    }
    if (contentType == ContentTypeEnum.getJobAdvertisements.value) {
      return isTurkish
          ? '\u0130lan i\u00e7i ara'
          : LocaleKeys.home_content_search_announcements.tr();
    }
    if (contentType == ContentTypeEnum.getThesisConsultation.value) {
      return isTurkish
          ? 'Partnerler i\u00e7i ara'
          : LocaleKeys.home_content_search_partners.tr();
    }
    if (contentType == ContentTypeEnum.getDraws.value) {
      return isTurkish
          ? 'E\u011fitimler i\u00e7i ara'
          : LocaleKeys.home_content_search_trainings.tr();
    }
    return LocaleKeys.home_search_hint.tr();
  }
}
