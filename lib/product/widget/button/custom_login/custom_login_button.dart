import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/widget/button/normal_button.dart';
import 'package:widgets/widgets.dart';

part 'custom_login_button_mixin.dart';

final class CustomLoginButton extends StatefulWidget {
  const CustomLoginButton({super.key, required this.onOperation});
  final AsyncValueGetter<bool> onOperation;
  @override
  State<CustomLoginButton> createState() => _CustomLoginButtonState();
}

class _CustomLoginButtonState extends State<CustomLoginButton>
    with MountedMixin, _CustomLoginButtonMixin {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isLoadingNotifer,
      builder: (context, value, child) {
        if (value) return const SizedBox();
        return NormalButton(
          title: LocaleKeys.general_button_login.tr(),
          OnPressed: () async {
            await _onPressed(context);
          },
        );
      },
    );
  }
}
