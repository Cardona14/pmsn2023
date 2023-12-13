// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pmsn2023/models/career_model.dart';
import 'package:pmsn2023/models/task_model.dart';
import 'package:pmsn2023/models/teacher_model.dart';
import 'package:sqflite/sqflite.dart';

class AgendaDB {

  static const nameDB = 'AGENDADB';
  static const versionDB = 1;
  static Database? _database;
  
  Future<Database?> get database async {
    if( _database != null ) return _database!;
    return _database = await _initDatabase();
  }
  
  Future<Database?> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    return openDatabase(
      pathDB,
      version: versionDB,
      onCreate: _createTables
    );
  }

  FutureOr<void> _createTables(Database db, int version){
    db.execute('''
      CREATE TABLE tblTasks(
        idTask INTEGER PRIMARY KEY,
        nameTask VARCHAR(50),
        descTask VARCHAR(100),
        stateTask INTEGER,
        dateExp VARCHAR(50),
        dateAlert VARCHAR(50),
        idTeacher INTEGER,
        FOREIGN KEY (idTeacher) REFERENCES tblTeachers(idTeacher)
      );
    ''');

    db.execute('''
      CREATE TABLE tblTeachers(
        idTeacher INTEGER PRIMARY KEY,
        nameTeacher VARCHAR(50),
        emailTeacher VARCHAR(50),
        idCareer INTEGER,
        FOREIGN KEY (idCareer) REFERENCES tblCareers(idCareer)
      );
    ''');

    db.execute('''
      CREATE TABLE tblCareers(
        idCareer INTEGER PRIMARY KEY,
        nameCareer VARCHAR(100)
      );
    ''');
  }

  Future<int> INSERT(String tName, Map<String, dynamic> data) async {
    var connection = await database;
    return connection!.insert(tName, data);
  }

  Future<int> UPDATE(
    String tName, String field, Map<String, dynamic> data) async {
    var connection = await database;
    return connection!.update(tName, data, where: '$field = ?', whereArgs: [data[field]]);
  }

  Future<int> DELETE(
    String tName, String field, int objectId, String? childTable) async {
    var connection = await database;
    if (childTable != null) {
      final dependentRows = await connection!.rawQuery("select * from $childTable where $field = $objectId");
      if (dependentRows.isEmpty) {
        return connection.delete(tName, where: '$field = ?', whereArgs: [objectId]);
      } else {
        return 0;
      }
    } else {
      return connection!.delete(tName, where: '$field = ?', whereArgs: [objectId]);
    }
  }

  Future<void> DELETEALL(table) async {
    var connection = await database;
    await connection!.delete(table, where: '1=1');
  }

  Future<List<TaskModel>> GETALLTASKS() async {
    var connection = await database;
    var result = await connection!.query('tblTasks');
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<CareerModel>> GETALLCAREERS() async {
    var connection = await database;
    var result = await connection!.query('tblCareers');
    return result.map((career) => CareerModel.fromMap(career)).toList();
  }

  Future<List<TeacherModel>> GETALLTEACHERS() async {
    var connection = await database;
    var result = await connection!.query('tblTeachers');
    return result.map((teacher) => TeacherModel.fromMap(teacher)).toList();
  }

  Future<CareerModel> GETCAREER(int objectId) async {
    var connection = await database;
    var result = await connection!.query('tblCareers', where: 'idCareer = ?', whereArgs: [objectId]);
    return result.map((career) => CareerModel.fromMap(career)).toList().first;
  }

  Future<TeacherModel> GETTEACHER(int objectId) async {
    var connection = await database;
    var result = await connection!.query('tblTeachers', where: 'idTeacher = ?', whereArgs: [objectId]);
    return result.map((teacher) => TeacherModel.fromMap(teacher)).toList().first;
  }

  Future<List<CareerModel>> GETFILTEREDCAREERS(String input) async {
    var connection = await database;
    var sql = "select * from tblCareers where nameCareer like '%$input%'";
    var result = await connection!.rawQuery(sql);
    return result.map((career) => CareerModel.fromMap(career)).toList();
  }

  Future<List<TeacherModel>> GETFILTEREDTEACHERS(String input) async {
    var connection = await database;
    var sql = "select * from tblTeachers where nameTeacher like '%$input%'";
    var result = await connection!.rawQuery(sql);
    return result.map((teacher) => TeacherModel.fromMap(teacher)).toList();
  }

  Future<List<TaskModel>> GETFILTEREDTASKS(String input, int? input2) async {
    var connection = await database;
    var sql = input2 != null
        ? "select * from tblTasks where nameTask like '%$input%' and stateTask = $input2"
        : "select * from tblTasks where nameTask like '%$input%'";
    var result = await connection!.rawQuery(sql);
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<TaskModel>> GETUNFINISHEDTASKS() async {
    var connection = await database;
    var sql = "select * from tblTasks where stateTask = 0";
    var result = await connection!.rawQuery(sql);
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

}