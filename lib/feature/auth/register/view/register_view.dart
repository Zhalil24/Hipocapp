import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/auth/register/view/mixin/register_view_mixin.dart';
import 'package:hipocapp/feature/auth/register/view/widget/register_page_content_widget.dart';
import 'package:hipocapp/feature/auth/register/view_model/register_view_model.dart';
import 'package:hipocapp/feature/auth/register/view_model/state/register_view_state.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/utility/extension/service_snack_bar.dart';

@RoutePage()
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends BaseState<RegisterView> with RegisterViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => registerViewModel,
      child: BlocListener<RegisterViewModel, RegisterViewState>(
        listenWhen: (prev, curr) => prev.serviceResponseMessage != curr.serviceResponseMessage && curr.serviceResponseMessage != null,
        listener: (context, state) {
          final msg = state.serviceResponseMessage;
          if (msg != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              createServiceSnackBar(msg),
            );
            registerViewModel.clearServiceMessage();
          }
        },
        child: Scaffold(
          body: BlocBuilder<RegisterViewModel, RegisterViewState>(
            builder: (context, state) {
              final isInitialLoading = state.degree == null && state.isLoading;
              final isSubmitting = state.degree != null && state.isLoading;

              return RegisterPageContentWidget(
                isLoading: isSubmitting,
                showBlockingLoader: isInitialLoading,
                degreeList: state.degree,
                selectedPhoto: state.photo,
                selectedDegreeId: state.degreeId,
                isChecked: state.isCheck,
                nameController: nameController,
                surnameController: surnameController,
                usernameController: usernameController,
                emailController: emailController,
                phoneController: phoneController,
                passwordController: passwordController,
                rePasswordController: rePasswordController,
                onPickImage: pickImageFromGallery,
                onChangedDegree: (selected) {
                  registerViewModel.updateDegreeId(selected.id ?? 0);
                },
                onToggle: registerViewModel.updateIsCheck,
                onRegister: () async {
                  await registerViewModel.userRegister(
                    nameController.text,
                    usernameController.text,
                    surnameController.text,
                    passwordController.text,
                    rePasswordController.text,
                    phoneController.text,
                    emailController.text,
                    state.isCheck,
                    context,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
