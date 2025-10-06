import 'package:moviles252/domain/model/profile.dart';

abstract class UserRepository {
  Future<void> registerUser(Profile profile, String password);
}
