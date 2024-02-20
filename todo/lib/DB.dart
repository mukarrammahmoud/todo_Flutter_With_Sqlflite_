import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDB();
      return _db;
    } else {
      return _db;
    }
  }

  intialDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "todo.db");
    Database myDb = await openDatabase(path,
        onCreate: _oncreated, version: 1, onUpgrade: _onUpgrade);
    return myDb;
  }

  _oncreated(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
create table Lec(
  "id" integer not null primary key AUTOINCREMENT,
  "name" text not null ,
  "day" text not null,
   "fromTime" text not null,
   "toTime" text not null,
   "class" text not null

)
''');
    batch.execute('''
create table HW(
  "id" integer not null primary key AUTOINCREMENT,
   "idLec" integer references Lec(id) ,
  "content" text not null,
   "Deltime" text not null,
   "fav" integer not null 
   

)
''');
    batch.execute('''
create table Task(
  "id" integer not null primary key AUTOINCREMENT,
   "name" text not null ,
  "appointment" text not null,
  "time" text not null,
   "fav" integer not null 
   

)
''');
    batch.execute('''
create table Setteing(
  "id" integer not null primary key AUTOINCREMENT,
   "name" text not null ,
  "desc" text not null,
  "pass" text not null,
  "image" text 
   

)
''');
    batch.execute('''
create table images(
  "id" integer not null primary key AUTOINCREMENT,
  
  "image" text not null
  

)
''');
    await batch.commit();
    print("created =======================");
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    print("Upgrade===========");
  }

  readData(String query) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(query);
    return response;
  }

  insertData(String query) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(query);
    return response;
  }

  updateData(String query) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(query);
    return response;
  }

  deleteData(String query) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(query);
    return response;
  }

  deleteMyDataBase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, "todo.db");
    await deleteDatabase(path);
    print("Delete DB ------------");
  }
}
