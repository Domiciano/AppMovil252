import 'package:moviles252/domain/model/profile.dart';
import 'package:moviles252/features/auth/data/repository/user_repository_impl.dart';
import 'package:moviles252/features/auth/domain/repository/auth_repository.dart';

class RegisterUserUseCase {
  final UserRepository repository = UserRepositoryImpl();

  Future<void> execute(Profile profile, String password) {
    return repository.registerUser(profile, password);
  }
}
