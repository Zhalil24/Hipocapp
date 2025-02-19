import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_architecture_template/feature/home/view_model/home_view_model.dart';
import 'package:my_architecture_template/feature/home/view_model/state/home_view_state.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [const _Loading()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

@immutable
class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeViewState>(
      builder: (context, state) {
        if (!state.isLoading) return const SizedBox.shrink();
        return const CircularProgressIndicator.adaptive();
      },
    );
  }
}
