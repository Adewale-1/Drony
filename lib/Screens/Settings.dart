import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'About.dart';
import 'LoginScreen.dart';
import 'Team.dart';
import 'UserScreen.dart';

class Settings extends StatefulWidget {
  static const String id = 'settings';

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _logout() async {
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.id, (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Settings'),
        backgroundColor: Colors.blue.shade300,
        elevation: 1.0,
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(headline6: TextStyle(color: Colors.black)),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              ListTile(
                title: Text('Account',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                onTap: () {
                  Navigator.pushNamed(context, UserScreen.id);
                  // Navigate to User page
                },
              ),
              ListTile(
                title: Text('Team',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                onTap: () {
                  Navigator.pushNamed(context, Team.id);
                  // Navigate to Team page
                },
              ),
              ListTile(
                title: Text('About',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                onTap: () {
                  Navigator.pushNamed(context, About.id);
                  // Navigate to About page
                },
              ),
              // ListTile(
              //   title: Text('Inform',
              //       style: TextStyle(
              //           fontSize: 24,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.black)),
              //   onTap: () {
              //     // Navigate to Inform page
              //   },
              // ),
              ListTile(
                title: Text('Logout',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                onTap: _logout,
              ),
            ],
          ).toList(),
        ),
      ),
    );
  }
}
