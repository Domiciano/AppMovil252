import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles252/domain/model/profile.dart';
import 'package:moviles252/features/auth/domain/usecases/register_user_usecase.dart';

abstract class RegisterEvent {}

class SubmitRegisterEvent extends RegisterEvent {
  final String email;
  final String name;
  final String password;
  SubmitRegisterEvent({
    required this.email,
    required this.name,
    required this.password,
  });
}

abstract class RegisterState {}

class RegisterIdle extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterError extends RegisterState {
  final String message;
  RegisterError({required this.message});
}

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUserUseCase registerUserUseCase = RegisterUserUseCase();

  RegisterBloc() : super(RegisterIdle()) {
    on<SubmitRegisterEvent>(_onSubmitRegister);
  }

  Future<void> _onSubmitRegister(
    SubmitRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      await registerUserUseCase.execute(
        Profile(
          id: "",
          name: event.name,
          email: event.email,
          createdAt: DateTime.now(),
        ),
        event.password,
      );
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterError(message: "No se pudo registrar el usuario"));
    }
  }
}
