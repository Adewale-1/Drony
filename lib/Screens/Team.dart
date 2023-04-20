import 'package:flutter/material.dart';

class Team extends StatefulWidget {
  static const String id = 'team';

  @override
  State<Team> createState() => _TeamState();
}

class _TeamState extends State<Team> {
  final List<Map<String, String>> teamMembers = [
    {
      'name': 'Adewale Adenle',
      'major': 'Computer Science and Engineering',
      'email': 'adenle.4@osu.edu',
      'image': 'lib/Assets/images/20501871.jpg',
    },
    {
      'name': 'Ethan Segrue',
      'major': 'Aerospace Engineering',
      'email': 'segrue.3@osu.edu',
      'image': 'lib/Assets/images/spongebob.webp',
    },
    {
      'name': 'Daniel Dawit',
      'major': 'Computer Science and Engineering',
      'email': 'dawit.6@osu.edu',
      'image': 'lib/Assets/images/patrick.png',
    },
    {
      'name': 'Alec Testa',
      'major': 'Industrial and Systems Engineering',
      'email': 'actesta487@gmail.com',
      'image': 'lib/Assets/images/squidward.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Team'),
        backgroundColor: Colors.blue.shade300,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: teamMembers.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: 24),
                  CircleAvatar(
                    radius: 120,
                    child: Text(teamMembers[index]['name'][0]),
                    backgroundImage: AssetImage(teamMembers[index]['image']),
                  ),
                  SizedBox(height: 24),
                  ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          teamMembers[index]['name'],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          teamMembers[index]['major'],
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          teamMembers[index]['email'],
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
