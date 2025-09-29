import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignupScreenState();
  }
}

class SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("*******");
    print(Supabase.instance.client.auth.currentUser);
    print("+++++++");
    print(Supabase.instance.client.auth.currentSession);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(label: Text("Correo electronico")),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(label: Text("Constraseña")),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () =>
                  _signup(emailController.text, passwordController.text),
              child: Text("Registrarse"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signup(String email, String pass) async {
    try {
      AuthResponse response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: pass,
      );
      print(response);
    } on AuthException catch (e) {
      print(e);
    }
  }
}
