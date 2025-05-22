import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hipocapp/product/utility/constans/search_bar/serarch_bar_constants.dart';
import 'package:hipocapp/product/widget/custom_loader/custom_loader_widget.dart';
import 'package:kartal/kartal.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:auto_route/auto_route.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/product/navigation/app_router.dart';

class SearchBarWidget extends HookWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final List<TitleModel> titles;
  final bool isLoading;
  const SearchBarWidget(this.onChanged, this.controller, this.titles, this.isLoading);

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final colorScheme = Theme.of(context).colorScheme;
    return FloatingSearchBar(
        hint: 'Başlık ara...',
        backgroundColor: colorScheme.surface,
        hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
        queryStyle: TextStyle(color: colorScheme.onSurface),
        iconColor: colorScheme.onSurface,
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
          if (isLoading) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(context.sized.normalValue),
                child: const CustomLoader(),
              ),
            );
          }

          if (titles.isEmpty) {
            return const SizedBox.shrink();
          }

          return ClipRRect(
            borderRadius: BorderRadius.circular(context.sized.lowValue),
            child: Material(
              color: Colors.transparent,
              elevation: SearchBarConstants.searchBarElevation,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * SearchBarConstants.searchBarListHeightFactor,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: titles.length,
                  itemBuilder: (context, index) {
                    final title = titles[index];
                    return Column(
                      children: [
                        Container(
                          color: colorScheme.surface,
                          child: ListTile(
                            title: Text(title.name ?? 'Başlık Bulunmamaktadır'),
                            onTap: () {
                              context.router.push(
                                EntryListRoute(
                                  titleName: title.name ?? '',
                                  headerId: title.headerId ?? 0,
                                  userId: title.userId ?? 0,
                                ),
                              );
                            },
                          ),
                        ),
                        const Divider(
                          height: SearchBarConstants.dividerHeight,
                          thickness: SearchBarConstants.dividerThickness,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}
