import 'package:flutter/material.dart';
import 'package:hipocapp/product/utility/validator/validator.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({
    super.key,
    required this.emailNameController,
    required this.onPressed,
  });

  final TextEditingController emailNameController;
  final VoidCallback onPressed;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final low = context.sized.lowValue;
    final normal = context.sized.normalValue;

    return Padding(
      padding: EdgeInsets.all(normal + (low * 0.5)),
      child: AuthFormCard(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthFormHeader(
                title: 'Sifreni yenile',
                description: 'Kayitli e-posta adresini gir, sifre yenileme yonlendirmesini gonderelim.',
              ),
              SizedBox(height: normal * 1.5),
              AuthTextField(
                controller: widget.emailNameController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                label: 'Email',
                icon: Icons.alternate_email_rounded,
                validator: Validators.email,
              ),
              SizedBox(height: normal + (low * 0.5)),
              AuthPrimaryButton(
                label: 'Gonder',
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    widget.onPressed();
                  }
                },
                icon: Icons.send_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
