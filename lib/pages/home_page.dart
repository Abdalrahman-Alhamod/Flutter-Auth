import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.userEmail});
  static const id = 'HomePage';

  //final user = FirebaseAuth.instance.currentUser;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    void signOutUser() {
      //FirebaseAuth.instance.signOut();
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
