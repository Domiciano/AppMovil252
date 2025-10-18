import 'package:moviles252/domain/model/profile.dart';
import 'package:moviles252/features/auth/data/source/auth_data_source.dart';
import 'package:moviles252/features/auth/domain/repository/auth_repository.dart';
import 'package:moviles252/features/profiles/data/source/profile_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthDataSource _authDataSource = AuthDataSourceImpl();
  ProfileDataSource _profileDataSource = ProfileDataSourceImpl();

  @override
  Future<void> registerUser(Profile profile, String password) async {
    //1. Registrarnos en el servico de Auth
    String? userId = await _authDataSource.signUp(profile.email, password);
    //2. Crear el Profile
    if (userId != null) {
      profile.id = userId;
      _profileDataSource.createProfile(profile);
    }
  }

  @override
  Future<void> loginUser(String email, String password) async {
    await _authDataSource.signIn(email, password);
  }

  @override
  Future<void> logoutUser() async {
    await _authDataSource.signOut();
  }

  @override
  Future<Profile?> getCurrentUser() async {
    try {
      final user = await _authDataSource.getCurrentUser();
      if (user != null) {
        // Buscar el perfil completo en la base de datos
        return await _profileDataSource.getProfileById(user.id);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
