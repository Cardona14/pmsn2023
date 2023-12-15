// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pmsn2023/models/location_model.dart';
import 'package:sqflite/sqflite.dart';

class WeatherDataBase {
  static const nameDB = 'WEATHERDB';
  static const versiondb = 1;

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    return _database = await _initDatabase();
  }

  Future<Database?> _initDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String pathdb = join(dir.path, nameDB);
    return openDatabase(pathdb, version: versiondb, onCreate: _createTables);
  }

  FutureOr<void> _createTables(Database db, int version) {
    db.execute('''
      CREATE TABLE tblLocations(
        location_id INTEGER PRIMARY KEY,
        location_name TEXT,
        latitude REAL,
        longitude REAL
      );
    ''');
  }

  Future<int> INSERT(Map<String, dynamic> data) async {
    var connection = await database;
    return connection!.insert("tblLocations", data);
  }

  Future<int> UPDATE(Map<String, dynamic> data) async {
    var connection = await database;
    return connection!.update("tblLocations", data,
      where: 'location_id = ?', whereArgs: [data['location_id']]);
  }

  Future<int> DELETE(int objectId) async {
    var connection = await database;
    return connection!.delete("tblLocations", where: 'location_id = ?', whereArgs: [objectId]);
  }

  Future<List<LocationModel>> GETALLLOCATIONS() async {
    var connection = await database;
    var result = await connection!.query('tblLocations');
    return result.map((location) => LocationModel.fromMap(location)).toList();
  }
}