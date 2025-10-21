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
    var response = await Supabase.instance.client
        .from("profiles")
        .select()
        .order("created_at", ascending: false);
    var list = response.map((json) => Profile.fromJson(json)).toList();
    return list;
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
