import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import '../Database/SQLDatabase.dart';
import '../Database/model/sqlmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ChatProvider extends ChangeNotifier {
  sendMessage(String toNumber, String body, String name, String image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String senderNumber = prefs.get('PhoneNumber');
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime currentPhoneDate = DateTime.now().toUtc(); //DateTime
    var formatted = formatter.format(currentPhoneDate);
    DateTime dateTime = DateTime.parse(formatted);
    Timestamp myTimeStamp = Timestamp.fromDate(dateTime);
    DateTime currentPhoneDate0 = DateTime.now(); //DateTime
    var formatted0 = formatter.format(currentPhoneDate0);
    DateTime dateTime0 = DateTime.parse(formatted0);
    Timestamp myTimeStamp0 = Timestamp.fromDate(dateTime0);

    FirebaseDatabase.instance
        .reference()
        .child('Account')
        .child(senderNumber)
        .child('Chat')
        .child(toNumber)
        .child("${myTimeStamp.microsecondsSinceEpoch}")
        .set({
      'Body': body,
      'Time': myTimeStamp0.microsecondsSinceEpoch,
      'isMe': true
    }).whenComplete(() {
      FirebaseDatabase.instance
          .reference()
          .child('Account')
          .child(toNumber)
          .child('Chat')
          .child(senderNumber)
          .child("${myTimeStamp.microsecondsSinceEpoch}")
          .set({
        'Body': body,
        'Time': myTimeStamp0.microsecondsSinceEpoch,
        'isMe': false
      }).whenComplete(() {
        try {
          SQLDatabase.db.insertOldContact(
              new OldPhonesMessage(name, toNumber, image, body));
          print("Done");
        } catch (e) {
          print("000" + e);
        }
      });
    });
    notifyListeners();
  }

  var data;

  String d0;
  ChatProvider() {
    getMe();
  }
  Future<void> getMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.d0 = prefs.get('PhoneNumber').toString();
    notifyListeners();
  }

  Future<Map> getMessageData(String phoneNumberD) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myNumber = prefs.get('PhoneNumber');

    data = (await FirebaseDatabase()
        .reference()
        .child('Account')
        .child(myNumber)
        .child('Chat')
        .child('$phoneNumberD')
        .once());
    return data.value;
  }
}
