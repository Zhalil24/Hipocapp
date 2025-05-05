import 'package:flutter/material.dart';
import 'package:hipocapp/product/widget/button/custom_action_button/custom_action_button.dart';
import 'package:kartal/kartal.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({
    super.key,
    required this.passwordChangeController,
    required this.newPasswordChangeController,
    required this.newPasswordReChangeController,
    required this.onChangePressed,
    required this.message,
  });

  final TextEditingController passwordChangeController;
  final TextEditingController newPasswordChangeController;
  final TextEditingController newPasswordReChangeController;
  final VoidCallback onChangePressed;
  final String message;

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.sized.normalValue),
      child: Column(
        children: [
          _buildPasswordField('Mevcut Şifre', widget.passwordChangeController),
          SizedBox(height: context.sized.normalValue),
          _buildPasswordField('Yeni Şifre', widget.newPasswordChangeController),
          SizedBox(height: context.sized.normalValue),
          _buildPasswordField('Yeni Şifre (Tekrar)', widget.newPasswordReChangeController),
          SizedBox(height: context.sized.normalValue),
          CustomActionButton(
            onTop: widget.onChangePressed,
            text: 'Şifreyi Değiştir',
            message: widget.message,
            controllers: [
              widget.passwordChangeController,
              widget.newPasswordChangeController,
              widget.newPasswordReChangeController,
            ],
            passwordMatchControllers: [
              widget.newPasswordChangeController,
              widget.newPasswordReChangeController,
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
