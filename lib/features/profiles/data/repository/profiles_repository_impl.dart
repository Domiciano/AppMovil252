//REVISADO
import 'package:moviles252/domain/model/profile.dart';
import 'package:moviles252/features/profiles/domain/repository/profiles_repository.dart';
import 'package:moviles252/features/profiles/data/source/profile_data_source.dart';

class ProfilesRepositoryImpl implements ProfilesRepository {
  final ProfileDataSource _dataSource = ProfileDataSourceImpl();

  @override
  Future<List<Profile>> getAllProfiles() async {
    return await _dataSource.getAllProfiles();
  }

  @override
  Future<void> createProfile(Profile profile) async {
    return await _dataSource.createProfile(profile);
  }

  @override
  Future<Profile?> getProfileById(String id) async {
    final profiles = await getAllProfiles();
    try {
      return profiles.firstWhere((profile) => profile.id == id);
    } catch (e) {
      return null;
    }
  }

  // Datos dummy para desarrollo
  List<Profile> _getDummyProfiles() {
    return [
      Profile(
        id: '1',
        name: 'Juan Pérez',
        email: 'juan@example.com',
        createdAt: DateTime.now().subtract(Duration(days: 30)),
      ),
      Profile(
        id: '2',
        name: 'María García',
        email: 'maria@example.com',
        createdAt: DateTime.now().subtract(Duration(days: 25)),
      ),
      Profile(
        id: '3',
        name: 'Carlos López',
        email: 'carlos@example.com',
        createdAt: DateTime.now().subtract(Duration(days: 20)),
      ),
      Profile(
        id: '4',
        name: 'Ana Martínez',
        email: 'ana@example.com',
        createdAt: DateTime.now().subtract(Duration(days: 15)),
      ),
      Profile(
        id: '5',
        name: 'Luis Rodríguez',
        email: 'luis@example.com',
        createdAt: DateTime.now().subtract(Duration(days: 10)),
      ),
      Profile(
        id: '6',
        name: 'Sofia Hernández',
        email: 'sofia@example.com',
        createdAt: DateTime.now().subtract(Duration(days: 5)),
      ),
      Profile(
        id: '7',
        name: 'Diego Morales',
        email: 'diego@example.com',
        createdAt: DateTime.now().subtract(Duration(days: 3)),
      ),
      Profile(
        id: '8',
        name: 'Laura Jiménez',
        email: 'laura@example.com',
        createdAt: DateTime.now().subtract(Duration(days: 1)),
      ),
    ];
  }
}
