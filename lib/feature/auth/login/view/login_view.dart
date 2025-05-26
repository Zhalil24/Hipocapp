import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/auth/login/view/mixin/login_view_mixin.dart';
import 'package:hipocapp/feature/auth/login/view/widget/appbar_widget.dart';
import 'package:hipocapp/feature/auth/login/view/widget/form_widget.dart';
import 'package:hipocapp/product/widget/logo/logo_banner.dart';
import 'package:hipocapp/feature/auth/login/view_model/login_view_model.dart';
import 'package:hipocapp/feature/auth/login/view_model/state/login_view_state.dart';
import 'package:hipocapp/product/utility/extension/service_snack_bar.dart';
import 'package:hipocapp/product/widget/custom_loader/custom_loader_widget.dart';
import '../../../../product/state/base/base_state.dart';

@RoutePage()
final class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseState<LoginView> with LoginViewMixin {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginViewModel,
      child: BlocListener<LoginViewModel, LoginViewState>(
        listenWhen: (prev, curr) => prev.serviceResponseMessage != curr.serviceResponseMessage && curr.serviceResponseMessage != null,
        listener: (context, state) {
          final msg = state.serviceResponseMessage;
          if (msg != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              createServiceSnackBar(msg),
            );
            context.read<LoginViewModel>().clearServiceMessage();
          }
        },
        child: Scaffold(
          appBar: const AppbarWidget(),
          body: BlocBuilder<LoginViewModel, LoginViewState>(
            builder: (context, state) {
              return state.isLoading
                  ? const Center(child: CustomLoader())
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const LogoBanner(),
                          FormWidget(
                            userNameController: _userNameController,
                            passwordController: _passwordController,
                            onLogin: () {
                              return loginViewModel.loginAndNavigate(
                                context: context,
                                userName: _userNameController.text,
                                password: _passwordController.text,
                              );
                            },
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
