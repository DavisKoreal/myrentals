import 'package:flutter/material.dart';
import 'package:my_rentals/const/constant.dart';

class WaterManagement extends StatelessWidget {
  const WaterManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text('Water Management', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30,),
              const Icon(
                Icons.water,
                size: 150,
                color: Colors.greenAccent,
              ),
              const SizedBox(height: 30),
              const Text(
                'Water Management',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'This feature is under construction',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              const Expanded(child: SizedBox()),  // Pushes the button to the bottom
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  onPressed: () {
                    // Handle feature request
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: backgroundColor,
                          title: const Text('Feature Request', style: TextStyle(color: Colors.white)),
                          content: const Text('Would you like to request another feature?', style: TextStyle(color: Colors.white70)),
                          actions: [
                            TextButton(
                              child: const Text('No', style: TextStyle(color: Colors.greenAccent)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Yes', style: TextStyle(color: Colors.greenAccent)),
                              onPressed: () {
                                // Handle 'Yes' action (e.g., navigate to feedback page)
                                Navigator.of(context).pop();
                                Navigator.pushNamed(context, "/feedback");
                                // Add navigation to feedback page here
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Request Another Feature',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}