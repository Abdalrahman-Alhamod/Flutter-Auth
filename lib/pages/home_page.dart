import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const id = 'HomePage';
  void signOutUser() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: signOutUser, icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(child: Text('Successfully logged in!')),
    );
  }
}
