import 'package:drony/Screens/ChatScreen.dart';
import 'package:drony/Screens/RegistrationScreen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'MainScreen.dart';
import 'database_helper.dart';
import 'globals.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  // const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  int _success = 1;
  String _userEmail = "";

  Future<void> _login() async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      if (user != null) {
        _userEmail = user.user.email;
        GlobalData.email = _emailController.text;
        GlobalData.password = _passwordController.text;
        final dbHelper = DatabaseHelper.instance;
        GlobalData.username = await dbHelper.getUsername(GlobalData.email);
        Navigator.pushNamed(context, MainScreen.id, arguments: {
          'email': _emailController.text,
          'password': _passwordController.text,
        });
        setState(() {
          _success = 2;
        });
      } else {
        setState(() {
          _success = 3;
        });
      }
    } catch (e) {
      setState(() {
        _success = 3;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      width: 250.0,
                      height: 300.0,
                      child: TextLiquidFill(
                        text: 'Drony',
                        waveColor: Colors.blueAccent,
                        boxBackgroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 48.0,
                ),
                TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: _passwordController,
                  style: TextStyle(color: Colors.black),
                  obscureText: true,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Enter your password.',
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    _success == 1
                        ? ''
                        : (_success == 2
                            ? 'Sign in Successful'
                            : 'Sign in Failed'),
                    style: TextStyle(
                      color: _success == 1 ? Colors.green : Colors.red,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                _success == 2
                    ? Text(
                        'Logged in successfully. $_userEmail',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green),
                      )
                    : _success == 3
                        ? const Text(
                            'Incorrect Email or Password!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red),
                          )
                        : Container(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
