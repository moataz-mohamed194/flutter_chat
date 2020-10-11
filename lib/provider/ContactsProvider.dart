import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/Database/SQLDatabase.dart';
import 'package:flutter_chat_ui_starter/models/phonesnumber.dart';
import 'package:flutter_chat_ui_starter/Database/model/sqlmodel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

class ContactProvider extends ChangeNotifier {
  Iterable<Contact> _contacts;
  var webData;

  getAllContacts() async {
    SQLDatabase.db.insert(new OldPhonesNumbers("name", "value['PhoneNumber']00",
        "https://cdn.pocket-lint.com/r/s/970x/assets/images/151442-cameras-feature-stunning-photos-from-the-national-sony-world-photography-awards-2020-image1-evuxphd3mr-jpg.webp?v1"));

//    if (await Permission.contacts.request().isGranted) {
//      webData = FirebaseDatabase().reference().child('Account').once();
//      _contacts =
//          (await ContactsService.getContacts(withThumbnails: false)).toList();
//      _contacts.forEach((element) {
//        if (element.phones.length > 0) {
//          String phone = element.phones.elementAt(0).value.replaceAll("-", "");
//          phone = phone[0] != "+" && phone[1] == "1"
//              ? "+2" + phone.replaceAll(" ", "")
//              : phone.replaceAll(" ", "");
//          compareData(phone, element.displayName);
//        }
//      });
//    }
    notifyListeners();
  }

  compareData(String phone, var name) {
    webData.then((DataSnapshot snapshot) {
      final value = snapshot.value as Map;
      for (final key in value.keys) {
        if (phone == key) {
          getDataFromFireBase(key, name);
        }
      }
    });
  }

  getDataFromFireBase(String node, var name) async {
    await FirebaseDatabase()
        .reference()
        .child('Account')
        .child('$node')
        .once()
        .then((DataSnapshot snapshot) async {
      final value = snapshot.value as Map;
      try {
        SQLDatabase.db.insert(new OldPhonesNumbers(
            name, value['PhoneNumber'], "${value['image']}"));
      } catch (e) {
        print(e);
      }
      notifyListeners();
    });
  }
}
