import 'package:auth/components/custome_button.dart';
import 'package:auth/components/custome_text_field.dart';
import 'package:auth/components/square_tile.dart';
import 'package:auth/helpers/show_snack_bar.dart';
import 'package:auth/pages/home_page.dart';
import 'package:auth/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static String? email, password;

  final formKey = GlobalKey<FormState>();

  String? Function(String?) emailValidator = (value) {
    if (value!.isEmpty) {
      return 'Field is required';
    } else if (!EmailValidator.validate(email!)) {
      return 'Invalid Email';
    } else {
      return null;
    }
  };

  String? Function(String?) passwordValidator = (value) {
    if (value!.isEmpty) {
      return 'Field is required';
    } else if (value.length < 8) {
      return 'Password should be at least 8 characters';
    } else {
      return null;
    }
  };

  @override
  Widget build(BuildContext context) {
    void signInUser() async {
      try {
        if (formKey.currentState!.validate()) {
          // showing circular indicator
          showDialog(
            context: context,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );

          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email!, password: password!);

          // await ApiAuth().signIn(email: email!, password: password!);

          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, HomePage.id, arguments: email);
        }
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        debugPrint(e.toString());
        showSnackBar(context, e.code);
      } catch (e) {
        Navigator.pop(context);
        debugPrint(e.toString());
        showSnackBar(context, e.toString());
      }
    }

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
            child: Form(
              key: formKey,
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
                    validator: emailValidator,
                    obscureText: false,
                    hintText: 'Email',
                    onChanged: (text) {
                      email = text;
                      formKey.currentState!.validate();
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),

                  // password textfield
                  const SizedBox(
                    height: 10,
                  ),
                  CustomeTextField(
                    validator: passwordValidator,
                    obscureText: true,
                    hintText: 'Password',
                    onChanged: (text) {
                      password = text;
                      formKey.currentState!.validate();
                    },
                    keyboardType: TextInputType.visiblePassword,
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
      ),
    );
  }
}
