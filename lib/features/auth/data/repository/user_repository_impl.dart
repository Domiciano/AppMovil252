import 'package:moviles252/domain/model/profile.dart';
import 'package:moviles252/features/auth/data/source/auth_data_source.dart';
import 'package:moviles252/features/auth/domain/repository/auth_repository.dart';
import 'package:moviles252/features/profile/data/source/profile_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthDataSource authDataSource = AuthDataSourceImpl();
  final ProfileDataSource profileDataSource = ProfileDataSourceImpl();

  @override
  Future<void> registerUser(Profile profile, String password) async {
    final userId = await authDataSource.signUp(profile.email, password);
    if (userId != null) {
      profile.id = userId;
      await profileDataSource.createProfile(profile);
    }
  }
}
