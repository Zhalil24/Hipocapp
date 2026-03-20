import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/home/view_model/home_view_model.dart';
import 'package:hipocapp/feature/home/view_model/state/home_view_state.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:kartal/kartal.dart';

class EntryBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const EntryBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const _EntryBar();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

@immutable
class _EntryBar extends StatelessWidget {
  const _EntryBar();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<HomeViewModel, HomeViewState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.sized.lowValue * 0.5,
            vertical: context.sized.lowValue * 0.5,
          ),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(context.sized.normalValue),
          ),
          child: SegmentedButton<bool>(
            segments: [
              ButtonSegment(
                value: true,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.today_outlined,
                      size: context.sized.normalValue,
                    ),
                    SizedBox(width: context.sized.lowValue * 0.5),
                    Text(
                      LocaleKeys.home_entry_filter_latest.tr(),
                      style: TextStyle(
                        fontSize: context.sized.normalValue * 0.9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              ButtonSegment(
                value: false,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.shuffle_rounded,
                      size: context.sized.normalValue,
                    ),
                    SizedBox(width: context.sized.lowValue * 0.5),
                    Text(
                      LocaleKeys.home_entry_filter_random.tr(),
                      style: TextStyle(
                        fontSize: context.sized.normalValue * 0.9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            selected: {state.isLastEntries},
            onSelectionChanged: (newValue) {
              context.read<HomeViewModel>().changeEntries(newValue.first);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                (states) {
                  if (states.contains(WidgetState.selected)) {
                    return colorScheme.primary;
                  }
                  return Colors.transparent;
                },
              ),
              foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                (states) {
                  if (states.contains(WidgetState.selected)) {
                    return colorScheme.onPrimary;
                  }
                  return colorScheme.onSurface.withValues(alpha: 0.7);
                },
              ),
              side: WidgetStateProperty.resolveWith<BorderSide?>(
                (states) {
                  if (states.contains(WidgetState.selected)) {
                    return BorderSide.none;
                  }
                  return BorderSide.none;
                },
              ),
              elevation: WidgetStateProperty.all<double>(0),
            ),
          ),
        );
      },
    );
  }
}
