import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/widget/button/normal_button.dart';
import 'package:widgets/widgets.dart';

final class DialogNormalButton extends StatelessWidget {
  const DialogNormalButton({super.key, required this.onComplete});
  final ValueChanged<bool> onComplete;
  @override
  Widget build(BuildContext context) {
    return NormalButton(
      title: LocaleKeys.general_form_title.tr(),
      OnPressed: () async {
        final resp = await SuccessDialog.show(
          title: LocaleKeys.general_dialog_success.tr(),
          context: context,
        );
        onComplete.call(resp);
      },
    );
  }
}
