import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/auth/register/view/mixin/register_view_mixin.dart';
import 'package:hipocapp/feature/auth/register/view/widget/form_widget.dart';
import 'package:hipocapp/feature/auth/register/view_model/register_view_model.dart';
import 'package:hipocapp/feature/auth/register/view_model/state/register_view_state.dart';
import 'package:hipocapp/product/state/base/base_state.dart';

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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kayıt Ol'),
          centerTitle: true,
        ),
        body: BlocBuilder<RegisterViewModel, RegisterViewState>(
          builder: (context, state) {
            return FormWidget(
              degreeList: state.degree,
              emailController: emailController,
              nameController: nameController,
              passwordController: passwordController,
              phoneController: phoneController,
              rePasswordController: rePasswordController,
              surnameController: surnameController,
              usernameController: usernameController,
              selectedPhoto: null,
              onPickImage: () async {},
              onRegister: () async {},
              onChangedDegree: (selected) => {},
            );
          },
        ),
      ),
    );
  }
}
