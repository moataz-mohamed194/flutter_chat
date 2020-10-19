import 'dart:core';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/Database/SQLDatabase.dart';
import 'package:flutter_chat_ui_starter/Database/model/sqlmodel.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactProvider extends ChangeNotifier {
  // the list of contacts in phone
  Iterable<Contact> _contacts;
  //the list of contacts in database
  var webData;
  bool loadingStart = false;
  //get the contacts from firebase and from phone and remove any mark in phone contacts
  getAllContacts() async {
    loadingStart = true;
    notifyListeners();
    if (await Permission.contacts.request().isGranted) {
      webData = FirebaseDatabase().reference().child('Account').once();
      _contacts =
          (await ContactsService.getContacts(withThumbnails: false)).toList();
      _contacts.forEach((element) {
        if (element.phones.length > 0) {
          String phone = element.phones.elementAt(0).value.replaceAll("-", "");
          phone = phone[0] != "+" && phone[1] == "1"
              ? "+2" + phone.replaceAll(" ", "")
              : phone.replaceAll(" ", "");
          compareData(phone, element.displayName);
        }
      });
    }
    notifyListeners();
  }

  // compare between contacts in phone and contacts in database
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

  //if you have number of saved in database get the number data
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
