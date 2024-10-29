// import material.dart

import 'package:flutter/material.dart';
import 'package:my_rentals/services/configuration_database.dart';

class EditAutomaticDaysPage extends StatefulWidget {
  const EditAutomaticDaysPage({super.key});

  @override
  State<EditAutomaticDaysPage> createState() => _EditAutomaticDaysPageState();
}

class _EditAutomaticDaysPageState extends State<EditAutomaticDaysPage> {

  final ConfigurationsDatabaseService _configurationsDatabaseService = ConfigurationsDatabaseService.instance;
  List<int> selectedDays = [];
  String selectedDaysString = '...';
  //create a string of all integers in the list selectedlist

  //initState function
  @override
  void initState() {
    super.initState();
    _configurationsDatabaseService.getAutomaticDays().then((String value) =>
    {
      setState(() {
        selectedDaysString = value;
        //convert a string of the form [1,2,3] to a list of integers [1,2,3]
        selectedDays = value.substring(1, value.length-1).split(',').map((e) => int.parse(e)).toList();
      }),
    }
    );
  }

  

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Selected days are',
                    style: TextStyle(color: Colors.white70, fontSize: 19),
                  ),
                  Text(
                    selectedDaysString,  // Replace with actual count
                    style: const TextStyle(color: Colors.greenAccent, fontSize: 20, fontWeight: FontWeight.bold),
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

                bool contains = selectedDays.contains(index + 1);

                if(contains){
                  setState(() {
                    selectedDays.remove(index + 1);
                    selectedDaysString = selectedDays.toString();
                  });
                }

                if(contains == false){
                  setState(() {
                    selectedDays.add(index + 1);
                    selectedDaysString = selectedDays.toString();
                  });
                }

                // setState(() {
                //   if (selectedDays.contains(index + 1)) {
                //     selectedDays.remove(index + 1);
                //     //remove from selectedDaysString
                //     // selectedDaysString = selectedDays.toString();
                //   } 
                //   else if (selectedDays.contains(index + 1) == false) {
                //     selectedDays.add(index + 1);
                //     //add to selectedDaysString
                //     // selectedDaysString = selectedDays.toString();
                //   }
                // });
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
                              content: Text(
                                "The following dates will be set as automatic dates: ${selectedDays.toString()}. \nAutomatic days are days that your clients are sent reminders to pay their rent."),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('No, let me continue editing'),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                ),

                                TextButton(
                                  child: const Text('Yes, submit these dates'),
                                  onPressed: () {
                                    _configurationsDatabaseService.insertAutomaticDays("0");
                                    _configurationsDatabaseService.updateAutomaticDays(selectedDays.toString());
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Confirm new automatic dates', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ),

                const SizedBox(height: 10.0,),

          ],
        ),
      ),
    );
  }

}