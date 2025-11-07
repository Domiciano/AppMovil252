import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles252/features/auth/ui/bloc/login_bloc.dart';
import 'package:moviles252/features/auth/ui/bloc/signup_bloc.dart';
import 'package:moviles252/features/profiles/ui/bloc/profiles_list_bloc.dart';
import 'package:moviles252/features/profiles/ui/screens/profiles_page.dart';
import 'package:moviles252/ui/screens/login_screen.dart';
import 'package:moviles252/ui/screens/map_screen.dart';
import 'package:moviles252/ui/screens/my_profile_page.dart';
import 'package:moviles252/ui/screens/post_page.dart';
import 'package:moviles252/ui/screens/profile_screen.dart';
import 'package:moviles252/features/auth/ui/screens/signup_screen.dart';
import 'package:moviles252/features/chat/ui/bloc/chat_bloc.dart';
import 'package:moviles252/features/chat/ui/screens/chat_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://yzosfzyewkdpnmlbgbej.supabase.co',
    anonKey: 'sb_publishable_sVlCTCKFQ9NktJjQTOmahw_QoBUGODX',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/maps',
      routes: {
        '/signup': (_) =>
            BlocProvider(create: (_) => SignupBloc(), child: SignupScreen()),
        '/login': (_) =>
            BlocProvider(create: (_) => LoginBloc(), child: LoginScreen()),
        '/chat': (_) =>
            BlocProvider(create: (_) => ChatBloc(), child: const ChatScreen()),
        '/profile': (_) => ProfileScreen(
          pages: [
            MyProfilePage(),
            PostPage(),
            BlocProvider(
              create: (context) => ProfilesListBloc(),
              child: ProfilesPage(),
            ),
          ],
        ),
        '/maps': (_) => MapScreen()
      },
    );
  }
}
