import 'package:flutter/material.dart';
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
            const AuthFormHeader(
              title: 'Parolani yenile',
              description: 'Hesabinin guvenligini korumak icin mevcut parolani dogrula ve yeni parolani belirle.',
            ),
            SizedBox(height: normal * 1.2),
            const AuthInfoBanner(
              title: 'Guvenlik ipucu',
              message: 'Yeni sifreni daha once kullanmadigin, tahmin edilmesi zor ve sana ozel bir kombinasyonla belirle.',
            ),
            SizedBox(height: normal * 1.2),
            AuthTextField(
              controller: widget.passwordChangeController,
              label: 'Mevcut sifre',
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
              label: 'Yeni sifre',
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
                'Parolan en az 8 karakter, buyuk-kucuk harf ve sayi kombinasyonu icermelidir.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      height: 1.4,
                    ),
              ),
            ),
            SizedBox(height: normal),
            AuthTextField(
              controller: widget.newPasswordReChangeController,
              label: 'Yeni sifre tekrar',
              icon: Icons.verified_user_outlined,
              obscureText: _obscureRepeatPassword,
              validator: (value) {
                final emptyError = Validators.notEmpty(value);
                if (emptyError != null) return emptyError;
                return Validators.match(
                  value,
                  widget.newPasswordChangeController.text,
                  'Yeni sifre',
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
              label: 'Parolayi guncelle',
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
