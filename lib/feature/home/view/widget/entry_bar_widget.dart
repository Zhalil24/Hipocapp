import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/home/view_model/home_view_model.dart';
import 'package:hipocapp/feature/home/view_model/state/home_view_state.dart';
import 'package:kartal/kartal.dart';

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
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  context.read<HomeViewModel>().changeEntries(true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: state.isLastEntries ? Color(0xFF7C3AED) : Colors.white,
                  foregroundColor: state.isLastEntries ? colorScheme.onPrimary : colorScheme.onPrimary,
                  shape: const RoundedRectangleBorder(),
                  padding: EdgeInsets.symmetric(vertical: context.sized.normalValue),
                ),
                child: Text(
                  'Daily',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
            SizedBox(width: context.sized.lowValue),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  context.read<HomeViewModel>().changeEntries(false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: state.isRandomEntries ? Color(0xFF7C3AED) : colorScheme.surface,
                  foregroundColor: state.isRandomEntries ? colorScheme.onPrimary : colorScheme.onPrimary,
                  shape: const RoundedRectangleBorder(),
                  padding: EdgeInsets.symmetric(vertical: context.sized.normalValue),
                ),
                child: Text(
                  'Stream',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
