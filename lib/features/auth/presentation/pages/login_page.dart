import 'package:capestone_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:capestone_test/features/auth/presentation/pages/signup_page.dart';
import 'package:capestone_test/features/auth/presentation/widgets/auth_field.dart';
import 'package:capestone_test/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:capestone_test/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();

  bool isVisible = true;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              } else if (state is AuthSuccess) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const BlogPage()),
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Gap(100),
                      const Text(
                        'Sign In.',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(30),
                      AuthField(
                        hintText: 'Email',
                        controller: emailController,
                      ),
                      const Gap(20),
                      AuthField(
                        hintText: 'Password',
                        controller: passwordController,
                        obscureText: isVisible,
                        suffix: IconButton(
                          highlightColor: Colors.transparent,
                          padding: const EdgeInsets.only(right: 20),
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(
                            isVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                      const Gap(20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                      const Gap(20),
                      AuthGradientButton(
                        buttonText: 'Sign in',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(
                              AuthSignInEvent(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          }
                        },
                      ),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpPage(),
                                ),
                              );
                            },
                            child: const Text('Sign Up'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
