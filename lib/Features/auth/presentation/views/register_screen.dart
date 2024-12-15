// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_button.dart';
import 'widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                const CustomAppBarr(showUserName: false),
                const SizedBox(height: 150),
                const Text(
                  'Welcome',
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
                const SizedBox(height: 20),
                CustomTextFormField(
                  onChanged: (data) {
                    _password = data;
                  },
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  onChanged: (data) {
                    password2 = data;
                  },
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: 'REGISTER',
                    textColor: Colors.white,
                    backgroundColor: const Color(0xffEF8262),
                    onPressed: () {
                      registerWithEmailAndPassword(
                          _email, _password, password2, context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAppBarr extends StatelessWidget {
  const CustomAppBarr(
      {super.key, this.userName = 'User', required this.showUserName});
  final String userName;
  final bool showUserName;
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

Future<void> registerWithEmailAndPassword(String email, String password,
    String confirmPassword, BuildContext context) async {
  try {
    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Passwords do not match.'),
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
      return;
    }

    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Registered successfully! \nLogin now!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                GoRouter.of(context).push(AppRouter.kLoginPage);
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  } catch (e) {
    print('Failed to register: $e');
    // Show error message in AlertDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to register: $e'),
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
