import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_project/auth/bloc/auth_cubit.dart';
import 'package:new_project/auth/bloc/auth_state.dart';
import 'package:new_project/widgets/app_text_field.dart';

import '../../widgets/app_snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = true;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!formKey.currentState!.validate()) {

      return;
    }
    final data = {"email": email, "password": password};
    context.read<AuthCubit>().login(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, state) {
            final loading = state.status == ApiStatus.loading;

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.lock_outline,
                        size: 55,
                        color: Color(0xff6254D9),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Login to continue your journey.',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),

                      const SizedBox(height: 35),


                      AppTextField(
                        controller: emailController,
                        label: 'Enter your email',
                        isHint: true,
                        heading: "Email address",
                        leading: Icons.email_outlined,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Please enter your email address";
                          }
                          if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(v)) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),


                      AppTextField(
                        controller: passwordController,
                        label: 'Enter your password',
                        isHint: true,
                        isPassword: showPassword,
                        heading: "Password",
                        leading: Icons.lock_outline,
                        trailing: IconButton(
                          onPressed: () {
                            showPassword = !showPassword;
                            setState(() {});
                          },
                          icon: Icon(
                            showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 26,
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Please enter password";
                          }
                          if (!RegExp(
                            r'^(?=.*[A-Za-z])(?=.*\d).{8,}$',
                          ).hasMatch(v)) {
                            return "Password must contain at least 8 characters, one letter\n and one number";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: loading ? null : login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6254D9),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Login',
                                  style: TextStyle(fontSize: 17),
                                ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                            GestureDetector(
                              onTap: () {
                                context.go('/signup');
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Color(0xff6254D9),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {
            if (state.status == ApiStatus.success) {
              if (state.operation == AuthOperation.login) {
                AppSnackBar.success(state.message);

                context.go("/home");
              }
            }
            if (state.status == ApiStatus.failure) {
              AppSnackBar.error(state.message);
            }
          },
        ),
      ),
    );
  }
}
