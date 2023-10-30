import 'package:auth/components/custome_button.dart';
import 'package:auth/components/custome_text_field.dart';
import 'package:auth/components/square_tile.dart';
import 'package:auth/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  static const id = 'LoginPage';
  final userEmailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void signInUser() {}
    void forgotPassword() {}
    void signInWithGoogle() {}
    void signInWithFacebook() {}
    void registerUserPage() {
      Navigator.pushNamed(context, RegisterPage.id);
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                // Welcome message
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Welcome back, you have been missed!',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold),
                ),

                // user email textfield
                const SizedBox(
                  height: 25,
                ),
                CustomeTextField(
                  controller: userEmailController,
                  obscureText: false,
                  hintText: 'Email',
                ),

                // password textfield
                const SizedBox(
                  height: 10,
                ),
                CustomeTextField(
                  controller: passwordController,
                  obscureText: true,
                  hintText: 'Password',
                ),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: forgotPassword,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700),
                        ),
                      ),
                    ],
                  ),
                ),

                // sign in button
                const SizedBox(
                  height: 8,
                ),
                CustomeButton(title: 'Sign in', onTap: signInUser),

                // or continue with
                const SizedBox(
                  height: 30,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Or Continue with',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),

                // google + facebook sign in button
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                        onTap: signInWithGoogle,
                        imagePath: 'assets/images/google.png'),
                    const SizedBox(
                      width: 20,
                    ),
                    SquareTile(
                        onTap: signInWithFacebook,
                        imagePath: 'assets/images/facebook.png')
                  ],
                ),

                // not a member> register now
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member? ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700),
                    ),
                    GestureDetector(
                      onTap: registerUserPage,
                      child: Text(
                        'Register now',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade600),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}