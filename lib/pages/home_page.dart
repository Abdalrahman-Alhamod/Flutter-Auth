import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const id = 'HomePage';

  @override
  Widget build(BuildContext context) {
    final String userEmail =
        ModalRoute.of(context)!.settings.arguments as String;

    void signOutUser() {
      FirebaseAuth.instance.signOut();
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Container(),
        actions: [
          IconButton(onPressed: signOutUser, icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text("Logged in as : $userEmail"),
      ),
    );
  }
}
