import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final List<Widget> pages;
  const ProfileScreen({super.key, this.pages = const []});

  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 0;

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
    return widget.pages[_currentIndex];
  }
}
