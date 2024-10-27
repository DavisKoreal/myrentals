// import 'dart:ffi';

import 'package:my_rentals/model/house_model.dart';
import 'package:my_rentals/model/message_model.dart';
import 'package:my_rentals/model/paid_house.dart';
import 'package:my_rentals/model/search_results.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService{
  static Database ? _db;
  static final DatabaseService instance = DatabaseService._constructor();
  final String _houseTableName = "houseTable";
  // final String _configurationsTableName = "configurationsTable";
  final String _houseAccNoCol = "houseAccNo";
  final String _tenantNameCol = "tenantName";
  final String _buildingCol = "building";
  final String _tenantContactCol = "tenantContact";
  final String _rentPayableCol = "rentPayable";
  final String _houseIdCol = "id";
  final String _housePayedStatus = "housePaidStatus";

  DatabaseService._constructor();

  Future<Database> getDatabase() async{
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "fifth.db");
    final database = await openDatabase(
        databasePath,
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
              '''
              CREATE TABLE $_houseTableName(
              $_houseIdCol TEXT PRIMARY KEY,
              $_houseAccNoCol TEXT NOT NULL,
              $_tenantNameCol TEXT NOT NULL,
              $_buildingCol TEXT NOT NULL,
              $_tenantContactCol TEXT NOT NULL,
              $_rentPayableCol TEXT NOT NULL,
              $_housePayedStatus INTEGER NOT NULL
              )
              '''
          );
        },
    );
    return database;
  }

  Future<Database> get database async{
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  void addHouse(House h) async{
    final db = await database;
    // String thisHouseId = h.building + h.houseAccNo;
    await db.insert(
        _houseTableName,
      {
        _houseIdCol: h.houseId,
        _houseAccNoCol:h.houseAccNo,
        _tenantNameCol:h.tenantName,
        _buildingCol:h.building,
        _tenantContactCol:h.tenantContact,
        _rentPayableCol:h.rentPayable,
        _housePayedStatus:h.housePaidStatus,
      }
    );
  }

  Future<List<House>> getHouses() async{
    final db = await database;
    final data = await db.query(_houseTableName);

    List<House> houses = data.map((e)=>
        House(
            houseId: e["id"] as String,
            houseAccNo: e["houseAccNo"] as String,
            tenantContact: e["tenantContact"] as String,
            tenantName: e["tenantName"] as String,
            building: e["building"] as String,
            rentPayable: e["rentPayable"] as String,
            housePaidStatus: e["housePaidStatus"] as int,
        ),
        ).toList();

    return houses;
  }

  void deleteAllHouses() async{
    final db = await database;
    await db.delete(_houseTableName);
  }

  //getting the number of rows in a database
  Future<int> getHouseTableRowCount() async {
    final db = await database;
    // Execute the query to count the rows
    final result = await db.rawQuery('SELECT COUNT(*) FROM $_houseTableName');
    // Extract the count from the query result
    int count = Sqflite.firstIntValue(result) ?? 0;
    return count;
  }

  Future<List<String>> getAllContactsInDatabase() async{
    final db = await database;
    final data = await db.query(
      _houseTableName,
      columns: ["tenantContact"],
    );
    List<String> contacts = [];
    // print("PRINTING DATA");
    for (int i = 0; i < data.length; i++)
      {
        // print("DATA INDEX $i :  ${data[i]}");
        String nextContact = data[i]["tenantContact"] as String;
        contacts.add(nextContact);
      }
    return contacts;
  }

  Future<String> totalReceivedPayments() async {
    final db = await database;
    final data = await db.query(
      _houseTableName,
      columns: [_rentPayableCol, _housePayedStatus],
      where: '$_housePayedStatus = ?',
      whereArgs: [1],
    );

    var totalPayments = 0.0;
    // print("PRINTING DATA");
    for (int i = 0; i < data.length; i++)
    {
      // print("DATA INDEX $i :  ${data[i]}");
      var nextPayment = data[i][_rentPayableCol] as String;
      totalPayments += double.parse(nextPayment);
    }
    return totalPayments.toString();
  }

  Future<String> totalNonReceivedPayments() async {
    final db = await database;
    final data = await db.query(
      _houseTableName,
      columns: [_rentPayableCol, _housePayedStatus],
      where: '$_housePayedStatus = ?',
      whereArgs: [0],
    );

    var totalPayments = 0.0;
    // print("PRINTING DATA");
    for (int i = 0; i < data.length; i++)
    {
      // print("DATA INDEX $i :  ${data[i]}");
      var nextPayment = data[i][_rentPayableCol] as String;
      // print("PRINTING NEXT PAYMENT");
      // print("nextPayment: $nextPayment");
      // print("totalPayment: $totalPayments");
      totalPayments += double.parse(nextPayment);
    }
    return totalPayments.toString();
  }

  Future<String> totalPaidHouses() async {
    final db = await database;
    final data = await db.query(
      _houseTableName,
      columns: [_rentPayableCol, _housePayedStatus],
      where: '$_housePayedStatus = ?',
      whereArgs: [1],
    );

    return data.length.toString();
  }

  Future<String> totalUnPaidHouses() async {
    final db = await database;
    final data = await db.query(
      _houseTableName,
      columns: [_rentPayableCol, _housePayedStatus],
      where: '$_housePayedStatus = ?',
      whereArgs: [0],
    );

    return data.length.toString();
  }

  Future<List<PaidHouse>> getAllPaidHouses() async {
    final db = await database;
    // ist<Map<String, Object?>> data = [];

    // await db.transaction ((txn) async {
    final data = await db.query(
      _houseTableName,
      columns: [_houseAccNoCol,_buildingCol,_tenantNameCol, _housePayedStatus],
      where: '$_housePayedStatus = ?',
      whereArgs: [1],
    );
    List<PaidHouse> allPaidHouses = [];
    for (int i =0; i < data.length;i++)
      {
        var buildingName = data[i][_buildingCol] as String;
        var houseNumber = data[i][_houseAccNoCol] as String;
        var tenantName = data[i][_tenantNameCol] as String;

        PaidHouse paidHouse = PaidHouse(houseNumber: houseNumber, buildingName: buildingName, tenantName: tenantName);
        allPaidHouses.add(paidHouse);
      }
    return allPaidHouses;
  }

  Future<List<PaidHouse>> getAllUnPaidHouses() async {
    final db = await database;
    // List<Map<String, Object?>> data = [];
    // await db.transaction ((txn) async {
      final data = await db.query(
    //     data = await db.query(
        _houseTableName,
        columns: [_houseAccNoCol,_buildingCol,_tenantNameCol, _housePayedStatus],
        where: '$_housePayedStatus = ?',
        whereArgs: [0],
      );
    // });

    List<PaidHouse> allPaidHouses = [];
    for (int i =0; i < data.length;i++)
    {
      var buildingName = data[i][_buildingCol] as String;
      var houseNumber = data[i][_houseAccNoCol] as String;
      var tenantName = data[i][_tenantNameCol] as String;

      PaidHouse paidHouse = PaidHouse(houseNumber: houseNumber, buildingName: buildingName, tenantName: tenantName);
      allPaidHouses.add(paidHouse);
    }
    return allPaidHouses;
  }


  Future<List<MessageModel>> getAllMessageModels() async {
    final db = await database;

    // List<Map<String, Object?>> data = [];

    // await db.transaction ((txn) async {
      final data = await db.query(
        _houseTableName,
        columns: [_tenantNameCol,_buildingCol,_houseAccNoCol,_tenantContactCol,_rentPayableCol, _housePayedStatus],
        where: '$_housePayedStatus = ?',
        whereArgs: [0],
      );
    // });


    List<MessageModel> allMessageModels = [];

    for (int i = 0; i < data.length; i++)
    {
      // print("DATA INDEX $i :  ${data[i]}");
      var tenantName = data[i][_tenantNameCol] as String;
      var buildingName = data[i][_buildingCol] as String;
      var houseName = data[i][_houseAccNoCol] as String;
      var nextPayment = data[i][_rentPayableCol] as String;
      var tenantContact = data[i][_tenantContactCol] as String;

      var message = "Dear $tenantName of $buildingName $houseName. Please pay Ksh $nextPayment in current rent balance before due date. Space Eco Management.";
      MessageModel messageModel = MessageModel(messageToSend: message, contactToSend: tenantContact);
      allMessageModels.add(messageModel);
    }
    return allMessageModels;
  }


  Future<List<SearchResults>> getAllNamesAndKeysForSearch() async {
    final db = await database;
    // late List<Map<String, Object?>> data;

    // await db.transaction ((txn) async {
      final data = await db.query(
        _houseTableName,
        columns: [_tenantNameCol, _houseIdCol],
      );
    // });


    List<SearchResults> allNamesAndKeys = [];

    for (int i = 0; i < data.length; i++)
    {
      // print("DATA INDEX $i :  ${data[i]}");
      var tenantName = data[i][_tenantNameCol] as String;
      var houseId = data[i][_houseIdCol] as String;


      var searchResult = SearchResults(tenantName: tenantName, houseId: houseId);
      allNamesAndKeys.add(searchResult);
    }
    return allNamesAndKeys;
  }

  Future<int> deleteRow(String houseId) async {
    final db = await database;
    late int count;
    // await db.transaction ((txn) async {
      count = await db.delete(_houseTableName, where: '$_houseIdCol = ?', whereArgs: [houseId]);
    // }
    // );
    return count;
  }

  void update(House house) async {
    final db = await database;
    // String thisHouseId = house.building + house.houseAccNo;
    // await db.transaction ((txn) async {
      await db.update(_houseTableName,
      {
      _houseIdCol: house.houseId,
      _houseAccNoCol:house.houseAccNo,
      _tenantNameCol:house.tenantName,
      _buildingCol:house.building,
      _tenantContactCol:house.tenantContact,
      _rentPayableCol:house.rentPayable,
      _housePayedStatus:house.housePaidStatus,
      },
      where: '$_houseIdCol = ?', whereArgs: [house.houseId]);
    // }
    // );
  }

  // class DatabaseService {
  // ... (existing code remains the same)
  //
  // Future<void> addHouse(House h) async {
  // final db = await database;
  // await db.transaction((txn) async {
  // await txn.insert(
  // _houseTableName,
  // {
  // _houseIdCol: h.houseId,
  // _houseAccNoCol: h.houseAccNo,
  // _tenantNameCol: h.tenantName,
  // _buildingCol: h.building,
  // _tenantContactCol: h.tenantContact,
  // _rentPayableCol: h.rentPayable,
  // _housePayedStatus: h.housePaidStatus,
  // },
  // );
  // });
  // }
  //
  // Future<void> deleteAllHouses() async {
  // final db = await database;
  // await db.transaction((txn) async {
  // await txn.delete(_houseTableName);
  // });
  // }

  // Future<int> deleteRow(String houseId) async {
  // final db = await database;
  // int count = 0;
  // await db.transaction((txn) async {
  // count = await txn.delete(_houseTableName, where: '$_houseIdCol = ?', whereArgs: [houseId]);
  // });
  // return count;
  // }

  // Future<void> update(House house) async {
  // final db = await database;
  // await db.transaction((txn) async {
  // await txn.update(
  // _houseTableName,
  // {
  // _houseIdCol: house.houseId,
  // _houseAccNoCol: house.houseAccNo,
  // _tenantNameCol: house.tenantName,
  // _buildingCol: house.building,
  // _tenantContactCol: house.tenantContact,
  // _rentPayableCol: house.rentPayable,
  // _housePayedStatus: house.housePaidStatus,
  // },
  // where: '$_houseIdCol = ?',
  // whereArgs: [house.houseId],
  // );
  // });
  // }
  // }


}