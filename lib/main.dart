import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moviles252/features/auth/ui/bloc/login_bloc.dart';
import 'package:moviles252/features/auth/ui/bloc/signup_bloc.dart';
import 'package:moviles252/features/profiles/ui/bloc/profiles_list_bloc.dart';
import 'package:moviles252/features/profiles/ui/screens/profiles_page.dart';
import 'package:moviles252/ui/screens/login_screen.dart';
import 'package:moviles252/ui/screens/my_profile_page.dart';
import 'package:moviles252/ui/screens/post_page.dart';
import 'package:moviles252/ui/screens/profile_screen.dart';
import 'package:moviles252/features/auth/ui/screens/signup_screen.dart';
import 'package:moviles252/features/chat/ui/bloc/chat_bloc.dart';
import 'package:moviles252/features/chat/ui/screens/chat_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('🔙 Mensaje recibido en background: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // Manejo de notificaciones en background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Configura canal local
  const AndroidInitializationSettings initSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initSettings = InitializationSettings(
    android: initSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initSettings);

  await registerAndroidChannel();

  await Supabase.initialize(
    url: 'https://yzosfzyewkdpnmlbgbej.supabase.co',
    anonKey: 'sb_publishable_sVlCTCKFQ9NktJjQTOmahw_QoBUGODX',
  );

  runApp(const App());
}

Future<void> registerAndroidChannel() async {
  // Crear canal de notificaciones de alta prioridad
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'canal_importante',
    'Notificaciones importantes',
    description: 'Canal para notificaciones heads-up',
    importance: Importance.high,
    playSound: true,
  );

  // Registrar canal en Android
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<App> {
  int id = 0;

  @override
  void initState() {
    super.initState();
    _initNotifications();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/login',
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
      },
    );
  }

  Future<void> _initNotifications() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // 🔐 Solicita permisos (solo necesario en iOS)
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('Permisos otorgados: ${settings.authorizationStatus}');

    // 🔔 Suscripción al topic
    await messaging.subscribeToTopic("mi_topic_general");
    print("✅ Suscrito al topic mi_topic_general");

    // 📩 Cuando la app está en foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("💬 Mensaje recibido en foreground: ${message.data}");

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      flutterLocalNotificationsPlugin.show(
        id++,
        "Nuevo mensaje",
        "${message.data}",
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'canal_notif', // ID único del canal
            'Notificaciones generales',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    });
  }
}
