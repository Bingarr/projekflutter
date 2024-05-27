import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:trashgrab/login_checker.dart';
import 'package:flutter/material.dart';
import 'package:trashgrab/providers/activty_provider.dart';
import 'package:trashgrab/providers/auth_provider.dart';
import 'package:trashgrab/providers/base_provider.dart';
import 'package:trashgrab/providers/bookmark_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trashgrab/providers/staff_provider.dart';
import 'package:trashgrab/providers/transaction_provider.dart';
import 'package:trashgrab/providers/type_provider.dart';
import 'package:trashgrab/utils/hive/adapter/role_hive.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting('id');

  await Hive.initFlutter();
  Hive.registerAdapter(RoleHiveAdapter());
  await Hive.openBox('role');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MyAuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BaseProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookmarkProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ActivityProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => StaffProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TypeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trash Grab',
      localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      locale: const Locale('id'),
      supportedLocales: const [Locale('id')],
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 21, 111, 24),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 21, 111, 24),
        ),
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          displayLarge: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 25,
            color: Colors.white,
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.black,
          ),
          displaySmall: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Colors.black,
          ),
          labelMedium: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      home: const LoginChecker(),
    );
  }
}
