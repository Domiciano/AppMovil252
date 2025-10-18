
import 'package:moviles252/features/auth/domain/repository/auth_repository.dart';
import 'package:moviles252/features/auth/data/repository/auth_repository_impl.dart';

class LogoutUserUsecase {
  AuthRepository _authRepository = AuthRepositoryImpl();

  Future<void> execute() async {
    await _authRepository.logoutUser();
  }
}
