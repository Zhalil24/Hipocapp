import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/utility/validator/validator.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

import '../../../../../product/navigation/app_router.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({
    super.key,
    required this.userNameController,
    required this.passwordController,
    required this.onLogin,
    required this.isLoading,
  });

  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final Future<bool> Function() onLogin;
  final bool isLoading;

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  Future<void> _submit() async {
    if (widget.isLoading) return;
    if (_formKey.currentState?.validate() ?? false) {
      await widget.onLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    final low = context.sized.lowValue;
    final normal = context.sized.normalValue;

    return AuthFormCard(
      child: Form(
        key: _formKey,
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthFormHeader(
                title: LocaleKeys.auth_login_header_title.tr(),
                description: LocaleKeys.auth_login_header_description.tr(),
              ),
              SizedBox(height: normal * 1.5),
              AuthInfoBanner(
                message: LocaleKeys.auth_login_banner_message.tr(),
              ),
              SizedBox(height: normal * 1.5),
              AuthTextField(
                controller: widget.userNameController,
                autofillHints: const [AutofillHints.username],
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                label: LocaleKeys.general_form_username.tr(),
                icon: Icons.person_outline_rounded,
                validator: Validators.notEmpty,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
              ),
              SizedBox(height: normal),
              AuthTextField(
                controller: widget.passwordController,
                autofillHints: const [AutofillHints.password],
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.done,
                label: LocaleKeys.general_form_password.tr(),
                icon: Icons.lock_outline_rounded,
                suffixIcon: IconButton(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                validator: Validators.notEmpty,
                onFieldSubmitted: (_) async => _submit(),
              ),
              SizedBox(height: low * 0.5),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: widget.isLoading
                      ? null
                      : () async {
                          await context.router.push(
                            const ForgotPasswordRoute(),
                          );
                        },
                  child: Text(LocaleKeys.general_button_forgot_password.tr()),
                ),
              ),
              SizedBox(height: normal),
              AuthPrimaryButton(
                label: widget.isLoading
                    ? LocaleKeys.auth_login_button_loading.tr()
                    : LocaleKeys.general_button_login.tr(),
                isLoading: widget.isLoading,
                onPressed: _submit,
              ),
              SizedBox(height: normal),
              AuthDividerLabel(label: LocaleKeys.auth_login_divider.tr()),
              SizedBox(height: normal),
              AuthSecondaryButton(
                label: LocaleKeys.auth_login_secondary_cta.tr(),
                onPressed: widget.isLoading
                    ? null
                    : () async {
                        await context.router.replace(const RegisterRoute());
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
