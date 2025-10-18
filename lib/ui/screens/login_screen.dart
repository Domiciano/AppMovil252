import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles252/features/auth/ui/bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget content() => Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(label: Text("Correo electronico")),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(label: Text("Constraseña")),
            obscureText: true,
          ),
          submmitButton(),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
            },
            child: Text("No tienes cuenta? Registrate"),
          )
        ],
      );

  Widget submmitButton() => BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => ElevatedButton(
          onPressed: () {
            context.read<LoginBloc>().add(
                  SubmmitLoginEvent(
                    email: emailController.text,
                    password: passwordController.text,
                  ),
                );
          },
          child: Text("Iniciar Sesion"),
        ),
      );

  Widget dynamicContent() => BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
        builder: (context, state) {
          if (state is LoginIdleState) {
            return content();
          } else if (state is LoginLoadingState) {
            return CircularProgressIndicator();
          } else if (state is LoginSuccessState) {
            return SizedBox.shrink();
          } else {
            return content();
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: BlocProvider(
      create: (context) => LoginBloc(),
      child: dynamicContent(),
    )));
  }
}