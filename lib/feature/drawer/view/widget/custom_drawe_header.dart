import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/product/widget/terms_popup/terms_popup_widget.dart';
import 'package:hipocapp/product/widget/toggle_buton/toggle_button.dart';
import 'package:kartal/kartal.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DrawerHeader(
      decoration: BoxDecoration(
        color: colorScheme.primary,
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: context.sized.height * 0.04,
                  height: context.sized.height * 0.04,
                  child: Assets.images.logo.image(package: 'gen'),
                ),
                Text(
                  'HipocApp',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: context.sized.mediumValue * 0.9,
                  ),
                )
              ],
            ),
            const ToggleButton(),
            Center(
              child: InkWell(
                onTap: () async {
                  await showDialog<void>(
                    context: context,
                    builder: (_) => const TermsPopup(),
                  );
                },
                borderRadius: BorderRadius.circular(context.sized.normalValue * 0.5),
                child: Container(
                  padding: EdgeInsets.all(context.sized.normalValue * 0.5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.description_outlined, size: context.sized.normalValue, color: Colors.blue),
                      const Text(
                        'KVKK Aydınlatma Metni',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
