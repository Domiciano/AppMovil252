import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles252/features/auth/ui/bloc/login_bloc.dart';
import 'package:moviles252/features/auth/ui/widgets/login_form.dart';

class LoginContent extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginContent({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushReplacementNamed(context, '/profile');
        }
      },
      builder: (context, state) {
        if (state is LoginIdleState) {
          return LoginForm(
            emailController: emailController,
            passwordController: passwordController,
          );
        } else if (state is LoginLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LoginSuccessState) {
          return const SizedBox.shrink();
        } else {
          return LoginForm(
            emailController: emailController,
            passwordController: passwordController,
          );
        }
      },
    );
  }
}
