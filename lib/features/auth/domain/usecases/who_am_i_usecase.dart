import 'package:moviles252/domain/model/profile.dart';
import 'package:moviles252/features/auth/data/repository/auth_repository_impl.dart';
import 'package:moviles252/features/auth/domain/repository/auth_repository.dart';

class WhoAmIUseCase {
  final AuthRepository _repository = AuthRepositoryImpl();

  Future<Profile?> call() async {
    return await _repository.getCurrentUser();
  }
}
