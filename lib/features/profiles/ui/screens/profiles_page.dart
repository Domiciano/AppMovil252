import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles252/domain/model/profile.dart';
import 'package:moviles252/features/profiles/ui/bloc/profiles_list_bloc.dart';
import 'package:moviles252/features/profiles/ui/widgets/profile_card.dart';

class ProfilesPage extends StatelessWidget {
  final Function(Profile)? onProfileTap;

  const ProfilesPage({super.key, this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilesListBloc, ProfilesListState>(
      builder: (context, state) {
        if (state is ProfilesListInitialState) {
          context.read<ProfilesListBloc>().add(
            LoadProfilesEvent(),
          ); //Carga inicial de datos
        } else if (state is ProfilesListLoadingState) {
          return CircularProgressIndicator();
        } else if (state is ProfilesListErrorState) {
          return Text('Error al cargar perfiles: ${state.message}');
        } else if (state is ProfilesListLoadedState) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.profiles.length,
            itemBuilder: (context, index) {
              final clickedProfile = state.profiles[index];
              return ProfileCard(
                profile: clickedProfile,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/chat',
                    arguments: {"otherUser": clickedProfile},
                  );
                },
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
