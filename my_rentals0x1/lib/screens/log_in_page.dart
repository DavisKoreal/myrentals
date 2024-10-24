import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_rentals/const/constant.dart';

class LogInPage extends StatefulWidget {
  final Function()? onTap;
  const LogInPage({super.key, required this.onTap});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  final emailController=TextEditingController();
  final passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Icon(
                  Icons.lock,
                  size: 70,
                  color: Colors.greenAccent,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text("LOG IN PAGE",
                  style: TextStyle(
                    fontSize: 20,
                    wordSpacing: 5,
                    fontWeight: FontWeight.w400,
            
                  ),
                ),
                const SizedBox(height: 50,),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20,),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      onPressed: (
                          ) async {
                        showDialog(context: context, builder: (context){
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.greenAccent,
                            ),
                          );
                        },);
                        try
                        {
                          await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                        }
                        on FirebaseAuthException catch(e){
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Log in Unsuccessful'),
                                content: const Text('Please try again'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                          // print("EMAIL IS ${emailController.text}");
                          // print("PASSWORD IS ${passwordController.text}");
                          // print("LIWRUFWRILUFHW;ROFIJW;FOIJWRFOLWRIFJWILRUFHWLFH");
                          emailController.clear();
                          passwordController.clear();
                          Navigator.of(context).pop();
                      },
                      child: const Text('Log in ', style: TextStyle(color: Colors.black),),
                    ),
                  ),
                ),
                const SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const Text(
                    'Do not have an account?',
                    style: TextStyle(color: Colors.white70, fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Sign up', style: TextStyle(color: Colors.greenAccent, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],

                ),
            
              ],
            
            ),
          ),
        ),
      ),

    );
  }
}
