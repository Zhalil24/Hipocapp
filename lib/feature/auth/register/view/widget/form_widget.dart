import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/auth/register/view/widget/text_input_widget.dart';
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
  final void Function(DegreeModel) onChangedDegree;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  DegreeModel? _selectedDegree;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.sized.normalValue),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    width: context.sized.highValue * 4,
                    height: context.sized.highValue * 3,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(color: Colors.grey.shade400),
                      image: widget.selectedPhoto != null
                          ? DecorationImage(
                              image: FileImage(widget.selectedPhoto!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: widget.selectedPhoto == null
                        ? Icon(
                            Icons.photo,
                            size: context.sized.highValue,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                  SizedBox(height: context.sized.normalValue),
                  TextButton(
                    onPressed: widget.onPickImage,
                    child: const Text('Kurum Kimliği Seçin'),
                  ),
                ],
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
              Padding(
                padding: EdgeInsets.all(context.sized.normalValue),
                child: DropdownButton<DegreeModel>(
                  hint: const Text('Ünvan Seçiniz'),
                  value: _selectedDegree,
                  isExpanded: true,
                  items: widget.degreeList?.map((degree) {
                    return DropdownMenuItem<DegreeModel>(
                      value: degree,
                      child: Text(degree.degreeName ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDegree = value;
                    });
                    if (value != null) {
                      widget.onChangedDegree(value);
                    }
                  },
                ),
              ),
              SizedBox(height: context.sized.normalValue),
              CustomActionButton(onTop: widget.onRegister, text: 'Kayıt Ol'),
              SizedBox(height: context.sized.normalValue),
            ],
          ),
        ),
      ),
    );
  }
}
