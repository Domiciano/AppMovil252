
import 'package:moviles252/features/auth/domain/repository/auth_repository.dart';
import 'package:moviles252/features/auth/data/repository/auth_repository_impl.dart';

class LoginUserUsecase {
  AuthRepository _authRepository = AuthRepositoryImpl();

  Future<void> execute(String email, String password) async {
    await _authRepository.loginUser(email, password);
  }
}
