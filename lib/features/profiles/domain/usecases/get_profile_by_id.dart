import 'package:moviles252/domain/model/profile.dart';
import 'package:moviles252/features/profiles/data/repository/profiles_repository_impl.dart';
import 'package:moviles252/features/profiles/domain/repository/profiles_repository.dart';

class GetProfileById {
  final ProfilesRepository _repository = ProfilesRepositoryImpl();

  Future<Profile?> excecute(String id) async {
    return await _repository.getProfileById(id);
  }
}
