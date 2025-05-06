import 'package:flutter/material.dart';
import 'package:hipocapp/product/utility/extension/form_decoration.dart';
import 'package:hipocapp/product/utility/validator/validator.dart';
import 'package:hipocapp/product/widget/button/custom_action_button/custom_action_button.dart';
import 'package:kartal/kartal.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.sized.normalValue),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: widget.passwordChangeController,
              obscureText: true,
              decoration: 'Mevcut Şifre'.formFieldDecoration,
              validator: Validators.notEmpty,
            ),
            SizedBox(height: context.sized.normalValue),
            TextFormField(
              controller: widget.newPasswordChangeController,
              obscureText: true,
              decoration: 'Yeni Şifre'.formFieldDecoration,
              validator: Validators.notEmpty,
            ),
            SizedBox(height: context.sized.normalValue),
            TextFormField(
              controller: widget.newPasswordReChangeController,
              obscureText: true,
              decoration: 'Yeni Şifre (Tekrar)'.formFieldDecoration,
              validator: (v) {
                // önce boş mu?
                final emptyError = Validators.notEmpty(v);
                if (emptyError != null) return emptyError;
                // sonra eşleşiyor mu?
                return Validators.match(
                  v,
                  widget.newPasswordChangeController.text,
                  'Yeni şifre',
                );
              },
            ),
            SizedBox(height: context.sized.normalValue),
            CustomActionButton(
              text: 'Şifreyi Değiştir',
              onTop: () {
                if (_formKey.currentState?.validate() ?? false) {
                  widget.onChangePressed();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
