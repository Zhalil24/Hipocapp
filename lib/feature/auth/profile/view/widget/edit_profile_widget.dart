import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hipocapp/product/utility/validator/validator.dart';
import 'package:hipocapp/product/widget/circle_avatar/custom_circle_avatar.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({
    super.key,
    required this.nameController,
    required this.surnameController,
    required this.usernameController,
    required this.emailController,
    required this.onUpdate,
    required this.onPickImage,
    required this.selectedPhoto,
    required this.currentImageUrl,
  });

  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final void Function(String name, String surname, String username, String email) onUpdate;
  final Future<File?> Function() onPickImage;
  final File? selectedPhoto;
  final String currentImageUrl;

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onUpdate(
        widget.nameController.text.trim(),
        widget.surnameController.text.trim(),
        widget.usernameController.text.trim(),
        widget.emailController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;

    return AppSurfaceCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthFormHeader(
              title: 'Profili duzenle',
              description: 'Gorunen bilgilerini guncelleyerek hesabini daha guven veren ve guncel tut.',
            ),
            SizedBox(height: normal * 1.2),
            const AuthInfoBanner(
              title: 'Profil gorseli',
              message: 'Yeni bir fotograf eklediginde profil kartin ve sohbet alanlarin daha taninabilir olur.',
            ),
            SizedBox(height: normal),
            AuthUploadCard(
              title: 'Profil fotografi',
              description: 'Guncel fotografini secerek hesabinin gorunurlugunu guclendir.',
              buttonLabel: widget.selectedPhoto == null ? 'Fotograf Sec' : 'Fotografi Degistir',
              emptyIcon: Icons.camera_alt_rounded,
              preview: widget.selectedPhoto != null
                  ? Image.file(
                      widget.selectedPhoto!,
                      fit: BoxFit.cover,
                    )
                  : Center(
                      child: CustomCircleAvatar(
                        imageURL: widget.currentImageUrl,
                        radius: context.sized.height * 0.055,
                        icon: Icons.person_outline_rounded,
                      ),
                    ),
              onPressed: () async {
                await widget.onPickImage();
                if (mounted) setState(() {});
              },
            ),
            SizedBox(height: normal * 1.2),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 720;
                if (isWide) {
                  return Column(
                    children: [
                      _FieldPair(
                        left: _buildNameField(context),
                        right: _buildSurnameField(context),
                      ),
                      SizedBox(height: normal),
                      _FieldPair(
                        left: _buildUsernameField(context),
                        right: _buildEmailField(context),
                      ),
                    ],
                  );
                }

                return Column(
                  children: [
                    _buildNameField(context),
                    SizedBox(height: normal),
                    _buildSurnameField(context),
                    SizedBox(height: normal),
                    _buildUsernameField(context),
                    SizedBox(height: normal),
                    _buildEmailField(context),
                  ],
                );
              },
            ),
            SizedBox(height: normal * 1.25),
            AuthPrimaryButton(
              label: 'Degisiklikleri kaydet',
              icon: Icons.save_rounded,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField(BuildContext context) {
    return AuthTextField(
      controller: widget.nameController,
      label: 'Ad',
      icon: Icons.badge_outlined,
      validator: Validators.notEmpty,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.givenName],
    );
  }

  Widget _buildSurnameField(BuildContext context) {
    return AuthTextField(
      controller: widget.surnameController,
      label: 'Soyad',
      icon: Icons.person_outline_rounded,
      validator: Validators.notEmpty,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.familyName],
    );
  }

  Widget _buildUsernameField(BuildContext context) {
    return AuthTextField(
      controller: widget.usernameController,
      label: 'Kullanici adi',
      icon: Icons.alternate_email_rounded,
      validator: Validators.notEmpty,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.username],
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return AuthTextField(
      controller: widget.emailController,
      label: 'Email',
      icon: Icons.mail_outline_rounded,
      validator: Validators.email,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.email],
      onFieldSubmitted: (_) => _submit(),
    );
  }
}

class _FieldPair extends StatelessWidget {
  const _FieldPair({
    required this.left,
    required this.right,
  });

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        SizedBox(width: context.sized.normalValue),
        Expanded(child: right),
      ],
    );
  }
}
