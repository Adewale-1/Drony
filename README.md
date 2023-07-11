# Drony: A Medication Delivery Application

This repository contains the source code of Drony. The application is designed to revolutionize the medication delivery process by using drones. It provides users with the ability to track the estimated time of arrival, monitor the live location of the drone, and access timely customer support.

## Code Structure

The code for the application is structured around several screens, all of which are imported in the `main.dart` file. These screens include the chat screen, settings, about page, main screen, map screen, team page, user screen, and welcome screen.

```dart
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
```

The `main` function initializes the Firebase app and runs the `MyApp` widget.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

The `MyApp` widget is a stateless widget that returns a `MaterialApp` widget. The `MaterialApp` widget includes a theme, an initial route, and a map of the various routes in the application.

```dart
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
```

```dart
class About extends StatefulWidget {
  static const String id = 'about';

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: Text('About Team'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //...
          ],
        ),
      ),
    );
  }
}
```

## Images

![Homepage(/ReadmeImages/1.png)
![Registration(/ReadmeImages/2.png)
![Maps(/ReadmeImages/3.png)
![Chat(/ReadmeImages/4.png)
![Settings(/ReadmeImages/5.png)
![User Profile(/ReadmeImages/6.png)
![Team(/ReadmeImages/7.png)
![About Team(/ReadmeImages/8.png)

## Contributing

Contributions to this project are welcome. Feel free to open an issue or submit a pull request.

## Dependencies

The project has the following dependencies:

```yaml
flutter:
  sdk: flutter

cupertino_icons: ^1.0.2
animated_text_kit: ^4.2.2
firebase_core: ^2.9.0
firebase_auth: ^4.4.0
google_nav_bar: ^5.0.6
flutter_map: ^3.1.0
geocoding: ^2.1.0
geolocator: ^9.0.2
latlng: ^0.2.1
async: ^2.10.0
dio: ^5.1.1
google_maps_flutter: ^2.2.5
flutter_google_places: ^0.3.0
cloud_firestore: ^4.5.1
google_maps_webservice: ^0.0.19
http: ^0.13.5
sqflite: ^2.2.6
path_provider: ^2.0.14
flutter_polyline_points: ^1.0.0
location: ^4.4.0
web_socket_channel: ^2.4.0
```

These dependencies can be installed by running the command `flutter pub get`.
