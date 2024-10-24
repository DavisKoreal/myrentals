import 'package:flutter/material.dart';
import 'package:my_rentals/const/constant.dart';
// import 'package:my_rentals/model/house_model.dart';
// import 'package:my_rentals/model/message_model.dart';
import 'package:my_rentals/model/paid_house.dart';
import 'package:my_rentals/services/database_service.dart';
// import 'package:my_rentals/services/send_message.dart';

class UnpaidHousesScreen extends StatefulWidget {
  const UnpaidHousesScreen({super.key});

  @override
  State<UnpaidHousesScreen> createState() => _UnpaidHousesScreenState();
}

class _UnpaidHousesScreenState extends State<UnpaidHousesScreen> {

  static final DatabaseService _databaseService = DatabaseService.instance;
  String numberOfMessages = "...";
  List<String> allContactNumbers = [];
  // final Future <List<House>> _housesList = _databaseService.getHouses();
  @override
  Widget build(BuildContext context) {

    _databaseService.totalUnPaidHouses().then((String value) => {
      setState(() {
        numberOfMessages = value;
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
        title: const Text('UnpaidHouses', style: TextStyle(color: Colors.white)),
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
                    'Total Unpaid Houses',
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
                  future: _databaseService.getAllUnPaidHouses(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,  // Replace with actual message count
                      itemBuilder: (context, index) {
                        PaidHouse paidHouse = snapshot.data![index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[800],
                            child: const Icon(Icons.person, color: Colors.white),
                          ),
                          title: Text(
                            paidHouse.tenantName,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            'Building: ${paidHouse.buildingName} House: ${paidHouse.houseNumber} ',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54),
                          onTap: () {
                            // Handle tap on message
                            AlertDialog(
                                title: const Center(child: Text('Status Update')),
                                content: Text('''
                              ${paidHouse.tenantName} of Building: ${paidHouse.buildingName} House: ${paidHouse.houseNumber} has not paid their full rent
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
    );
  }
}
