import 'package:capestone_test/core/common/widget/loader.dart';
import 'package:capestone_test/core/routes/app_routes.dart';
import 'package:capestone_test/core/theme/app_pallete.dart';
import 'package:capestone_test/core/util/show_snackbar.dart';
import 'package:capestone_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:capestone_test/features/auth/presentation/widgets/auth_field.dart';
import 'package:capestone_test/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:capestone_test/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _isAgreedToTerms = false;
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnackBar(
                  context: context,
                  message: state.message,
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
                return const Loader();
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
                        'Sign Up.',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(30),
                      AuthField(
                        hintText: 'Name',
                        controller: nameController,
                      ),
                      const Gap(15),
                      AuthField(
                        hintText: 'Email',
                        controller: emailController,
                      ),
                      const Gap(15),
                      AuthField(
                        hintText: 'Password',
                        controller: passwordController,
                        obscureText: isVisible,
                        suffix: IconButton(
                          padding: const EdgeInsets.only(right: 20),
                          icon: Icon(
                            isVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                        ),
                      ),
                      const Gap(15),
                      _buildIfAgreedToTerms(),
                      const Gap(15),
                      AuthGradientButton(
                        buttonText: 'Sign Up',
                        onPressed: () {
                          if (formKey.currentState!.validate() &&
                              _isAgreedToTerms) {
                            BlocProvider.of<AuthBloc>(context).add(
                              AuthSignUpEvent(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          }
                        },
                      ),
                      const Gap(15),
                      _buildIfAlreadyHaveAnAccount(),
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

  Row _buildIfAgreedToTerms() {
    return Row(
      children: [
        Checkbox(
          value: _isAgreedToTerms,
          onChanged: (newValue) {
            setState(() {
              _isAgreedToTerms = newValue!;
            });
          },
        ),
        Expanded(
          child: RichText(
            text: const TextSpan(
              text: 'By signing up, you agree to our ',
              children: [
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(
                    color: AppPallete.gradient3,
                  ),
                ),
                TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: AppPallete.gradient3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIfAlreadyHaveAnAccount() {
    return GestureDetector(
      onTap: () {
        context.goNamed(AppRoutes.login);
      },
      child: RichText(
        text: const TextSpan(
          text: 'Already have an account? ',
          children: [
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppPallete.gradient2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
