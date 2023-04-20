import 'package:flutter/material.dart';

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
        title: Text('About Engineering Team M'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Engineering Team M',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              'Making Medication Magical',
              style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.black),
            ),
            SizedBox(height: 30),
            Text(
              'Context:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              'Engineering Team M is dedicated to making medication accessible for individuals by revolutionizing the delivery process. Our innovative solution involves using drones for medication delivery, ensuring a seamless and efficient experience for users. To enhance the user experience, we have developed a mobile application that allows users to track the estimated time of arrival, monitor the live location of the drone, and access timely customer support.',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 30),
            Text(
              'Technical Information:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              '- Materails: Recycled materails were used to reduce cost',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 7),
            Text(
              '- Microcontroller: An Raspberry Pi3 was employed to connect the drone to all other hardware components. The code was written entirely in Python.',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 7),
            Text(
              '- WiFi and GPS Module: The GPS module transmitted live location data to the WiFi module, which then sent the drone\'s longitude and latitude during flight to the mobile application via a Flask API.',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 7),
            Text(
              '- Firebase: Firebase served as the cloud server for storing user registration information, managing login authentication, and saving chat data using a unique identifier in the collection. ',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 7),
            Text(
              '- SQL: An SQL database was implemented to save the username during registration. Initially, a Map<String, String> was used, but it was later modified to SQL. The database retrieves the username using the email address provided during login.',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 7),
            Text(
              '- Google Maps: The Google Maps API was integrated to display the user\'s live location, draw markers, and plot polylines.',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 7),
            Text(
              '- Google Places: Google Places API was used for autocompletion, allowing users to obtain the full address of different locations within a specified jurisdiction.',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 20),
            Text(
              'Version 1.1',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              '@ 2023',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
