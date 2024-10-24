import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:my_rentals/screens/log_in_page.dart';
import 'package:my_rentals/screens/login_or_register_page.dart';
import 'package:my_rentals/screens/main_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.hasData){
            return const MainScreen();
          }
          else{
            return const LoginOrRegisterPage();
          }
        }
      ),
    );
  }
}
