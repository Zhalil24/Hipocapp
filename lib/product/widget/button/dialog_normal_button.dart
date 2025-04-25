import 'package:flutter/material.dart';
import 'package:hipocapp/product/widget/button/normal_button.dart';
import 'package:widgets/widgets.dart';

final class DialogNormalButton extends StatelessWidget {
  const DialogNormalButton({super.key, required this.onComplete});
  final ValueChanged<bool> onComplete;
  @override
  Widget build(BuildContext context) {
    return NormalButton(
      title: 'Ttile',
      OnPressed: () async {
        final resp = await SuccessDialog.show(title: 'Success!', context: context);
        onComplete.call(resp);
      },
    );
  }
}
