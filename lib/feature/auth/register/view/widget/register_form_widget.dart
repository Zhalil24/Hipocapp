import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:hipocapp/product/utility/validator/validator.dart';
import 'package:hipocapp/product/widget/terms_popup/terms_popup_widget.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({
    super.key,
    required this.nameController,
    required this.surnameController,
    required this.usernameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.rePasswordController,
    required this.onRegister,
    required this.onPickImage,
    required this.selectedPhoto,
    required this.degreeList,
    required this.onToggle,
    required this.isChecked,
    required this.onChangedDegree,
    required this.selectedDegreeId,
    required this.isLoading,
  });

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
  final int? selectedDegreeId;
  final bool isLoading;
  final void Function(DegreeModel) onChangedDegree;
  final void Function(bool) onToggle;

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureRepeatPassword = true;

  DegreeModel? get _selectedDegree {
    final degreeList = widget.degreeList;
    if (degreeList == null) return null;
    for (final item in degreeList) {
      if (item.id == widget.selectedDegreeId) return item;
    }
    return null;
  }

  Future<void> _submit() async {
    if (widget.isLoading) return;
    if (_formKey.currentState?.validate() ?? false) {
      await widget.onRegister();
    }
  }

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return AuthFormCard(
      child: Form(
        key: _formKey,
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthFormHeader(
                title: 'Hesabini olustur',
                description: 'Bilgilerini tamamla, profilini dogrula ve Hipocapp topluluguna modern bir baslangic yap.',
              ),
              SizedBox(height: normal * 1.5),
              const AuthInfoBanner(
                title: 'Kayit once dogrulama',
                message: 'Kurum kimligi, derece secimi ve temel hesap bilgileri ile daha saglikli bir topluluk deneyimi kuruyoruz.',
              ),
              SizedBox(height: normal * 1.5),
              FormField<File>(
                validator: (value) {
                  if (value == null) {
                    return 'Devam etmek icin kurum kimligi gorseli secmelisin.';
                  }
                  return null;
                },
                initialValue: widget.selectedPhoto,
                builder: (state) {
                  return AuthUploadCard(
                    title: 'Kurum kimligi',
                    description: 'Kuruma ait kimlik ya da kart gorselini ekleyerek kaydini dogrula.',
                    buttonLabel: widget.selectedPhoto == null ? 'Gorsel Sec' : 'Gorseli Degistir',
                    errorText: state.errorText,
                    preview: widget.selectedPhoto != null
                        ? Image.file(
                            widget.selectedPhoto!,
                            fit: BoxFit.cover,
                          )
                        : null,
                    onPressed: () async {
                      final file = await widget.onPickImage();
                      state.didChange(file);
                    },
                  );
                },
              ),
              SizedBox(height: normal * 1.5),
              AuthDropdownField<DegreeModel>(
                label: 'Unvan / Derece',
                items: (widget.degreeList ?? [])
                    .map(
                      (degree) => DropdownMenuItem<DegreeModel>(
                        value: degree,
                        child: Text(degree.degreeName ?? '-'),
                      ),
                    )
                    .toList(),
                value: _selectedDegree,
                onChanged: (value) {
                  if (value != null) {
                    widget.onChangedDegree(value);
                  }
                },
                validator: (value) {
                  if (value == null) {
                    return 'Lutfen bir derece sec.';
                  }
                  return null;
                },
                icon: Icons.school_outlined,
              ),
              SizedBox(height: normal * 1.5),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 620;
                  if (isWide) {
                    return Column(
                      children: [
                        _FieldPair(
                          left: _buildNameField(),
                          right: _buildSurnameField(),
                        ),
                        SizedBox(height: normal),
                        _FieldPair(
                          left: _buildUsernameField(),
                          right: _buildEmailField(),
                        ),
                        SizedBox(height: normal),
                        _FieldPair(
                          left: _buildPhoneField(),
                          right: _buildPasswordField(context),
                        ),
                        SizedBox(height: normal),
                        _buildPasswordHint(context),
                        SizedBox(height: normal),
                        _buildPasswordRepeatField(context),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      _buildNameField(),
                      SizedBox(height: normal),
                      _buildSurnameField(),
                      SizedBox(height: normal),
                      _buildUsernameField(),
                      SizedBox(height: normal),
                      _buildEmailField(),
                      SizedBox(height: normal),
                      _buildPhoneField(),
                      SizedBox(height: normal),
                      _buildPasswordField(context),
                      SizedBox(height: normal),
                      _buildPasswordHint(context),
                      SizedBox(height: normal),
                      _buildPasswordRepeatField(context),
                    ],
                  );
                },
              ),
              SizedBox(height: normal * 1.25),
              AuthCheckboxField(
                title: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: low * 0.5,
                  children: [
                    const Text('Sartlari kabul ediyorum'),
                    GestureDetector(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (_) => const TermsPopup(),
                        );
                      },
                      child: Text(
                        '(Detaylari Gor)',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
                initialValue: widget.isChecked,
                validator: (value) {
                  if (value != true) {
                    return 'Devam etmek icin sartlari kabul etmelisin.';
                  }
                  return null;
                },
                onChanged: widget.onToggle,
              ),
              SizedBox(height: normal * 1.25),
              AuthPrimaryButton(
                label: widget.isLoading ? 'Kayit Olusturuluyor...' : 'Kayit Ol',
                isLoading: widget.isLoading,
                icon: Icons.person_add_alt_1_rounded,
                onPressed: _submit,
              ),
              SizedBox(height: normal),
              const AuthDividerLabel(label: 'Zaten hesabin var?'),
              SizedBox(height: normal),
              AuthSecondaryButton(
                label: 'Giris ekranina don',
                icon: Icons.login_rounded,
                onPressed: widget.isLoading
                    ? null
                    : () async {
                        await context.router.replace(const LoginRoute());
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return AuthTextField(
      controller: widget.nameController,
      label: 'Ad',
      icon: Icons.badge_outlined,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.givenName],
      validator: Validators.notEmpty,
      onFieldSubmitted: (_) {},
    );
  }

  Widget _buildSurnameField() {
    return AuthTextField(
      controller: widget.surnameController,
      label: 'Soyad',
      icon: Icons.person_outline_rounded,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.familyName],
      validator: Validators.notEmpty,
      onFieldSubmitted: (_) {},
    );
  }

  Widget _buildUsernameField() {
    return AuthTextField(
      controller: widget.usernameController,
      label: 'Kullanici Adi',
      icon: Icons.alternate_email_rounded,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.username],
      validator: Validators.notEmpty,
      onFieldSubmitted: (_) {},
    );
  }

  Widget _buildEmailField() {
    return AuthTextField(
      controller: widget.emailController,
      label: 'Mail Adresi',
      icon: Icons.mail_outline_rounded,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.email],
      validator: Validators.email,
      onFieldSubmitted: (_) {},
    );
  }

  Widget _buildPhoneField() {
    return AuthTextField(
      controller: widget.phoneController,
      label: 'Telefon Numarasi',
      icon: Icons.phone_outlined,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.telephoneNumber],
      validator: Validators.notEmpty,
      onFieldSubmitted: (_) {},
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return AuthTextField(
      controller: widget.passwordController,
      label: 'Sifre',
      icon: Icons.lock_outline_rounded,
      obscureText: _obscurePassword,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.newPassword],
      suffixIcon: IconButton(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        icon: Icon(
          _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
        ),
        onPressed: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
      ),
      validator: Validators.notEmpty,
      onFieldSubmitted: (_) {},
    );
  }

  Widget _buildPasswordRepeatField(BuildContext context) {
    return AuthTextField(
      controller: widget.rePasswordController,
      label: 'Sifre Tekrari',
      icon: Icons.lock_reset_rounded,
      obscureText: _obscureRepeatPassword,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.newPassword],
      suffixIcon: IconButton(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        icon: Icon(
          _obscureRepeatPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
        ),
        onPressed: () {
          setState(() {
            _obscureRepeatPassword = !_obscureRepeatPassword;
          });
        },
      ),
      validator: (val) => Validators.match(
        val,
        widget.passwordController.text,
        'Sifre',
      ),
      onFieldSubmitted: (_) async => _submit(),
    );
  }

  Widget _buildPasswordHint(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.sized.lowValue * 0.25),
      child: Text(
        'Parolan en az 1 buyuk harf, 1 kucuk harf, 1 sayi ve minimum 8 karakter icermelidir.',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
      ),
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
