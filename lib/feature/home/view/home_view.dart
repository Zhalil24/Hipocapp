import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:my_architecture_template/feature/home/view/mixin/home_view_mixin.dart';
import 'package:my_architecture_template/feature/home/view_model/home_view_model.dart';
import 'package:my_architecture_template/feature/home/view_model/state/home_view_state.dart';
import 'package:my_architecture_template/product/state/base/base_state.dart';

/// My Home Page

final class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeViewModel,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            productViewModel.changeThemeMode(ThemeMode.light);
            homeViewModel.fetchUsers();
          },
        ),
        appBar: AppBar(),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Expanded(child: _UserList())],
        ),
      ),
    );
  }
}

class _UserList extends StatelessWidget {
  const _UserList();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeViewModel, HomeViewState>(
      listener: (context, state) {},
      child: BlocSelector<HomeViewModel, HomeViewState, List<User>>(
        selector: (state) {
          return state.users ?? [];
        },
        builder: (context, state) {
          if (state.isEmpty) return const SizedBox();
          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              return ListTile(
                  // title: Text(state[index].userId.toString()),
                  // subtitle: Text(state[index].body.toString()),
                  );
            },
          );
        },
      ),
    );
  }
}
