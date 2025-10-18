import 'package:moviles252/domain/model/profile.dart';
import 'package:moviles252/features/profiles/domain/repository/profiles_repository.dart';

class CreateProfileUseCase {
  final ProfilesRepository _repository;

  CreateProfileUseCase(this._repository);

  Future<void> call(Profile profile) async {
    return await _repository.createProfile(profile);
  }
}
