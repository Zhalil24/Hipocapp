import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:kartal/kartal.dart';

import 'register_background_widget.dart';
import 'register_form_widget.dart';
import 'register_hero_panel_widget.dart';
import 'register_page_skeleton_widget.dart';

class RegisterPageContentWidget extends StatelessWidget {
  const RegisterPageContentWidget({
    super.key,
    required this.isLoading,
    required this.showBlockingLoader,
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
  });

  final bool isLoading;
  final bool showBlockingLoader;
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
  final void Function(DegreeModel) onChangedDegree;
  final void Function(bool) onToggle;

  @override
  Widget build(BuildContext context) {
    final low = context.sized.lowValue;
    final normal = context.sized.normalValue;

    return Stack(
      children: [
        const Positioned.fill(child: RegisterBackgroundWidget()),
        Positioned.fill(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 960;
              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  normal + (low * 0.5),
                  normal * 1.5,
                  normal + (low * 0.5),
                  normal * 1.5,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1180),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, (normal * 1.5) * (1 - value)),
                            child: child,
                          ),
                        );
                      },
                      child: isWide
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(right: normal * 1.75),
                                    child: const RegisterHeroPanelWidget(),
                                  ),
                                ),
                                Expanded(
                                  child: RegisterFormWidget(
                                    isLoading: isLoading,
                                    nameController: nameController,
                                    surnameController: surnameController,
                                    usernameController: usernameController,
                                    emailController: emailController,
                                    phoneController: phoneController,
                                    passwordController: passwordController,
                                    rePasswordController: rePasswordController,
                                    onRegister: onRegister,
                                    onPickImage: onPickImage,
                                    selectedPhoto: selectedPhoto,
                                    degreeList: degreeList,
                                    onToggle: onToggle,
                                    isChecked: isChecked,
                                    onChangedDegree: onChangedDegree,
                                    selectedDegreeId: selectedDegreeId,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const RegisterHeroPanelWidget(isCompact: true),
                                SizedBox(height: normal + (low * 0.5)),
                                RegisterFormWidget(
                                  isLoading: isLoading,
                                  nameController: nameController,
                                  surnameController: surnameController,
                                  usernameController: usernameController,
                                  emailController: emailController,
                                  phoneController: phoneController,
                                  passwordController: passwordController,
                                  rePasswordController: rePasswordController,
                                  onRegister: onRegister,
                                  onPickImage: onPickImage,
                                  selectedPhoto: selectedPhoto,
                                  degreeList: degreeList,
                                  onToggle: onToggle,
                                  isChecked: isChecked,
                                  onChangedDegree: onChangedDegree,
                                  selectedDegreeId: selectedDegreeId,
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (showBlockingLoader)
          const Positioned.fill(
            child: IgnorePointer(
              child: RegisterPageSkeletonWidget(
                showBackground: false,
              ),
            ),
          ),
      ],
    );
  }
}
