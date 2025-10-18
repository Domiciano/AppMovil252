import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles252/domain/model/profile.dart';

// Events
abstract class UsersListEvent {}

class LoadUsersEvent extends UsersListEvent {}

// States
abstract class UsersListState {}

class UsersListInitialState extends UsersListState {}

class UsersListLoadingState extends UsersListState {}

class UsersListLoadedState extends UsersListState {
  final List<Profile> users;
  UsersListLoadedState({required this.users});
}

class UsersListErrorState extends UsersListState {
  final String message;
  UsersListErrorState({required this.message});
}

// Bloc
class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  UsersListBloc() : super(UsersListInitialState()) {
    on<LoadUsersEvent>(_onLoadUsers);
  }

  void _onLoadUsers(LoadUsersEvent event, Emitter<UsersListState> emit) async {
    emit(UsersListLoadingState());

    try {
      // Datos dummy para mostrar la funcionalidad
      final dummyUsers = [
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
      ];

      emit(UsersListLoadedState(users: dummyUsers));
    } catch (e) {
      emit(UsersListErrorState(message: 'Error al cargar usuarios: $e'));
    }
  }
}
