import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:kartal/kartal.dart';

class EditProfileWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordReController;
  final String message;
  final void Function(String name, String surname, String username, String email, String password, String passwordRe) onUpdate;
  final Future<File?> Function() onPickImage;
  final File? selectedPhoto;

  const EditProfileWidget(
      {super.key,
      required this.nameController,
      required this.surnameController,
      required this.usernameController,
      required this.emailController,
      required this.onUpdate,
      required this.onPickImage,
      required this.selectedPhoto,
      required this.message,
      required this.passwordController,
      required this.passwordReController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(context.sized.mediumValue),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: context.sized.highValue,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: selectedPhoto != null ? FileImage(selectedPhoto!) : null,
                    child: selectedPhoto == null ? Icon(Icons.person, size: context.sized.highValue) : null,
                  ),
                  TextButton(
                    onPressed: onPickImage,
                    child: const Text('Fotoğraf Seç'),
                  ),
                ],
              ),
            ),
            _buildTextField('Ad', nameController, context),
            _buildTextField('Soyad', surnameController, context),
            _buildTextField('Kullanıcı Adı', usernameController, context),
            _buildTextField('Email', emailController, context),
            SizedBox(height: context.sized.mediumValue),
            GestureDetector(
              onTap: () async {
                await showDialog<void>(
                  context: context,
                  builder: _buildPasswordDialog,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.sized.highValue,
                  vertical: context.sized.lowValue,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(context.sized.normalValue),
                  border: Border.all(color: Colors.blue),
                ),
                child: const Text(
                  'Güncelle',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.sized.lowValue),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  Widget _buildPasswordDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Parolanızı Giriniz'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Parola'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: passwordReController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Parola (Tekrar)'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: () {
            String snackbarMessage;
            bool isSuccess = false;

            if (passwordController.text == passwordReController.text) {
              snackbarMessage = message;
              isSuccess = true;
              onUpdate(
                nameController.text,
                surnameController.text,
                usernameController.text,
                emailController.text,
                passwordController.text,
                passwordReController.text,
              );
            } else {
              snackbarMessage = "Şifreler uyuşmuyor!";
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(snackbarMessage)),
            );

            if (isSuccess) {
              Future.delayed(const Duration(seconds: 2), () {
                context.router.replace(const HomeRoute());
              });
            }
          },
          child: const Text('Tamam'),
        ),
      ],
    );
  }
}
