import 'package:flutter/material.dart';
import 'package:hipocapp/product/utility/extension/form_decoration.dart';
import 'package:hipocapp/product/utility/validator/validator.dart';
import 'package:hipocapp/product/widget/button/custom_action_button/custom_action_button.dart';
import 'package:kartal/kartal.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key, required this.emailNameController, required this.onPressed});
  final TextEditingController emailNameController;
  final VoidCallback onPressed;
  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
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
                controller: widget.emailNameController,
                style: const TextStyle(color: Colors.black),
                decoration: 'Email'.formFieldDecoration,
                validator: Validators.notEmpty,
              ),
              SizedBox(height: context.sized.normalValue),
              CustomActionButton(
                onTop: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    widget.onPressed();
                  }
                },
                text: 'Gönder',
              ),
            ],
          )),
    );
  }
}
