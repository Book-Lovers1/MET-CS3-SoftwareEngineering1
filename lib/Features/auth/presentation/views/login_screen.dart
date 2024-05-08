//import 'dart:js_interop';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_button.dart';
import 'widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email;
  late String _password, password2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: SafeArea(
          child: Column(
            children: [
              const CustomAppBarr(),
              const SizedBox(height: 150),
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                onChanged: (data) {
                  _email = data;
                },
                hintText: 'Email',
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                onChanged: (data) {
                  _password = data;
                },
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                      text: 'LOGIN',
                      textColor: Colors.white,
                      backgroundColor: const Color(0xffEF8262),
                      onPressed: () {
                        signInWithEmailAndPassword(_email, _password, context);
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: 'REGISTER NOW',
                    textColor: Colors.white,
                    backgroundColor: const Color(0xffEF8262),
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.kRegisterPage);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class CustomAppBarr extends StatelessWidget {
  const CustomAppBarr({super.key});
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 40, bottom: 15),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Book-Lovers',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> signInWithEmailAndPassword(
    String email, String password, BuildContext context) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Messgae'),
          content: const Text('Signed in successfully!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                GoRouter.of(context).push(AppRouter.kHomeView);
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  } catch (e) {
    // Handle errors or display error message to the user
    print('Failed to sign in: $e');
    // Show error message in AlertDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to sign in: $e'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
