import 'package:flutter/material.dart';
import 'package:trashgrab/constants/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trashgrab/screens/base_screen.dart';
import 'package:trashgrab/screens/welcome_page.dart';

class LoginChecker extends StatelessWidget {
  const LoginChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        }
        if (snapshot.hasData) {
          return const BaseScreen();
        }
        return const WelcomePage();
      },
    );
  }
}
