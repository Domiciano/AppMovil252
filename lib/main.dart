import 'package:flutter/material.dart';
import 'package:moviles252/ui/screens/login_screen.dart';
import 'package:moviles252/ui/screens/profile_screen.dart';
import 'package:moviles252/ui/screens/signup_screen.dart';
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
      initialRoute: '/signup',
      routes: {
        '/signup': (_) => SignupScreen(),
        '/login': (_) => LoginScreen(),
        '/profile': (_) => ProfileScreen(),
      },
    );
  }
}
