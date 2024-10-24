import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_rentals/const/constant.dart';

class SignOut extends StatelessWidget {
  const SignOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        title: const Text('Sign Out', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.logout,
                size: 100,
                color: Colors.greenAccent,
              ),
              const SizedBox(height: 30),
              const Text(
                'Are you sure you want to sign out?',
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                child: const Text('Sign Out'),
                //),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),
              // TextButton(
              //   child: const Text('Cancel', style: TextStyle(color: Colors.greenAccent)),
              //   onPressed: () {
              //     // Handle cancel
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
