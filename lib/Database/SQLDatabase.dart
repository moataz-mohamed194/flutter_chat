import 'package:firebase_database/firebase_database.dart';
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

  insertOldContact0(var q, var w) async {
    webData = FirebaseDatabase()
        .reference()
        .child('Account')
        .child(w)
        .child("Chat")
        .once();
    webData.then((DataSnapshot snapshot) {
      final value = snapshot.value as Map;
      for (final key in value.keys) {
        if (key != q) {
          print(key);
          webData0 =
              FirebaseDatabase().reference().child('Account').child(key).once();

          webData0.then((DataSnapshot snapshot0) async {
            final value0 = snapshot0.value as Map;
            for (final key0 in value0.keys) {
              final db = await database;
              try {
                List results0 = await db.rawQuery(
                    "SELECT * FROM phonesNumbers WHERE phoneNumber='$key'");
                if (results0[0].row[3] != value0['image']) {
                  db.rawUpdate(
                      "UPDATE oldChat SET image = ? WHERE phoneNumber = ?",
                      [value0['image'], key]);
                }
                try {
                  List result1 = (await db.rawInsert(
                      "INSERT Into oldChat ( name, phoneNumber, image,message)"
                      " VALUES ( ?, ?, ?,?)",
                      [
                        results0[0].row[1],
                        key,
                        value0['image'],
                        "Nothing"
                      ]).whenComplete(() => print("done in sql"))) as List;
                  results.add(result1);
                  notifyListeners();
                } catch (e) {
                  print(e);
                }
              } catch (e) {
                print(e);
              }
            }
          });
        }
      }
    });
  }

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
