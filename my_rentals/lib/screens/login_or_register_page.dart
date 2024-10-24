import 'package:flutter/material.dart';
import 'package:my_rentals/screens/log_in_page.dart';
import 'package:my_rentals/screens/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLoginPage = true;
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LogInPage(
        onTap: togglePages,
      );
    }
    else{
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
