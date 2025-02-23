import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_architecture_template/feature/auth/login/view/mixin/login_view_mixin.dart';
import 'package:my_architecture_template/feature/auth/login/view_model/login_view_model.dart';
import 'package:my_architecture_template/feature/auth/login/view_model/state/login_view_state.dart';

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
        child: Scaffold(
          backgroundColor: Colors.yellow[700],
          appBar: AppBar(title: const Text("Login")),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<LoginViewModel, LoginViewState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("HALİL"),
                    TextFormField(
                      controller: _userNameController,
                      style: const TextStyle(color: Colors.black), // Yazı rengi siyah olacak
                      decoration: InputDecoration(
                        labelText: "User Name",
                        labelStyle: const TextStyle(color: Colors.black), // Label siyah olacak
                        filled: true,
                        fillColor: Colors.white, // Arka plan beyaz yapıldı
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.black), // Yazı rengi siyah olacak
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.black), // Label siyah olacak
                        filled: true,
                        fillColor: Colors.white, // Arka plan beyaz yapıldı
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () async {
                        await context.read<LoginViewModel>().fetchLogin(
                              userName: _userNameController.text,
                              password: _passwordController.text,
                            );
                      },
                      child: const Text("Login"),
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}
