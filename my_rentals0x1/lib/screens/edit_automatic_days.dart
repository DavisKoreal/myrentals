// import material.dart

import 'package:flutter/material.dart';

class EditAutomaticDaysPage extends StatefulWidget {
  const EditAutomaticDaysPage({super.key});

  @override
  State<EditAutomaticDaysPage> createState() => _EditAutomaticDaysPageState();
}

class _EditAutomaticDaysPageState extends State<EditAutomaticDaysPage> {

  List<int> selectedDays = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Automatic Days'),
      ),
      body: Center(
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     Text('Edit Automatic Days'),
        //   ],
        // ),
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Selected days are',
                    style: TextStyle(color: Colors.white70, fontSize: 19),
                  ),
                  Text(
                    "31, 30",  // Replace with actual count
                    style: TextStyle(color: Colors.greenAccent, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),


            Expanded(
              child:
            GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, // 2 columns
          ),
          itemCount: 31, // 12 items
          itemBuilder: (BuildContext context, int index) {
            return  
            GestureDetector(
              onTap: () {

                setState(() {
                  if (selectedDays.contains(index + 1)) {
                    selectedDays.remove(index + 1);
                  } else {
                    selectedDays.add(index + 1);
                  }
                });
                // selectedDays.add(index + 1);
                //show dialog that you touched index i
                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return AlertDialog(
                //       title: const Text('Edit Automatic Days'),
                //       content: Text('You have selected day ${index + 1}'),
                //       actions: <Widget>[
                //         TextButton(
                //           onPressed: () {
                //             Navigator.of(context).pop();
                //           },
                //           child: const Text('OK'),
                //         ),
                //       ],
                //     );
                //   },
                // );
              },
              child:Container(
              // color: Colors.primaries[index % Colors.primaries.length],
              // width: 10,
              // height: 15,
              // padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: selectedDays.contains(index+1)?Colors.greenAccent:Colors.black38,
                borderRadius: BorderRadius.circular(19),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              ),
            );
          },
          ),
          ),


          Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Submit Automatic Dates?'),
                              content: const Text('The following dates will be set as automatic dates: 31, 30'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('No, I want to edit again'),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                ),

                                TextButton(
                                  child: const Text('Yes, submit these dates'),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Submit automatic dates', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ),


          ],
        ),
      ),
    );
  }

}