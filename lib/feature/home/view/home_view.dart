import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_architecture_template/feature/home/view/mixin/home_view_mixin.dart';
import 'package:my_architecture_template/feature/home/view_model/home_view_model.dart';
import 'package:my_architecture_template/feature/home/view_model/state/home_view_state.dart';
import 'package:my_architecture_template/product/state/base/base_state.dart';

/// My Home Page
@RoutePage()
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
            productViewModel.changeThemeMode(ThemeMode.dark);
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
      listener: (context, state) {
        if (state.lastEntries == null) {
          context.read<HomeViewModel>().getLastEntries();
        }
      },
      child: BlocBuilder<HomeViewModel, HomeViewState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.lastEntries?.length ?? 0,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6), // Kenarlardan boşluk bırak
                elevation: 4, // Hafif bir gölgelendirme ekle
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Köşeleri yuvarla
                ),
                child: Padding(
                  padding: EdgeInsets.all(12), // İçeriği daha rahat okutmak için padding ekle
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.lastEntries![index].titleName.toString(),
                      ),
                      SizedBox(height: 6), // Boşluk ekle
                      Text(
                        state.lastEntries![index].entryDescription.toString(),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Kullanıcı: ${state.lastEntries![index].userName}',
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Tarih: ${state.lastEntries![index].date}',
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
