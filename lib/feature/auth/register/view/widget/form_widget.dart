import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/auth/register/view/widget/custom_checkbox_widget.dart';
import 'package:hipocapp/feature/auth/register/view/widget/photo_picker_filed_widget.dart';
import 'package:hipocapp/feature/auth/register/view/widget/text_input_widget.dart';
import 'package:hipocapp/product/utility/constans/term/terms_constants.dart';
import 'package:hipocapp/product/utility/validator/validator.dart';
import 'package:hipocapp/product/widget/button/custom_action_button/custom_action_button.dart';
import 'package:kartal/kartal.dart';

class FormWidget extends StatefulWidget {
  const FormWidget(
      {required this.nameController,
      required this.surnameController,
      required this.usernameController,
      required this.phoneController,
      required this.passwordController,
      required this.onPickImage,
      required this.rePasswordController,
      required this.onRegister,
      required this.selectedPhoto,
      required this.emailController,
      required this.degreeList,
      required this.onToggle,
      required this.isChecked,
      required this.onChangedDegree});

  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController rePasswordController;
  final Future<void> Function() onRegister;
  final Future<File?> Function() onPickImage;
  final File? selectedPhoto;
  final List<DegreeModel>? degreeList;
  final bool isChecked;
  final void Function(DegreeModel) onChangedDegree;
  final void Function(bool) onToggle;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.sized.lowValue),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              PhotoPickerField(
                selectedPhoto: widget.selectedPhoto,
                onPickImage: widget.onPickImage,
              ),
              const Text(
                'Kurum kimliği yüklemeniz gerekmektedir!',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: context.sized.normalValue),
              TextInputWidget(
                title: 'Ad',
                controller: widget.nameController,
                validator: Validators.notEmpty,
              ),
              SizedBox(height: context.sized.normalValue),
              TextInputWidget(
                title: 'Soyad',
                controller: widget.surnameController,
                validator: Validators.notEmpty,
              ),
              SizedBox(height: context.sized.normalValue),
              TextInputWidget(
                title: 'Kullanıcı Adı',
                controller: widget.usernameController,
                validator: Validators.notEmpty,
              ),
              SizedBox(height: context.sized.normalValue),
              TextInputWidget(
                title: 'Mail Adresi',
                controller: widget.emailController,
                validator: Validators.email,
              ),
              SizedBox(height: context.sized.normalValue),
              TextInputWidget(
                title: 'Telefon Numarası',
                controller: widget.phoneController,
                validator: Validators.notEmpty,
              ),
              SizedBox(height: context.sized.normalValue),
              TextInputWidget(
                title: 'Şifre',
                controller: widget.passwordController,
                validator: Validators.notEmpty,
              ),
              const Text(
                'Parolanız en az 1 büyük harf, 1 küçük harf, en az 1 sayı ve minimum 8 karakterden oluşmalıdır.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: context.sized.normalValue),
              TextInputWidget(
                title: 'Şifre Tekrarı',
                controller: widget.rePasswordController,
                validator: (val) => Validators.match(
                  val,
                  widget.passwordController.text,
                  'Şifre',
                ),
              ),
              SizedBox(height: context.sized.normalValue),
              SizedBox(height: context.sized.normalValue),
              Row(
                children: [
                  Expanded(
                    child: CheckboxFormField(
                      title: Row(
                        children: [
                          const Text('Şartları kabul ediyorum'),
                          GestureDetector(
                            onTap: () {
                              showDialog<void>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Şartlar ve Koşullar'),
                                  content: const SingleChildScrollView(
                                    child: Text(TermsConstants.termsAndConditions),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text('Kapat'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Text(
                              '(Detayları Gör)',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      initialValue: widget.isChecked,
                      validator: (value) {
                        if (value != true) {
                          return 'Devam etmek için şartları kabul etmelisiniz.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        widget.onToggle(value ?? false);
                      },
                    ),
                  ),
                ],
              ),
              CustomActionButton(
                onTop: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onRegister();
                  }
                },
                text: 'Kayıt Ol',
              ),
              SizedBox(height: context.sized.normalValue),
            ],
          ),
        ),
      ),
    );
  }
}
