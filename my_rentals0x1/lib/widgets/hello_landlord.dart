import 'package:flutter/material.dart';
// import 'package:my_rentals/const/constant.dart';

class HelloLandlordWidget extends StatelessWidget {
  const HelloLandlordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        // color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Hello Landlord',
        style: TextStyle(
          color: Colors.greenAccent,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}