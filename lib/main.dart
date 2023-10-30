import 'package:auth/pages/auth_page.dart';
import 'package:auth/pages/login_page.dart';
import 'package:auth/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Auth());
}

class Auth extends StatelessWidget {
  const Auth({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
      },
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
    );
  }
}
