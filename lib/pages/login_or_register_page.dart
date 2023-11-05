import 'package:auth/pages/login_page.dart';
import 'package:auth/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  // intially show login page
  bool showLoginPage = true;

  // toggle between login and register page
  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return const LoginPage(
        //registerUserPage: togglePage
      );
    } else {
      return const RegisterPage(
       // signInUserPage: togglePage,
      );
    }
  }
}
