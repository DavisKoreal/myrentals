// import 'package:flutter/cupertino.dart';
// import 'package:flutter/widgets.dart';
import 'package:my_rentals/data/health_details.dart';
import 'package:my_rentals/model/health_model.dart';
// import 'package:my_rentals/model/paid_house.dart';
import 'package:my_rentals/services/database_service.dart';
// import 'package:my_rentals/util/responsive.dart';
import 'package:my_rentals/widgets/custom_card_widget.dart';
import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:my_rentals/services/database_service.dart';

class ActivityDetailsCard extends StatefulWidget {
  const ActivityDetailsCard({super.key});

  @override
  State<ActivityDetailsCard> createState() => _ActivityDetailsCardState();
}

class _ActivityDetailsCardState extends State<ActivityDetailsCard> {

  // DatabaseService databaseService = DatabaseService.instance;
  // HealthDetails healthDetails = HealthDetails();
  //
  //  setNewValues() async {
  //   Future<String> paidHousesFutureString = databaseService.getHouseTableRowCount();
  //   String paidHousesString = "";
  //   await paidHousesFutureString.then((String result) => {
  //     // print("NEW VALUE CHECKING $result and the set new values function has been called"),
  //     paidHousesString = result,
  //     // print("HEALTH DETAILS CHECKING after new value checking : ${healthDetails.healthData[0].value}"),
  //   },
  //   );
  //   //setState(() {
  //   //healthDetails.healthData[0].value = paidHousesString;
  //   //});
  // }
  HealthDetails healthDetails = HealthDetails();

  @override
  Widget build(BuildContext context) {
    DatabaseService databaseService = DatabaseService.instance;


    Future<String> totalRentPaid = databaseService.totalReceivedPayments();
    totalRentPaid.then((String result) => {
      setState(() {
      healthDetails.healthData[2].value = result;
        }
      )
    },
    );

    Future<String> totalRentUnPaid = databaseService.totalNonReceivedPayments();
    totalRentUnPaid.then((String result) => {
      setState(() {
        healthDetails.healthData[3].value = result;
      }
      )
    },
    );

    Future<String> totalUnPaidHouses = databaseService.totalUnPaidHouses();
    totalUnPaidHouses.then((String result) => {
      setState(() {
        healthDetails.healthData[1].value = result;
      }
      )
    },
    );

    Future<String> totalPaidHouses = databaseService.totalPaidHouses();
    totalPaidHouses.then((String result) => {
      setState(() {
        healthDetails.healthData[0].value = result;
      }
      )
     },
    );


    // print("HEALTH DETAILS CHECKING IN BUILD FUNCTION: ${healthDetails.healthData[0].value}");
    //     return GridView.builder(
    //       //itemCount: healthDetails.healthData.length,
    //       itemCount:4,
    //       shrinkWrap: true,
    //       physics: const ScrollPhysics(),
    //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
    //         crossAxisSpacing: Responsive.isMobile(context) ? 12 : 15,
    //         mainAxisSpacing: 12.0,
    //       ),
    //       itemBuilder: (context, index) {
    //
    //         HealthModel activity = healthDetails.healthData[index];
    //         return CustomCard(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Image.asset(
    //                 activity.icon,
    //                 width: 30,
    //                 height: 30,
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 15, bottom: 4),
    //                 child: Text(
    //                   activity.value,
    //                   style: const TextStyle(
    //                     fontSize: 18,
    //                     color: Colors.white,
    //                     fontWeight: FontWeight.w600,
    //                   ),
    //                 ),
    //               ),
    //               Text(
    //                 activity.title,
    //                 style: const TextStyle(
    //                   fontSize: 17,
    //                   color: Colors.grey,
    //                   fontWeight: FontWeight.normal,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         );
    //       }
    //       );

    return Column(
      children: [
        GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, "/paid_houses_screen");
            },
            child: CustomCard(child:createChildColumn(healthDetails.healthData[0]))
        ),
        const SizedBox(height: 5,),
        GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, "/unpaid_houses_screen");
            },
            child: CustomCard(child:createChildColumn(healthDetails.healthData[1]))
        ),
        const SizedBox(height: 5,),
        CustomCard(child:createChildColumn(healthDetails.healthData[2])),
        const SizedBox(height: 5,),
        CustomCard(child:createChildColumn(healthDetails.healthData[3])),
        const SizedBox(height: 5,),
      ],
    );
  }
}

Widget createChildColumn(HealthModel activity){
  return Column(
    // mainAxisAlignment: MainAxisAlignment.center,
    // crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(height:10,),
      Image.asset(
        activity.icon,
        width: 50,
        height: 50,
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          activity.value,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Text(
        activity.title,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.grey,
          fontWeight: FontWeight.normal,
        ),
      ),
    ],
  );
}


void getPaidHousesInfo(BuildContext contextt){
  showDialog(
    context: contextt,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Success'),
        content: const Text('This is the list for checking the list of paid houses'),
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
}

