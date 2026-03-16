import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
              const AuthFormHeader(
                title: 'Tekrar hos geldin',
                description: 'Kullanici adi ve sifrenle hesabina giris yap. Akisin seni bekliyor.',
              ),
              SizedBox(height: normal * 1.5),
              const AuthInfoBanner(
                message: 'Basliklar, gruplar ve sohbetler icin tek oturumla devam et.',
              ),
              SizedBox(height: normal * 1.5),
              AuthTextField(
                controller: widget.userNameController,
                autofillHints: const [AutofillHints.username],
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                label: 'Kullanici Adi',
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
                label: 'Sifre',
                icon: Icons.lock_outline_rounded,
                suffixIcon: IconButton(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
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
                      : () {
                          context.router.push(const ForgotPasswordRoute());
                        },
                  child: const Text('Sifremi Unuttum'),
                ),
              ),
              SizedBox(height: normal),
              AuthPrimaryButton(
                label: widget.isLoading ? 'Giris Yapiliyor...' : 'Giris Yap',
                isLoading: widget.isLoading,
                onPressed: _submit,
              ),
              SizedBox(height: normal),
              const AuthDividerLabel(label: 'Yeni misin?'),
              SizedBox(height: normal),
              AuthSecondaryButton(
                label: 'Hesabin yoksa kayit ol',
                onPressed: widget.isLoading
                    ? null
                    : () {
                        context.router.push(const RegisterRoute());
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
