import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles252/domain/model/profile.dart';
import 'package:moviles252/features/chat/ui/bloc/users_list_bloc.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersListBloc()..add(LoadUsersEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Usuarios')),
        body: BlocBuilder<UsersListBloc, UsersListState>(
          builder: (context, state) {
            if (state is UsersListLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UsersListErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                    const SizedBox(height: 16),
                    Text(
                      'Error al cargar usuarios',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<UsersListBloc>().add(LoadUsersEvent());
                      },
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              );
            } else if (state is UsersListLoadedState) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return UserCard(
                    user: user,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/chat',
                        arguments: {'user': user},
                      );
                    },
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final Profile user;
  final VoidCallback onTap;

  const UserCard({required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: ClipOval(
            child: Image.network(
              'https://ui-avatars.com/api/?name=${Uri.encodeComponent(user.name)}&background=random&color=fff&size=56',
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
        ),
        title: Text(
          user.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          user.email,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),

        onTap: onTap,
      ),
    );
  }
}
