import 'package:drony/Screens/ChatScreen.dart';
import 'package:drony/Screens/Settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'Screens/About.dart';
import 'Screens/MainScreen.dart';
import 'Screens/MapScreen.dart';
import 'Screens/Team.dart';
import 'Screens/UserScreen.dart';
import 'Screens/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Screens/LoginScreen.dart';
import 'Screens/RegistrationScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        MapScreen.id: (context) => MapScreen(),
        MainScreen.id: (context) => MainScreen(),
        Settings.id: (context) => Settings(),
        UserScreen.id: (context) => UserScreen(),
        Team.id: (context) => Team(),
        About.id: (context) => About(),
      },
    );
  }
}
