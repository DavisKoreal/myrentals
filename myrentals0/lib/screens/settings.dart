import 'package:flutter/material.dart';
import 'package:my_rentals/const/constant.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.person, color: Colors.greenAccent),
              title: const Text('Account', style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54),
              onTap: () {
                // Navigate to account settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.greenAccent),
              title: const Text('Notifications', style: TextStyle(color: Colors.white)),
              trailing: Switch(
                value: true,  // Replace with actual value
                onChanged: (bool value) {
                  // Handle notification toggle
                },
                activeColor: Colors.greenAccent,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.greenAccent),
              title: const Text('Privacy', style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54),
              onTap: () {
                // Navigate to privacy settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.language, color: Colors.greenAccent),
              title: const Text('Language', style: TextStyle(color: Colors.white)),
              trailing: const Text('English', style: TextStyle(color: Colors.white54)),
              onTap: () {
                // Open language selection
              },
            ),
            ListTile(
              leading: const Icon(Icons.help, color: Colors.greenAccent),
              title: const Text('Help & Support', style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54),
              onTap: () {
                // Navigate to help and support
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.greenAccent),
              title: const Text('About', style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54),
              onTap: () {
                // Navigate to about page
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                child: const Text('Sign Out'),
                onPressed: () {
                  // Handle sign out
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
