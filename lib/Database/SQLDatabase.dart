import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model/sqlmodel.dart';

class SQLDatabase extends ChangeNotifier {
  SQLDatabase();
  List results;
  bool start = false;
  SQLDatabase._();

  static final SQLDatabase db = SQLDatabase._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'whatsApp.db');
    return await openDatabase(path, version: 5, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE phonesNumbers(id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT, phoneNumber TEXT UNIQUE, image TEXT)",
      );
      await db.execute(
        "CREATE TABLE oldChat(id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT, phoneNumber TEXT UNIQUE, image TEXT)",
      );
    });
  }

  insert(OldPhonesNumbers product) async {
    final db = await database;
    var result;
    try {
      result = await db.rawInsert(
          "INSERT Into phonesNumbers ( name, phoneNumber, image)"
          " VALUES ( ?, ?, ?)",
          [product.name, product.phoneNumber, product.image]);
    } catch (e) {
      print(e);
    }
    try {
      var w = [
        {
          "id": 0,
          "name": product.name,
          "phoneNumber": product.phoneNumber,
          "image": product.image
        }
      ];
      results = results + w;
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return result;
  }

  count() async {
    final db = await database;
    int result = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM phonesNumbers'));
    print("co $result");
    return result;
  }

  Future<List> getAllProducts() async {
    final db = await database;
    results = await db.query("phonesNumbers");
    start = true;
    notifyListeners();
    return results.toList();
  }
}
