import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ChatProvider extends ChangeNotifier {
  sendMessage(String toNumber, String body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String senderNumber = prefs.get('PhoneNumber');
    //    DateTime now = DateTime.now();
//    DateFormat formatter = DateFormat('yyyy-MM-dd Hm');
//    var formatted = formatter.format(now);
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate);

    DateTime myDateTime = myTimeStamp.toDate(); // TimeStamp to DateTime
    FirebaseDatabase.instance
        .reference()
        .child('Account')
        .child(senderNumber)
        .child(toNumber)
        //.push()
        .child("${myTimeStamp.microsecondsSinceEpoch}")
        .set({
      'Body': body,
      'Time': myTimeStamp.microsecondsSinceEpoch,
      'isMe': true
    }).whenComplete(() {
      FirebaseDatabase.instance
          .reference()
          .child('Account')
          .child(toNumber)
          .child(senderNumber)
          //.push()
          .child("${myTimeStamp.microsecondsSinceEpoch}")
          .set({
        'Body': body,
        'Time': myTimeStamp.microsecondsSinceEpoch,
        'isMe': false
      }).whenComplete(() => print("Done"));
    });
    print("data will save in my account");
    print("his number: $toNumber");
    print("body of message: $body");
    print("time of message: ${myTimeStamp.microsecondsSinceEpoch}");
    print("data will save in friends account");
    print("his number: $senderNumber");
    print("body of message: $body");
    print("time of message: $myTimeStamp");
    notifyListeners();
  }

  var data;

  String d0;
  ChatProvider() {
    getMe();
  }
  Future<String> getMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.d0 = prefs.get('PhoneNumber').toString();
    notifyListeners();
    // return this.d0;
  }

  Future<Map> getMessageData(String phoneNumberD) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myNumber = prefs.get('PhoneNumber');

    data = (await FirebaseDatabase()
        .reference()
        .child('Account')
        .child(myNumber)
        .child('$phoneNumberD')
        .once());
    return data.value;
  }
}
