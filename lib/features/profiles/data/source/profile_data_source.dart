//REVISADO
import 'package:moviles252/domain/model/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileDataSource {
  Future<void> createProfile(Profile profile);
  Future<List<Profile>> getAllProfiles();
  Future<Profile?> getProfileById(String id);
}

class ProfileDataSourceImpl extends ProfileDataSource {
  @override
  Future<void> createProfile(Profile profile) async {
    await Supabase.instance.client.from("profiles").insert(profile.toJson());
  }

  @override
  Future<List<Profile>> getAllProfiles() async {
    final response = await Supabase.instance.client
        .from("profiles")
        .select()
        .order('created_at', ascending: false);
    return response.map((json) => Profile.fromJson(json)).toList();
  }

  @override
  Future<Profile?> getProfileById(String id) async {
    try {
      final response = await Supabase.instance.client
          .from("profiles")
          .select()
          .eq('id', id)
          .single();
      return Profile.fromJson(response);
    } catch (e) {
      return null;
    }
  }
}
