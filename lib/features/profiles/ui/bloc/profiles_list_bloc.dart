import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles252/domain/model/profile.dart';
import 'package:moviles252/features/profiles/domain/usecases/get_all_profiles_usecase.dart';

// Events
abstract class ProfilesListEvent {}

class LoadProfilesEvent extends ProfilesListEvent {}

// States
abstract class ProfilesListState {}

class ProfilesListInitialState extends ProfilesListState {}

class ProfilesListLoadingState extends ProfilesListState {}

class ProfilesListLoadedState extends ProfilesListState {
  final List<Profile> profiles;
  ProfilesListLoadedState({required this.profiles});
}

class ProfilesListErrorState extends ProfilesListState {
  final String message;
  ProfilesListErrorState({required this.message});
}

// Bloc
class ProfilesListBloc extends Bloc<ProfilesListEvent, ProfilesListState> {
  final GetAllProfilesUseCase _getAllProfilesUseCase = GetAllProfilesUseCase();

  ProfilesListBloc() : super(ProfilesListInitialState()) {
    on<LoadProfilesEvent>(_onLoadProfiles);
  }

  void _onLoadProfiles(
    LoadProfilesEvent event,
    Emitter<ProfilesListState> emit,
  ) async {
    emit(ProfilesListLoadingState());

    try {
      final profiles = await _getAllProfilesUseCase.excecute();
      emit(ProfilesListLoadedState(profiles: profiles));
    } catch (e) {
      emit(ProfilesListErrorState(message: 'Error al cargar perfiles: $e'));
    }
  }
}
