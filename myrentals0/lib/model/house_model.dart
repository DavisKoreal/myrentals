class House{
  final String houseId;
  final String houseAccNo;
  final String tenantName;
  final String building;
  final String tenantContact;
  final String rentPayable;
  final int housePaidStatus;

  const House(
      {required this.houseId, required this.houseAccNo, required this.tenantContact, required this.tenantName, required this.building,required this.housePaidStatus, required this.rentPayable});
  // Create a Recipe from JSON data
//   factory House.fromJson(Map<String, dynamic> json) => House(
//     houseAccNo: json['houseAccNo'],
//     tenantContact: json['tenantContact'],
//     tenantName: json['tenantName'],
//     building: json['building'],
//     messages: json['messages'],
//     housePaidStatus: json['housePaidStatus'],
//     rentPayable: json['rentPayable'],
//   );
// // Convert our Recipe to JSON to make it easier when you store
// // it in the database
//   Map<String, dynamic> toJson() => {
//     'houseAccNo': houseAccNo,
//     'tenantContact': tenantContact,
//     'tenantName': tenantName,
//     'building': building,
//     'messages': messages,
//     'housePaidStatus': housePaidStatus,
//     'rentPayable': rentPayable,
//   };
}
