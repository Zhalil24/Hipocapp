import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/widget/button/custom_action_button/custom_action_button.dart';
import 'package:kartal/kartal.dart';

class EditProfileWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;

  final void Function(String name, String surname, String username, String email) onUpdate;
  final Future<File?> Function() onPickImage;
  final File? selectedPhoto;

  const EditProfileWidget({
    super.key,
    required this.nameController,
    required this.surnameController,
    required this.usernameController,
    required this.emailController,
    required this.onUpdate,
    required this.onPickImage,
    required this.selectedPhoto,
  });

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
            CustomActionButton(
              onTop: () {
                onUpdate(nameController.text, surnameController.text, usernameController.text, emailController.text);
              },
              text: 'Güncelle',
            )
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
}
