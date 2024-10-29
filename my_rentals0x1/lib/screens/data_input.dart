// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_excel/excel.dart';
import 'package:my_rentals/const/constant.dart';
import 'package:my_rentals/model/house_model.dart';
import 'package:my_rentals/services/database_service.dart';

class DataInputPage extends StatefulWidget {
  const DataInputPage({super.key});

  @override
  State<DataInputPage> createState() => _DataInputPageState();
}

class _DataInputPageState extends State<DataInputPage> {
  static final DatabaseService _databaseService = DatabaseService.instance;
  final _rentPaidOptionsList = ["No", "Yes"];
  String? _selectedVal = "";

  _DataInputPageState(){
    _selectedVal = _rentPaidOptionsList[0];
  }

  final tenantNameController=TextEditingController();
  final tenantContactController = TextEditingController();
  final tenantHouseNumber = TextEditingController();
  final tenantRentPayable = TextEditingController();
  final buildingController = TextEditingController();

  // List<House> excelHouses = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text('Add House Data', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Enter House Details into system',
                      style: TextStyle(color: Colors.greenAccent, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
               const SizedBox(height: 20),
                TextField(
                  controller: tenantNameController,
                  decoration: const InputDecoration(
                    labelText: 'Enter tenant name',
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
                const SizedBox(height: 20),
            TextField(
              controller: tenantContactController,
                  decoration: const InputDecoration(
                  labelText: 'Enter tenant contact',
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
                const SizedBox(height: 20),
                TextField(
                 controller: tenantHouseNumber,
                  decoration: const InputDecoration(
                    labelText: 'What is the house number?',
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
                const SizedBox(height: 16),
                TextField(
                  controller: tenantRentPayable,
                  decoration: const InputDecoration(
                    labelText: 'Rent Payable for this house',
                    labelStyle: TextStyle(color: Colors.white70),
                    prefixText: 'Ksh ',
                    prefixStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: buildingController,
                  decoration: const InputDecoration(
                    labelText: 'Which building is this house located?',
                    labelStyle: TextStyle(color: Colors.white70),
                    prefixStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: Colors.white),
                ),

                const SizedBox(height:16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                      value: _selectedVal,
                      items: _rentPaidOptionsList.map(
                              (e) => DropdownMenuItem(value: e,child: Text(e),)).toList(),
                      onChanged: (val){
                        setState(() {
                          _selectedVal = val as String;
                        });
                      },
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.greenAccent,
                      size: 23,
                    ),
                    dropdownColor: backgroundColor,
                    decoration: const InputDecoration(
                      labelText: 'Has the tenant paid rent?',
                      labelStyle: TextStyle(color: Colors.white70),
                      prefixStyle: TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.greenAccent),
                      ),
                    ),

                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      onPressed: () {
                        //Handle form submission
                            int housePaid = 0;
                            if (_selectedVal == "Yes"){
                              housePaid = 1;
                            }
                            House house = House(
                              houseId: (buildingController.text + tenantHouseNumber.text),
                              houseAccNo: tenantHouseNumber.text,
                              building: buildingController.text,
                              rentPayable: tenantRentPayable.text,
                              tenantContact: tenantContactController.text,
                              tenantName: tenantNameController.text,
                              housePaidStatus: housePaid,
                            );
                            tenantHouseNumber.clear();
                            buildingController.clear();
                            tenantRentPayable.clear();
                            tenantContactController.clear();
                            tenantContactController.clear();
                            tenantNameController.clear();
            
            
                            _databaseService.addHouse(house);
                        //print("This has been pressed");
                      },
                      child: const Text('Submit details', style: TextStyle(color: Colors.black),),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      onPressed: () {
                        // Handle adding another house
                        _databaseService.deleteAllHouses();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Success'),
                              content: const Text('All houses in the local database have been erased successfully '),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Back'),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Delete all House data', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),



      // floatingActionButton: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.end,
        // children: [
          // FloatingActionButton.extended(
          //   onPressed: () async {
          //     // Handle importing data from spreadsheet
          //     final result = await FilePicker.platform.pickFiles(
          //       type: FileType.custom,
          //       allowedExtensions: ['xlsx', 'xls'],
          //       dialogTitle: "Pick an excel file",
          //     );
          //     // print(result);
          //
          //     if (result == null){
          //       return;
          //     }
          //     final file = result.files.first;
          //     // print('NAME OF THE FILE IS ${file.name}');
          //     // print("PATH OF THE FILE IS ${file.path}");
          //     // print("SIZE of the file is ${file.size}");
          //
          //     var bytes = File(file.path!).readAsBytesSync();
          //     var excel = Excel.decodeBytes(bytes);
          //
          //     for (var table in excel.tables.keys) {//sheet Name
          //       // print(excel.tables[table]?.maxCols);
          //       // print("TABLE LENGHT ${table.length}");
          //       // print(excel.tables[table]?.maxRows);
          //       var tableData = excel.tables[table];
          //       if (tableData != null) {
          //         for (int i = 1; i < tableData.rows.length; i++) {
          //         // for (var row in tableData.rows) {
          //         //   for(int i =0; i < row.length;i++){
          //         //     print("ROW $i : value: ${row[i]?.value} type: ${row[i]?.value.runtimeType}");
          //         //   }
          //           List<Data?> row = tableData.rows[i];
          //
          //           //print('name : ${row[0]?.value} contact: ${row[1]?.value}');
          //           //print("ROW NUMBER $i");
          //           House additional = House(
          //             houseId: row[4]?.value + row[2]?.value,
          //             tenantName: row[0]?.value,
          //             tenantContact: row[1]!.value.toString(),
          //             houseAccNo: row[2]?.value,
          //             rentPayable: row[3]!.value.toString(),
          //             building: row[4]?.value,
          //             housePaidStatus: 0,
          //           );
          //           //print("ADDITIONAL ${additional.tenantName}");
          //           _databaseService.addHouse(additional);
          //
          //
          //           // print("TYPE OF ROW IS ${row.runtimeType}\n\n\n");
          //         }
          //         if (!context.mounted) return;
          //
          //         showDialog(
          //           context: context,
          //           builder: (BuildContext context) {
          //             return AlertDialog(
          //               title: const Text('Success'),
          //               content: const Text('Import has been successful'),
          //               actions: <Widget>[
          //                 TextButton(
          //                   child: const Text('OK'),
          //                   onPressed: () {
          //                     Navigator.of(context).pop(); // Close the dialog
          //                   },
          //                 ),
          //               ],
          //             );
          //           },
          //         );
          //
          //       }
          //     }
          //   },
          //   backgroundColor: Colors.greenAccent,
          //   icon: const Icon(Icons.upload, color: Colors.black,),
          //   label: const Text('Import from Spreadsheet', style: TextStyle(color: Colors.black)),
          // ),
          // const SizedBox(height: 16),
          // FloatingActionButton.extended(
          //   onPressed: () {
          //     // Handle adding another house
          //     // _databaseService.deleteAllHouses();
          //   },
          //   icon: const Icon(Icons.cloud, color: Colors.black),
          //   label: const Text('Import from Google Sheet', style: TextStyle(color: Colors.black)),
          //   backgroundColor: Colors.greenAccent,
          // ),
          // const SizedBox(height: 16),
          // FloatingActionButton.extended(
          //   onPressed: () {
          //     // Handle adding another house
          //     _databaseService.deleteAllHouses();
          //     showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return AlertDialog(
          //           title: const Text('Success'),
          //           content: const Text('All houses in the local database have been erased successfully '),
          //           actions: <Widget>[
          //             TextButton(
          //               child: const Text('Back'),
          //               onPressed: () {
          //                 Navigator.of(context).pop(); // Close the dialog
          //               },
          //             ),
          //           ],
          //         );
          //       },
          //     );
          //   },
          //   icon: const Icon(Icons.delete, color: Colors.black),
          //   label: const Text('Delete all House data', style: TextStyle(color: Colors.black)),
          //   backgroundColor: Colors.greenAccent,
          // ),
        // ],
      // ),
    );
  }
}
