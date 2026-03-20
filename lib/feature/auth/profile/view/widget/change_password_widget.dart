import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/utility/validator/validator.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({
    super.key,
    required this.passwordChangeController,
    required this.newPasswordChangeController,
    required this.newPasswordReChangeController,
    required this.onChangePressed,
  });

  final TextEditingController passwordChangeController;
  final TextEditingController newPasswordChangeController;
  final TextEditingController newPasswordReChangeController;
  final VoidCallback onChangePressed;

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureRepeatPassword = true;

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onChangePressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return AppSurfaceCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthFormHeader(
              title: LocaleKeys.auth_profile_change_password_title.tr(),
              description:
                  LocaleKeys.auth_profile_change_password_description.tr(),
            ),
            SizedBox(height: normal * 1.2),
            AuthInfoBanner(
              title: LocaleKeys.auth_profile_security_tip_title.tr(),
              message: LocaleKeys.auth_profile_security_tip_message.tr(),
            ),
            SizedBox(height: normal * 1.2),
            AuthTextField(
              controller: widget.passwordChangeController,
              label: LocaleKeys.general_form_current_password.tr(),
              icon: Icons.lock_clock_rounded,
              obscureText: _obscureCurrentPassword,
              validator: Validators.notEmpty,
              textInputAction: TextInputAction.next,
              suffixIcon: _buildVisibilityButton(
                value: _obscureCurrentPassword,
                onPressed: () {
                  setState(() {
                    _obscureCurrentPassword = !_obscureCurrentPassword;
                  });
                },
              ),
            ),
            SizedBox(height: normal),
            AuthTextField(
              controller: widget.newPasswordChangeController,
              label: LocaleKeys.general_form_new_password.tr(),
              icon: Icons.lock_outline_rounded,
              obscureText: _obscureNewPassword,
              validator: Validators.notEmpty,
              textInputAction: TextInputAction.next,
              suffixIcon: _buildVisibilityButton(
                value: _obscureNewPassword,
                onPressed: () {
                  setState(() {
                    _obscureNewPassword = !_obscureNewPassword;
                  });
                },
              ),
            ),
            SizedBox(height: low * 0.7),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: low * 0.25),
              child: Text(
                LocaleKeys.general_info_password_requirements_short.tr(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      height: 1.4,
                    ),
              ),
            ),
            SizedBox(height: normal),
            AuthTextField(
              controller: widget.newPasswordReChangeController,
              label: LocaleKeys.general_form_new_password_repeat.tr(),
              icon: Icons.verified_user_outlined,
              obscureText: _obscureRepeatPassword,
              validator: (value) {
                final emptyError = Validators.notEmpty(value);
                if (emptyError != null) return emptyError;
                return Validators.match(
                  value,
                  widget.newPasswordChangeController.text,
                  LocaleKeys.general_form_new_password.tr(),
                );
              },
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
              suffixIcon: _buildVisibilityButton(
                value: _obscureRepeatPassword,
                onPressed: () {
                  setState(() {
                    _obscureRepeatPassword = !_obscureRepeatPassword;
                  });
                },
              ),
            ),
            SizedBox(height: normal * 1.25),
            AuthPrimaryButton(
              label: LocaleKeys.general_button_update_password.tr(),
              icon: Icons.shield_rounded,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisibilityButton({
    required bool value,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        value ? Icons.visibility_off_rounded : Icons.visibility_rounded,
      ),
    );
  }
}
