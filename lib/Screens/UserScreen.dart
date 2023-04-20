import 'package:flutter/material.dart';

import 'globals.dart';

class UserScreen extends StatefulWidget {
  static const String id = 'user_screen';

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Colors.blue.shade300,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 130,
              backgroundImage: AssetImage('lib/Assets/images/20501871.jpg'),
            ),
            SizedBox(height: 10),
            Text(
              GlobalData.username ?? '',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              GlobalData.email,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                'Password',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              subtitle: Text(
                _obscureText ? '********' : GlobalData.password,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              trailing: IconButton(
                color: Colors.black,
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
