import 'package:flutter/material.dart';
import 'package:moviles252/domain/model/profile.dart';

class ProfileCard extends StatelessWidget {
  final Profile profile;
  final VoidCallback? onTap;

  const ProfileCard({super.key, required this.profile, this.onTap});

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
              'https://ui-avatars.com/api/?name=${Uri.encodeComponent(profile.name)}&background=random&color=fff&size=56',
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Text(
                  profile.name.isNotEmpty ? profile.name[0].toUpperCase() : 'U',
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
          profile.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              profile.email,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              'Miembro desde ${_formatDate(profile.createdAt)}',
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey[400],
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? 'hace 1 año' : 'hace $years años';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? 'hace 1 mes' : 'hace $months meses';
    } else if (difference.inDays > 0) {
      return difference.inDays == 1
          ? 'hace 1 día'
          : 'hace ${difference.inDays} días';
    } else {
      return 'hoy';
    }
  }
}
