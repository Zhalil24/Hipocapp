import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/auth/login/view/mixin/login_view_mixin.dart';
import 'package:hipocapp/feature/auth/login/view_model/login_view_model.dart';
import 'package:hipocapp/feature/auth/login/view_model/state/login_view_state.dart';
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
          appBar: AppBar(
              title: Center(
                  child: const Text(
            "Hipocapp",
            style: TextStyle(fontWeight: FontWeight.w700),
          ))),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<LoginViewModel, LoginViewState>(
              builder: (context, state) {
                return state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 300,
                              height: 300,
                              child: Assets.images.logo.image(package: 'gen'),
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            TextFormField(
                              controller: _userNameController,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Kullanıcı Adı",
                                labelStyle: const TextStyle(color: Colors.black),
                                filled: true,
                                fillColor: Colors.white,
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
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Şifre",
                                labelStyle: const TextStyle(color: Colors.black),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () async {
                                final success = await loginViewModel.loginAndNavigate(
                                  context: context,
                                  userName: _userNameController.text,
                                  password: _passwordController.text,
                                );

                                if (!success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Giriş başarısız. Lütfen bilgilerinizi kontrol edin.')),
                                  );
                                }
                              },
                              child: const Text("Giriş"),
                            )
                          ],
                        ),
                      );
              },
            ),
          ),
        ));
  }
}
