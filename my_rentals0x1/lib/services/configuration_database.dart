// import 'dart:ffi';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ConfigurationsDatabaseService{
  static Database ? _db;
  static final ConfigurationsDatabaseService instance = ConfigurationsDatabaseService._constructor();
  final String _configurationsTableName = "configurationsTable";
  final String _automaticDaysID = "automaticDays";
  final String _configurationName = "configurationName";
  final String _actualConfiguration = "actualConfiguration";

  ConfigurationsDatabaseService._constructor();

  Future<Database> getDatabase() async{
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "configurations.db");
    final database = await openDatabase(
        databasePath,
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
              '''
              CREATE TABLE $_configurationsTableName(
              $_configurationName TEXT PRIMARY KEY,
              $_actualConfiguration TEXT
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

  void insertAutomaticDays(String newAutomaticDays) async{
    final db = await database;
    // String thisHouseId = h.building + h.houseAccNo;
    await db.insert(
        _configurationsTableName,
        {
          _configurationName: _automaticDaysID,
          _actualConfiguration: newAutomaticDays,
        }
    );
  }

  Future<String> getAutomaticDays() async {
    final db = await database;
    final data = await db.query(
      _configurationsTableName,
      columns: [_actualConfiguration, _configurationName],
      where: '$_configurationName = ?',
      whereArgs: [_automaticDaysID],
    );

    var automaticDays = data[0][_actualConfiguration] as String;
    return automaticDays;
  }

  void close() async{
    final db = await database;
    db.close();
  }

   void updateAutomaticDays(String newAutomaticDays) async {
    final db = await database;
      await db.update(_configurationsTableName,
      {
        _actualConfiguration: newAutomaticDays,
      },
      where: '$_configurationName = ?', whereArgs: [_automaticDaysID]);

  }

}