import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles252/features/auth/ui/bloc/login_bloc.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(label: Text("Correo electronico")),
        ),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(label: Text("Constraseña")),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        _LoginSubmitButton(
          emailController: emailController,
          passwordController: passwordController,
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/signup');
          },
          child: const Text("No tienes cuenta? Registrate"),
        ),
      ],
    );
  }
}

class _LoginSubmitButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _LoginSubmitButton({
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => ElevatedButton(
        onPressed: () {
          context.read<LoginBloc>().add(
            SubmmitLoginEvent(
              email: emailController.text,
              password: passwordController.text,
            ),
          );
        },
        child: const Text("Iniciar Sesion"),
      ),
    );
  }
}
