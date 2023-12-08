import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pmsn2023/models/task_model.dart';
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
    String pathDB = join(folder.path,nameDB);
    return openDatabase(
      pathDB,
      version: versionDB,
      onCreate: _createTables
    );
  }

  FutureOr<void> _createTables(Database db, int version) async{
    await db.execute('''
      CREATE TABLE tblTareas(
        idTask INTEGER PRIMARY KEY,
        nameTask VARCHAR(50),
        dscTask TEXT,
        statusTask BYTE,
        dateExp DATETIME,
        dateRe DATETIME,
        idProf INTEGER,
        FOREIGN KEY (idProf) REFERENCES tblTeachers(idProf)
      );
    ''');

    await db.execute('''
      CREATE TABLE tblTeachers(
        idProf INTEGER PRIMARY KEY,
        nameProf VARCHAR(50),
        emailProf TEXT,
        idCareer INTEGER,
        FOREIGN KEY (idCareer) REFERENCES tblCareers(idCareer)
      );
    ''');

    await db.execute('''
      CREATE TABLE tblCareers(
        idCareer INTEGER PRIMARY KEY,
        nameCareer VARCHAR(50)
      );
    ''');
  }

  // Métodos para operaciones CRUD con TaskModel
  Future<int> insertTask(String tblName, Map<String,dynamic> data) async {
    var  conexion = await database;
    return conexion!.insert(tblName, data);
  }

  Future<int> updateTask(String tblName, Map<String,dynamic> data) async {
    var  conexion = await database;
    return conexion!.update(tblName, data, 
    where: 'idTask = ?', 
    whereArgs: [data['idTask']]);
  }

  Future<int> deleteTask(String tblName, int idTask) async {
    var  conexion = await database;
    return conexion!.delete(tblName, 
      where: 'idTask = ?',
      whereArgs: [idTask]);
  }

  Future<List<TaskModel>> GETALLTASK() async{
    var conexion = await database;
    var result = await conexion!.query('tblTareas');
    return result.map((task)=>TaskModel.fromMap(task)).toList();
  }

}