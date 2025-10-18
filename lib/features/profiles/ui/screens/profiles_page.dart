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
    return BlocProvider(
      create: (context) => ProfilesListBloc(),
      child: BlocBuilder<ProfilesListBloc, ProfilesListState>(
        builder: (context, state) {
          if (state is ProfilesListLoadingState) {
            return CircularProgressIndicator();
          } else if (state is ProfilesListErrorState) {
            return Text('Error al cargar perfiles');
          } else if (state is ProfilesListLoadedState) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.profiles.length,
              itemBuilder: (context, index) {
                final profile = state.profiles[index];
                return ProfileCard(
                  profile: profile,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/chat',
                      arguments: {"otherUser": profile},
                    );
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
