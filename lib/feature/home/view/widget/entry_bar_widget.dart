import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/home/view_model/home_view_model.dart';
import 'package:hipocapp/feature/home/view_model/state/home_view_state.dart';

class EntryBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const EntryBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _EntryBar();
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
        return SegmentedButton<bool>(
            segments: const [
              ButtonSegment(
                value: true,
                label: Text('Daily'),
                icon: Icon(Icons.today_outlined),
              ),
              ButtonSegment(
                value: false,
                label: Text('Stream'),
                icon: Icon(Icons.stream),
              ),
            ],
            selected: {
              state.isLastEntries
            },
            onSelectionChanged: (newValue) {
              context.read<HomeViewModel>().changeEntries(newValue.first);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                (states) {
                  if (states.contains(WidgetState.selected)) {
                    return colorScheme.primary;
                  }
                  return colorScheme.onPrimary;
                },
              ),
              foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                (states) {
                  if (states.contains(WidgetState.selected)) {
                    return colorScheme.onPrimary;
                  }
                  return colorScheme.onSurface;
                },
              ),
            ));
      },
    );
  }
}
