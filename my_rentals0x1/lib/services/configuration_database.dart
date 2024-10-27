// import 'dart:ffi';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ConfigurationsDatabaseService{
  static Database ? _db;
  static final ConfigurationsDatabaseService instance = ConfigurationsDatabaseService._constructor();
  final String _configurationsTableName = "configurationsTable";
  final String _automaticDaysCol = "automaticDays";
  final String _configurationName = "configurationName";

  ConfigurationsDatabaseService._constructor();

  Future<Database> getDatabase() async{
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "fifth.db");
    final database = await openDatabase(
        databasePath,
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
              '''
              CREATE TABLE $_configurationsTableName(
              $_configurationName TEXT PRIMARY KEY,
              $_automaticDaysCol TEXT
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

  void updateAutomaticDays(String newAutomaticDays) async{
    final db = await database;
    // String thisHouseId = h.building + h.houseAccNo;
    await db.insert(
        _configurationsTableName,
        {
          _configurationName: "automaticDays",
          _automaticDaysCol: newAutomaticDays,
        }
    );
  }

  Future<String> getAutomaticDays(String nameOfConfiguration) async {
    final db = await database;
    final data = await db.query(
      _configurationsTableName,
      columns: [_automaticDaysCol, _configurationName],
      where: '$_configurationName = ?',
      whereArgs: [nameOfConfiguration],
    );

    var automaticDays = data[0][_automaticDaysCol] as String;
    return automaticDays;
  }

  void close() async{
    final db = await database;
    db.close();
  }

}