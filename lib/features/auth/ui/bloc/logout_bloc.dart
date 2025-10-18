
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles252/features/auth/domain/usecases/logout_user_usecase.dart';

abstract class LogoutEvent {}

class SubmmitLogoutEvent extends LogoutEvent {}

abstract class LogoutState {}

class LogoutIdleState extends LogoutState {}

class LogoutErrorState extends LogoutState {}

class LogoutLoadingState extends LogoutState {}

class LogoutSuccessState extends LogoutState {}

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutUserUsecase _logoutUserUsecase = LogoutUserUsecase();

  LogoutBloc() : super(LogoutIdleState()) {
    on<SubmmitLogoutEvent>(_logoutUser);
  }

  Future<void> _logoutUser(
    SubmmitLogoutEvent event,
    Emitter<LogoutState> emit,
  ) async {
    emit(LogoutLoadingState());
    try {
      await _logoutUserUsecase.execute();
      emit(LogoutSuccessState());
    } on Exception catch (e) {
      emit(LogoutErrorState());
    }
  }
}
