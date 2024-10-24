import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_rentals/const/constant.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,  // Dark background color
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[800],
              child: const Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'User Name',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: ListTile(
                leading: const Icon(Icons.email, color: Colors.greenAccent),
                title: const Text('Email', style: TextStyle(color: Colors.white70)),
                subtitle: Text('${user.email}', style: const TextStyle(color: Colors.white)),
              ),
            ),
            const Center(
              child: ListTile(
                leading: Icon(Icons.phone, color: Colors.greenAccent),
                title: Text('Phone', style: TextStyle(color: Colors.white70)),
                subtitle: Text('+1 234 567 8900', style: TextStyle(color: Colors.white)),
              ),
            ),
            const Center(
              child: ListTile(
                leading: Icon(Icons.location_on, color: Colors.greenAccent),
                title: Text('Address', style: TextStyle(color: Colors.white70)),
                subtitle: Text('123 Main St, City, Country', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              child: const Text('Edit Profile'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
