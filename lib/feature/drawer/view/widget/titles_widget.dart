import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/drawer/view/widget/menu_button_text_widget.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:hipocapp/product/widget/custom_loader/custom_loader_widget.dart';
import 'package:kartal/kartal.dart';

class DrawerTitlesWidget extends StatelessWidget {
  final List<TitleModel> titles;
  final bool isLoading;

  const DrawerTitlesWidget({
    Key? key,
    required this.titles,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CustomLoader());
    }
    if (titles.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(context.sized.lowValue),
        child: Text('Başlık Bulunmamaktadır'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const MenuButtonTextWidget(
          text: 'Başlıklar:',
        ),
        ...titles.map((title) => TextButton(
              onPressed: () {
                context.router.push(EntryListRoute(
                  titleName: title.name ?? '',
                  headerId: title.headerId ?? 0,
                  userId: title.userId ?? 0,
                ));
              },
              child: MenuButtonTextWidget(
                text: '• ${title.name} >',
              ),
            )),
      ],
    );
  }
}
