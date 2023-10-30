import 'package:auth/components/custome_button.dart';
import 'package:auth/components/custome_text_field.dart';
import 'package:auth/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helpers/show_snack_bar.dart';

class RegisterPage extends StatefulWidget {
  final void Function() signInUserPage;
  const RegisterPage({super.key, required this.signInUserPage});
  static const id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userEmailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void registerUser() async {
      // showing circular indicator
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      try {
        if (passwordController.text == confirmPasswordController.text) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: userEmailController.text,
              password: passwordController.text);
        } else {
          showSnackBar(context, 'Passwords don\'t match');
        }
      } on FirebaseAuthException catch (e) {
        debugPrint(e.toString());
        showSnackBar(context, e.code);
      } finally {
        //  pop circular indiactor
        Navigator.pop(context);
      }
    }

    void signInWithGoogle() {}
    void signInWithFacebook() {}
    // void signInUserPage() {
    //   Navigator.pop(context);
    // }

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
                  'Let\'s create an account for you!',
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

                // confirm password textfield
                const SizedBox(
                  height: 10,
                ),
                CustomeTextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  hintText: 'Confirm Password',
                ),

                // sign in button
                const SizedBox(
                  height: 20,
                ),
                CustomeButton(title: 'Sign Up', onTap: registerUser),

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
                      'Already have an account? ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700),
                    ),
                    GestureDetector(
                      onTap: widget.signInUserPage,
                      child: Text(
                        'Login now',
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
