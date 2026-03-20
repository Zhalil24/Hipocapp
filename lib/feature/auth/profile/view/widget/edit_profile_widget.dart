import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
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
  final void Function(
      String name, String surname, String username, String email) onUpdate;
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
            AuthFormHeader(
              title: LocaleKeys.auth_profile_edit_title.tr(),
              description: LocaleKeys.auth_profile_edit_description.tr(),
            ),
            SizedBox(height: normal * 1.2),
            AuthInfoBanner(
              title: LocaleKeys.auth_profile_photo_banner_title.tr(),
              message: LocaleKeys.auth_profile_photo_banner_message.tr(),
            ),
            SizedBox(height: normal),
            AuthUploadCard(
              title: LocaleKeys.auth_profile_photo_title.tr(),
              description: LocaleKeys.auth_profile_photo_description.tr(),
              buttonLabel: widget.selectedPhoto == null
                  ? LocaleKeys.auth_profile_photo_select.tr()
                  : LocaleKeys.auth_profile_photo_change.tr(),
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
              label: LocaleKeys.general_button_save_changes.tr(),
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
      label: LocaleKeys.general_form_name.tr(),
      icon: Icons.badge_outlined,
      validator: Validators.notEmpty,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.givenName],
    );
  }

  Widget _buildSurnameField(BuildContext context) {
    return AuthTextField(
      controller: widget.surnameController,
      label: LocaleKeys.general_form_surname.tr(),
      icon: Icons.person_outline_rounded,
      validator: Validators.notEmpty,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.familyName],
    );
  }

  Widget _buildUsernameField(BuildContext context) {
    return AuthTextField(
      controller: widget.usernameController,
      label: LocaleKeys.general_form_username_lower.tr(),
      icon: Icons.alternate_email_rounded,
      validator: Validators.notEmpty,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.username],
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return AuthTextField(
      controller: widget.emailController,
      label: LocaleKeys.general_form_email.tr(),
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
