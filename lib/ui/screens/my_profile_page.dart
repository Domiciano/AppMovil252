import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles252/features/auth/ui/bloc/logout_bloc.dart';

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogoutBloc(),
      child: BlocConsumer<LogoutBloc, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<LogoutBloc>().add(SubmmitLogoutEvent());
                },
                child: Text("Cerrar sesion"),
              ),
              if (state is LogoutLoadingState)
                CircularProgressIndicator(),
            ],
          );
        },
      ),
    );
  }
}