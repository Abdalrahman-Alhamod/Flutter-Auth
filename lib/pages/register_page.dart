import 'package:auth/components/custome_button.dart';
import 'package:auth/components/custome_text_field.dart';
import 'package:auth/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../helpers/show_snack_bar.dart';
import 'package:email_validator/email_validator.dart';

import '../services/api_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static const id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static String? email, password, confirmPassword;

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

  String? Function(String?) confirmPasswordValidator = (value) {
    if (value!.isEmpty) {
      return 'Field is required';
    } else if (password != confirmPassword) {
      debugPrint('Password : $password , Confirm Password : $confirmPassword');
      return 'Passwords don\'t match';
    } else {
      return null;
    }
  };

  @override
  Widget build(BuildContext context) {
    void registerUser() async {
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

          // await FirebaseAuth.instance.createUserWithEmailAndPassword(
          //     email: email!, password: password!);

          await ApiAuth().register(email: email!, password: password!);

          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
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

    void signInWithGoogle() {}
    void signInWithFacebook() {}
    void signInUserPage() {
      Navigator.pop(context);
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

                  // confirm password textfield
                  const SizedBox(
                    height: 10,
                  ),
                  CustomeTextField(
                    validator: confirmPasswordValidator,
                    obscureText: true,
                    hintText: 'Confirm Password',
                    onChanged: (text) {
                      confirmPassword = text;
                      formKey.currentState!.validate();
                    },
                    keyboardType: TextInputType.visiblePassword,
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
                        onTap: signInUserPage,
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
      ),
    );
  }
}
