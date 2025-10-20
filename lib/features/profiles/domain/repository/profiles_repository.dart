import 'package:moviles252/domain/model/profile.dart';

abstract class ProfilesRepository {
  Future<List<Profile>> getAllProfiles();
  Future<Profile?> getProfileById(String id);
}
