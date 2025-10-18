// data/datasources/auth_datasource.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:moviles252/domain/model/profile.dart';

abstract class AuthDataSource {
  Future<String?> signUp(String email, String password);
  Future<void> signIn(String email, String password);
  Future<void> signOut();
  Future<Profile?> getCurrentUser();
}

class AuthDataSourceImpl extends AuthDataSource {
  @override
  Future<String?> signUp(String email, String password) async {
    AuthResponse response = await Supabase.instance.client.auth.signUp(
      email: email,
      password: password,
    );
    return response.user?.id;
  }

  @override
  Future<void> signIn(String email, String password) async {
    await Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
  }

  @override
  Future<Profile?> getCurrentUser() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user != null) {
        return Profile(
          id: user.id,
          name: user.userMetadata?['name'] ?? 'Usuario',
          email: user.email ?? '',
          createdAt: DateTime.parse(user.createdAt),
        );
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
