import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles252/features/auth/ui/bloc/signup_bloc.dart';
import 'package:moviles252/features/auth/ui/widgets/signup_form.dart';

class SignupContent extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;

  const SignupContent({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        if (state is SignupIdleState) {
          return SignupForm(
            emailController: emailController,
            passwordController: passwordController,
            nameController: nameController,
          );
        } else if (state is SignupLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SignupSuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/profile');
          });
          return const SizedBox.shrink();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
