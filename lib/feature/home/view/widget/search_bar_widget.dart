import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hipocapp/product/utility/constans/search_bar/serarch_bar_constants.dart';
import 'package:hipocapp/product/widget/custom_loader/custom_loader_widget.dart';
import 'package:kartal/kartal.dart';
import 'package:auto_route/auto_route.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:material_floating_search_bar_plus/material_floating_search_bar_plus.dart';

class SearchBarWidget extends HookWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final List<TitleModel> titles;
  final bool isLoading;

  const SearchBarWidget(
    this.onChanged,
    this.controller,
    this.titles,
    this.isLoading,
  );

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final colorScheme = Theme.of(context).colorScheme;

    return FloatingSearchBar(
      hint: 'Başlık veya içerik ara...',
      backgroundColor: colorScheme.surface,
      hintStyle: TextStyle(
        color: colorScheme.onSurfaceVariant,
        fontSize: context.sized.normalValue * 0.9,
      ),
      queryStyle: TextStyle(
        color: colorScheme.onSurface,
        fontSize: context.sized.normalValue * 0.9,
      ),
      iconColor: colorScheme.primary,
      scrollPadding: const EdgeInsets.only(
        top: SearchBarConstants.searchBarScrollPaddingTop,
        bottom: SearchBarConstants.searchBarScrollPaddingBottom,
      ),
      transitionDuration: SearchBarConstants.searchBarTransitionDuration,
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? SearchBarConstants.searchBarAxisAlignmentPortrait : SearchBarConstants.searchBarAxisAlignmentLandscape,
      openAxisAlignment: SearchBarConstants.searchBarOpenAxisAlignment,
      width: isPortrait ? SearchBarConstants.searchBarWidthPortrait : SearchBarConstants.searchBarWidthLandscape,
      debounceDelay: SearchBarConstants.searchBarDebounceDelay,
      onQueryChanged: onChanged,
      transition: CircularFloatingSearchBarTransition(),
      builder: (context, transition) {
        return _buildSearchContent(context, colorScheme);
      },
    );
  }

  Widget _buildSearchContent(BuildContext context, ColorScheme colorScheme) {
    if (isLoading) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(context.sized.normalValue * 2),
          child: const CustomLoader(),
        ),
      );
    }

    if (titles.isEmpty) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(context.sized.normalValue),
      child: Material(
        color: Colors.transparent,
        elevation: SearchBarConstants.searchBarElevation,
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(context.sized.normalValue),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * SearchBarConstants.searchBarListHeightFactor,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: titles.length,
              separatorBuilder: (context, index) => Divider(
                height: SearchBarConstants.dividerHeight,
                thickness: SearchBarConstants.dividerThickness,
                color: colorScheme.surfaceContainerHighest,
                //margin: EdgeInsets.zero,
              ),
              itemBuilder: (context, index) {
                final title = titles[index];
                return _buildSearchResultTile(context, title, colorScheme);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResultTile(
    BuildContext context,
    TitleModel title,
    ColorScheme colorScheme,
  ) {
    return Material(
      color: colorScheme.surface,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.sized.normalValue,
          vertical: context.sized.lowValue * 0.3,
        ),
        leading: Container(
          padding: EdgeInsets.all(context.sized.lowValue * 0.6),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.article_outlined,
            size: context.sized.normalValue,
            color: colorScheme.primary,
          ),
        ),
        title: Text(
          title.name ?? 'İçerik Bulunamadı',
          style: TextStyle(
            fontSize: context.sized.normalValue * 0.95,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: context.sized.normalValue * 0.8,
          color: colorScheme.primary.withValues(alpha: 0.6),
        ),
        onTap: () {
          context.router.push(
            EntryListRoute(
              titleName: title.name ?? '',
              headerId: title.headerId ?? 0,
              userId: title.userId ?? 0,
            ),
          );
        },
        hoverColor: colorScheme.primary.withValues(alpha: 0.05),
      ),
    );
  }
}
