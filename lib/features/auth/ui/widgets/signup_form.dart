import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles252/features/auth/ui/bloc/signup_bloc.dart';

class SignupForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;

  const SignupForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
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
          controller: nameController,
          decoration: const InputDecoration(label: Text("Nombre")),
        ),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(label: Text("Constraseña")),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        _SignupSubmitButton(
          emailController: emailController,
          passwordController: passwordController,
          nameController: nameController,
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: const Text("Ya tienes cuenta? Inicia Sesion"),
        ),
      ],
    );
  }
}

class _SignupSubmitButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;

  const _SignupSubmitButton({
    required this.emailController,
    required this.passwordController,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) => ElevatedButton(
        onPressed: () {
          context.read<SignupBloc>().add(
            SubmmitSignupEvent(
              name: nameController.text,
              email: emailController.text,
              password: passwordController.text,
            ),
          );
        },
        child: const Text("Crear usuario"),
      ),
    );
  }
}
