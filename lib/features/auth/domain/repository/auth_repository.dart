import 'package:moviles252/domain/model/profile.dart';

abstract class AuthRepository {
  Future<void> registerUser(Profile profile, String password);
  Future<void> loginUser(String email, String password);
  Future<void> logoutUser();
}
