import 'package:flutter/material.dart';
import 'package:moviles252/ui/screens/my_profile_page.dart';
import 'package:moviles252/ui/screens/post_page.dart';
import 'package:moviles252/features/chat/ui/screens/users_list_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [MyProfilePage(), PostPage(), UsersListScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: currentPage()),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: "Post"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
        ],
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }

  Widget currentPage() {
    return _pages[_currentIndex];
  }
}
