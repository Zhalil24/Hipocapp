import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class EditProfileWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordReController;
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
      required this.passwordController,
      required this.passwordReController});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          ElevatedButton(
            onPressed: () async {
              await showDialog<void>(
                context: context,
                builder: (context) {
                  return _buildPasswordDialog(context);
                },
              );
            },
            child: const Text('Güncelle'),
          ),
        ],
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
            if (passwordController.text == passwordReController.text) {
              Navigator.pop(context);
              onUpdate(nameController.text, surnameController.text, usernameController.text, emailController.text, passwordController.text,
                  passwordReController.text);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Parolalar eşleşmiyor')),
              );
            }
          },
          child: const Text('Tamam'),
        ),
      ],
    );
  }
}
