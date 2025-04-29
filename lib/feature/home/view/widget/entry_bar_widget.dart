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
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<HomeViewModel>().changeEntries(true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: state.isLastEntries ? colorScheme.primary : colorScheme.surface,
                foregroundColor: state.isLastEntries ? colorScheme.onPrimary : colorScheme.primary,
              ),
              child: const Text(
                "Daily",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                context.read<HomeViewModel>().changeEntries(false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: state.isRandomEntries ? colorScheme.primary : colorScheme.surface,
                foregroundColor: state.isRandomEntries ? colorScheme.onPrimary : colorScheme.primary,
              ),
              child: const Text(
                "Stream",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ],
        );
      },
    );
  }
}
