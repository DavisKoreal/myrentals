// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_rentals/const/constant.dart';
import 'package:my_rentals/model/search_results.dart';
import 'package:my_rentals/services/database_service.dart';

class RemoveEditScreen extends StatefulWidget {
  const RemoveEditScreen({super.key});

  @override
  State<RemoveEditScreen> createState() => _RemoveEditScreenState();
}

class _RemoveEditScreenState extends State<RemoveEditScreen> {


  final DatabaseService _databaseService = DatabaseService.instance;
  List<SearchResults> searchVector = [];
  List<SearchResults> nameListSearch = [];
  bool gotIt = false;
  // bool searchVectorPopulated = false;

  // List<String> foodList =[];
  final FocusNode _textFocusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void dispose() {
    _textFocusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _databaseService.getAllNamesAndKeysForSearch().then((List<SearchResults> value) =>
    {
      setState(() {
        searchVector = value;
      }),
      // searchVectorPopulated = true,
    }
    );

    if (gotIt == false){
      return Scaffold(
        appBar: AppBar(title: const Text("Remove/Edit")),
        // body: const Text("Testin"),
        body: AlertDialog(
          title: const Text('Edit or remove tenant'),
          content: const Text('To delete, long press on a tenants name. To edit tenant details, tap on the tenants name '),
          actions: <Widget>[

            TextButton(
              child: const Text('Got it'),
              onPressed: () {
                setState(() {
                  gotIt = true;
                });
                // Navigator.of(context).pop(); // Close the dialog
                // Navigator.pushNamed(context, '/update_tenant_details');
              },
            ),
          ],
        ),
      );
    }

      return Scaffold(
          appBar: AppBar(
              backgroundColor: backgroundColor,
              title: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  labelText: 'Search by tenant Name',
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

                onChanged: (value) {
                  setState(() {
                    nameListSearch = searchVector
                        .where((element) =>
                        element.tenantName.toLowerCase().contains(
                            value.toLowerCase()))
                        .toList();
                    // if (_textEditingController.text.isNotEmpty && nameListSearch.isEmpty) {
                    //   if (kDebugMode) {
                    //     print('foodListSearch length ${nameListSearch.length}');
                    //   }
                    // }
                  });
                },
              )
          ),


          body: _textEditingController.text.isNotEmpty && nameListSearch.isEmpty
              ? const Center(
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search_off,
                      size: 160,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'No results found,\nPlease try different keyword',
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          )
              : ListView.builder(
              itemCount: _textEditingController.text.isNotEmpty
                  ? nameListSearch.length
                  : searchVector.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  // child: Row(
                  //   children: [
                  //     const CircleAvatar(
                  //       child: Icon(Icons.food_bank),
                  //     ),
                  //     const SizedBox(
                  //       width: 10,
                  //     ),
                  //     Text(_textEditingController.text.isNotEmpty
                  //         ? nameListSearch[index].tenantName
                  //         : searchVector[index].tenantName),
                  //   ],
                  // ),
                  child: ListTile(
                    hoverColor: Colors.greenAccent,
                    leading: const Icon(Icons.person),
                    title: Text(_textEditingController.text.isNotEmpty
                        ? nameListSearch[index].tenantName
                        : searchVector[index].tenantName),
                    subtitle: Text(_textEditingController.text.isNotEmpty
                        ? nameListSearch[index].houseId
                        : searchVector[index].houseId),

                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Delete tenant from system'),
                            content: const Text(
                                'Are you sure you want to remove this tenant details'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Yes'),
                                onPressed: () {
                                  String houseId = _textEditingController.text
                                      .isNotEmpty ? nameListSearch[index]
                                      .houseId : searchVector[index].houseId;
                                  _databaseService.deleteRow(houseId);
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                              ),

                              TextButton(
                                child: const Text('No'),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },

                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Edit details of a tenant'),
                            content: const Text(
                                'Do you want to edit the details of this tenant? '),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('No'),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                              ),
                              TextButton(
                                child: const Text('Yes'),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                  Navigator.pushNamed(context, '/update_tenant_details');
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },


                  ),
                );
              }
          )
      );
  }
}