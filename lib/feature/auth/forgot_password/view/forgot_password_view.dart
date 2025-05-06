import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/auth/forgot_password/view/mixin/forgot_password_view_mixin.dart';
import 'package:hipocapp/feature/auth/forgot_password/view/widget/form_widget.dart';
import 'package:hipocapp/feature/auth/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:hipocapp/feature/auth/forgot_password/view_model/state/forgot_password_view_state.dart';
import 'package:hipocapp/feature/auth/login/view/widget/appbar_widget.dart';
import 'package:hipocapp/feature/auth/login/view/widget/logo_banner.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/utility/extension/service_snack_bar.dart';

@RoutePage()
class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends BaseState<ForgotPasswordView> with ForgotPasswordViewMixin {
  final TextEditingController _emailNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => forgotPasswordViewModel,
      child: BlocListener<ForgotPasswordViewModel, ForgotPasswordViewState>(
        listenWhen: (prev, curr) => prev.serviceResponseMessage != curr.serviceResponseMessage && curr.serviceResponseMessage != null,
        listener: (context, state) {
          final msg = state.serviceResponseMessage;
          if (msg != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              createServiceSnackBar(msg),
            );
            context.read<ForgotPasswordViewModel>().clearServiceMessage();
          }
        },
        child: Scaffold(
          appBar: const AppbarWidget(),
          body: BlocBuilder<ForgotPasswordViewModel, ForgotPasswordViewState>(
            builder: (context, state) {
              return state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const LogoBanner(),
                          FormWidget(
                            emailNameController: _emailNameController,
                            onPressed: () {
                              forgotPasswordViewModel.forgotPassword(
                                _emailNameController.text,
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
