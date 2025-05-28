import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/auth/register/view/mixin/register_view_mixin.dart';
import 'package:hipocapp/feature/auth/register/view/widget/form_widget.dart';
import 'package:hipocapp/feature/auth/register/view_model/register_view_model.dart';
import 'package:hipocapp/feature/auth/register/view_model/state/register_view_state.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/utility/extension/service_snack_bar.dart';
import 'package:hipocapp/product/widget/custom_loader/custom_loader_widget.dart';

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
          appBar: AppBar(
            title: const Text('Kayıt Ol'),
            centerTitle: true,
          ),
          body: BlocBuilder<RegisterViewModel, RegisterViewState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CustomLoader(),
                );
              }
              return FormWidget(
                degreeList: state.degree,
                emailController: emailController,
                nameController: nameController,
                passwordController: passwordController,
                phoneController: phoneController,
                rePasswordController: rePasswordController,
                surnameController: surnameController,
                usernameController: usernameController,
                selectedPhoto: state.photo,
                onPickImage: pickImageFromGallery,
                onChangedDegree: (selected) => {
                  registerViewModel.updateDegreeId(
                    selected.id ?? 0,
                  )
                },
                isChecked: false,
                onToggle: (value) {
                  registerViewModel.updateIsCheck(value);
                },
                onRegister: () async {
                  await registerViewModel.userRegister(
                    nameController.text,
                    usernameController.text,
                    surnameController.text,
                    passwordController.text,
                    rePasswordController.text,
                    phoneController.text,
                    emailController.text,
                    true,
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
