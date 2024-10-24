import 'package:flutter/material.dart';
import 'package:my_rentals/const/constant.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text('Feedback & Suggestions', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Heyyy, Please give us any feedback or a feature request that you may have.  ',
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField('Your Name', 'Enter your name'),
              const SizedBox(height: 16),
              _buildTextField('Contact', 'Enter your contact number'),
              //const SizedBox(height: 16), I do not need a customer to take extra steps to give feedback
              //_buildDropdown(),
              const SizedBox(height: 16),
              _buildTextField('Feedback/Suggestion', 'Enter your feedback or suggestion', maxLines: 5),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    onPressed: () {
                      // Handle form submission
                    },
                    child: const Text('Submit', style: TextStyle(color: Colors.black),),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Thank you so much for taking your time. We really appreciate your input.',
                  style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: Colors.white70),
        hintStyle: const TextStyle(color: Colors.white30),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white30),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  // Widget _buildDropdown() {
  //   return DropdownButtonFormField<String>(
  //     decoration: const InputDecoration(
  //       labelText: 'Feedback Type',
  //       labelStyle: TextStyle(color: Colors.white70),
  //       enabledBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.white30),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.greenAccent),
  //       ),
  //     ),
  //     dropdownColor: Color(0xFF2A2A2A),
  //     style: TextStyle(color: Colors.white),
  //     items: ['General Feedback', 'Feature Request', 'Other']
  //         .map((String value) {
  //       return DropdownMenuItem<String>(
  //         value: value,
  //         child: Text(value),
  //       );
  //     }).toList(),
  //     onChanged: (String? newValue) {
  //       // Handle dropdown change
  //     },
  //   );
  // }
}