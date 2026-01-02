import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/utility/extension/form_decoration.dart';
import 'package:hipocapp/product/utility/validator/validator.dart';
import 'package:hipocapp/product/widget/button/custom_action_button/custom_action_button.dart';
import 'package:kartal/kartal.dart';

import '../../../../../product/navigation/app_router.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key, required this.userNameController, required this.passwordController, required this.onLogin});
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final Future<bool> Function() onLogin;
  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.sized.normalValue),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: widget.userNameController,
                decoration: 'Kullanıcı Adı'.formFieldDecoration,
                validator: Validators.notEmpty,
              ),
              SizedBox(height: context.sized.normalValue),
              TextFormField(
                controller: widget.passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Şifre',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    color: Colors.black,
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: Validators.notEmpty,
              ),
              SizedBox(height: context.sized.normalValue),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    context.router.push(const ForgotPasswordRoute());
                  },
                  child: Text(
                    'Şifremi Unuttum',
                    style: TextStyle(
                      fontSize: context.sized.normalValue,
                    ),
                  ),
                ),
              ),
              SizedBox(height: context.sized.normalValue),
              CustomActionButton(
                onTop: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    await widget.onLogin();
                  }
                },
                text: 'Giriş',
              ),
              SizedBox(height: context.sized.normalValue / 2),
              const Divider(thickness: 1),
              SizedBox(height: context.sized.normalValue / 4),
              Center(
                child: GestureDetector(
                  onTap: () {
                    context.router.push(const RegisterRoute());
                  },
                  child: const Text(
                    'Hesabınız yok mu? Kayıt ol',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: context.sized.normalValue / 4),
              const Divider(thickness: 1),
            ],
          )),
    );
  }
}
