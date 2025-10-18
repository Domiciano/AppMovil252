
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles252/features/auth/domain/usecases/login_user_usecase.dart';

abstract class LoginEvent {}

class SubmmitLoginEvent extends LoginEvent {
  String email;
  String password;
  SubmmitLoginEvent({
    required this.email,
    required this.password,
  });
}

abstract class LoginState {}

class LoginIdleState extends LoginState {}

class LoginErrorState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginUserUsecase _loginUserUsecase = LoginUserUsecase();

  LoginBloc() : super(LoginIdleState()) {
    on<SubmmitLoginEvent>(_loginUser);
  }

  Future<void> _loginUser(
    SubmmitLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());
    try {
      await _loginUserUsecase.execute(
        event.email,
        event.password,
      );
      emit(LoginSuccessState());
    } on Exception catch (e) {
      emit(LoginErrorState());
    }
  }
}
