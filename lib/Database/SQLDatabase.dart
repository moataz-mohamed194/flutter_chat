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
        "CREATE TABLE oldChat(id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT, phoneNumber TEXT UNIQUE, image TEXT, message TEXT)",
      );
    });
  }

  cleanTables() async {
    await db.cleanTables();
    notifyListeners();
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

  var webData, webData0;

  insertOldContact(OldPhonesMessage product) async {
    final db = await database;
    var result;
    int number = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT(*) FROM oldChat WHERE phoneNumber='${product.phoneNumber}'"));
    print("number: $number");
    if (number == 0) {
      try {
        print("name:" + product.name);
        print("phoneNumber:" + product.phoneNumber);
        print("image:" + product.image);
        print("message:" + product.message);
        result = await db.rawInsert(
            "INSERT Into oldChat ( name, phoneNumber, image,message)"
            " VALUES ( ?, ?, ?,?)",
            [
              product.name,
              product.phoneNumber,
              product.image,
              product.message
            ]).whenComplete(() => print("done in sql"));
      } catch (e) {
        print(e);
      }
    } else {
      try {
        result = await db
            .rawUpdate("UPDATE oldChat SET message = ? WHERE phoneNumber = ?",
                [product.message, product.phoneNumber])
            .whenComplete(() => print("update done"))
            .catchError((e) => print(e));
      } catch (e) {
        print(e);
      }
    }
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

  Future<List> getAllOldContacts() async {
    final db = await database;
    results = await db.query("oldChat");
    start = true;
    notifyListeners();
    return results.toList();
  }
}
