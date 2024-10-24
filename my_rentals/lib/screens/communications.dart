import 'package:flutter/material.dart';
import 'package:my_rentals/const/constant.dart';
import 'package:my_rentals/model/house_model.dart';
import 'package:my_rentals/model/message_model.dart';
import 'package:my_rentals/services/database_service.dart';
import 'package:my_rentals/services/send_message.dart';

class Communications extends StatefulWidget {
  const Communications({super.key});

  @override
  State<Communications> createState() => _CommunicationsState();
}

class _CommunicationsState extends State<Communications> {

  static final DatabaseService _databaseService = DatabaseService.instance;
  String numberOfMessages = "...";
  List<String> allContactNumbers = [];
  // final Future <List<House>> _housesList = _databaseService.getHouses();
  @override
  Widget build(BuildContext context) {

    _databaseService.getHouseTableRowCount().then((int value) => {
      setState(() {
        numberOfMessages = value.toString();
      }
      )
    }
    );

    // _databaseService.getAllContactsInDatabase().then(
    //     (List<String> numbers) => {
    //       setState(() {
    //         allContactNumbers = numbers;
    //       })
    //     }
    // );

    return Scaffold(
      backgroundColor: backgroundColor,  // Dark background color
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        title: const Text('Communications', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Total messages widget
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Messages Sent',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  Text(
                    numberOfMessages,  // Replace with actual count
                    style: const TextStyle(color: Colors.greenAccent, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // Scrollable list of messages
            Expanded(
              child: FutureBuilder(
                future: _databaseService.getHouses(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,  // Replace with actual message count
                    itemBuilder: (context, index) {
                      House house = snapshot.data![index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[800],
                          child: const Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(
                          house.tenantName,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Message: Dear ${house.tenantName} Please pay ${house.rentPayable} by 3rd September',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54),
                        onTap: () {
                          // Handle tap on message
                          const AlertDialog(
                              title: Center(child: Text('Status Update')),
                              content: Text('''
                              You tapped a message
                            ''')
                          );
                        },
                      );
                    },
                  );
                }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Future<List<MessageModel>> allCommunications = _databaseService.getAllMessageModels();
          allCommunications.then((List<MessageModel> allMessageModels) =>
          {
            for(int i = 0; i < allMessageModels.length; i++)
            {
              // List<String> contactsToSendTo = [];
              sendMessage(allMessageModels[i].messageToSend, [allMessageModels[i].contactToSend])
            }
          }
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return AlertDialog(
              //   title: const Center(child: Text('Status Update')),
              //   content: const Text('''
              //   Dear valued client,
              //
              //   We are currently awaiting approval from Safaricom to be able to legally send automated messages to your tenants.
              //
              //   To ensure compliance with privacy laws, we are currently undergoing a vetting process by the communications authorities.
              //
              //   We apologise for any inconvenience caused for the meantime and assure you that this will not last long.
              //
              //   Sincerely.
              //
              //   '''),
              //   actions: <Widget>[
              //     TextButton(
              //       child: const Text('OK'),
              //       onPressed: () {
              //         Navigator.of(context).pop(); // Close the dialog
              //       },
              //     ),
              //   ],
              // );

              return const AlertDialog(
                title: Center(child: Text('Status Update')),
                  content: Text('''
                    Messages have been sent to all tenants with balances in the background
                  ''')
              );

            },
          );
        },
        icon: const Icon(Icons.send),
        label: const Text('Send a reminder to tenants'),
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.black,
      ),
    );
  }
}
