import 'package:flutter/material.dart';
import 'package:moviles252/features/auth/ui/widgets/signup_content.dart';
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
  TextEditingController nameController = TextEditingController();

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
        child: SignupContent(
          emailController: emailController,
          passwordController: passwordController,
          nameController: nameController,
        ),
      ),
    );
  }
}
