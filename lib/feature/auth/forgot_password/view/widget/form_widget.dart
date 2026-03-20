import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
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
              AuthFormHeader(
                title: LocaleKeys.auth_forgot_password_header_title.tr(),
                description:
                    LocaleKeys.auth_forgot_password_header_description.tr(),
              ),
              SizedBox(height: normal * 1.5),
              AuthTextField(
                controller: widget.emailNameController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                label: LocaleKeys.general_form_email.tr(),
                icon: Icons.alternate_email_rounded,
                validator: Validators.email,
              ),
              SizedBox(height: normal + (low * 0.5)),
              AuthPrimaryButton(
                label: LocaleKeys.general_button_send.tr(),
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
