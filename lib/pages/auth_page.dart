import 'package:auth/pages/home_page.dart';
import 'package:auth/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});
  static const id = 'AuthPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          debugPrint(snapshot.data.toString());
          // if the user has logged in
          if (snapshot.hasData) {
            return const HomePage();
          }

          // if the user hasnt logged in
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
