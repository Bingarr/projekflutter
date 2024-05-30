import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashgrab/constants/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trashgrab/providers/activty_provider.dart';
import 'package:trashgrab/providers/auth_provider.dart';
import 'package:trashgrab/providers/bookmark_provider.dart';
import 'package:trashgrab/providers/staff_provider.dart';
import 'package:trashgrab/providers/transaction_provider.dart';
import 'package:trashgrab/providers/type_provider.dart';
import 'package:trashgrab/screens/base_screen.dart';
import 'package:trashgrab/screens/welcome_screen.dart';
import 'package:trashgrab/utils/function.dart';

class LoginChecker extends StatelessWidget {
  const LoginChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
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
            encapFunction(() {
              context.read<MyAuthProvider>().initRefresh();
              context.read<ActivityProvider>().initRefresh();
              context.read<TypeProvider>().initRefresh();
              context.read<TransactionProvider>().initRefresh();
              context.read<StaffProvider>().initRefresh();
              context.read<BookmarkProvider>().initRefresh();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const BaseScreen()),
              );
            });
          } else {
            encapFunction(() {
              context.read<MyAuthProvider>().initRefresh();
              context.read<ActivityProvider>().initRefresh();
              context.read<TypeProvider>().initRefresh();
              context.read<TransactionProvider>().initRefresh();
              context.read<StaffProvider>().initRefresh();
              context.read<BookmarkProvider>().initRefresh();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const WelcomeScreen()),
              );
            });
          }
      
          return const SizedBox();
        },
      ),
    );
  }
}
