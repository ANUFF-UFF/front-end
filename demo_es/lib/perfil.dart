import 'package:flutter/material.dart';
import 'package:demo_es/home.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PerfilPage extends StatelessWidget {
  Future<Map<String, dynamic>> fetchUserData() async {
    final response = await http.get(Uri.parse('https://example.com/api/user'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            final userData = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(userData['picture']), // Replace with user's picture URL
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Name: ${userData['name']}', style: TextStyle(fontSize: 18)),
                  Text('Email: ${userData['email']}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to edit profile page
                    },
                    child: Text('Edit Profile'),
                  ),
                  SizedBox(height: 16),
                  Text('Posts', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: userData['posts'].length, // Replace with the actual number of posts
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(userData['posts'][index]['title']),
                          subtitle: Text(userData['posts'][index]['content']),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Active Chats', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: userData['chats'].length, // Replace with the actual number of active chats
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(userData['chats'][index]['title']),
                          subtitle: Text(userData['chats'][index]['lastMessage']),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Return to the home page
                      },
                      child: Text('Return to Home Page'),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}