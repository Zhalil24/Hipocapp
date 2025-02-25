import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_architecture_template/feature/home/view_model/home_view_model.dart';
import 'package:my_architecture_template/feature/home/view_model/state/home_view_state.dart';

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
    return BlocBuilder<HomeViewModel, HomeViewState>(
      builder: (context, state) {
        return BlocBuilder<HomeViewModel, HomeViewState>(
          builder: (context, state) {
            bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<HomeViewModel>().changeEntries(true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: state.isLastEntries
                        ? (isDarkMode ? Colors.grey[800] : Colors.grey[300]) // Seçiliyse gri tonu
                        : (isDarkMode ? Colors.black : Colors.white), // Seçili değilse normal renk
                    foregroundColor: state.isLastEntries
                        ? Colors.white // Seçiliyse yazı beyaz
                        : (isDarkMode ? Colors.white : Colors.black), // Seçili değilse uygun renk
                  ),
                  child: const Text("Daily"),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<HomeViewModel>().changeEntries(false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: state.isRandomEntries
                        ? (isDarkMode ? Colors.grey[800] : Colors.grey[300]) // Seçiliyse gri tonu
                        : (isDarkMode ? Colors.black : Colors.white), // Seçili değilse normal renk
                    foregroundColor: state.isRandomEntries
                        ? Colors.white // Seçiliyse yazı beyaz
                        : (isDarkMode ? Colors.white : Colors.black), // Seçili değilse uygun renk
                  ),
                  child: const Text("Stream"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
