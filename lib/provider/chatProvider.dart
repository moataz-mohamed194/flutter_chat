import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import '../Database/SQLDatabase.dart';
import '../Database/model/sqlmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

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
      'Time': myTimeStamp.microsecondsSinceEpoch,
      'to':'$toNumber',
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
        'Time': myTimeStamp.microsecondsSinceEpoch,
        'to':'$senderNumber',
        'isMe': false
      }).whenComplete(() {
        try {
          SQLDatabase.db.insertOldContact(
              new OldPhonesMessage(name, toNumber, image, body));
          sendAndRetrieveMessage(body,toNumber);
          print("Done");
        } catch (e) {
          print("000" + e);
        }
      });
    });
    notifyListeners();
  }

  final String serverToken = 'AAAASpmKavY:APA91bEbUE7xMX4OazN9KWqMeebwT1ak8zOc3oepAWZqI7VKEyLH1ieAjpkrWRTyPiXFHTaK3XpcqX3XpqwYM8xG_L4blxztfrp5qEQHH-ER9sjVzkg6gdVFdJ3vofIrwTVRbleMWQs3';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Future<Map<String, dynamic>> sendAndRetrieveMessage(String body,String toNumber) async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
    );
    var number=(await FirebaseDatabase.instance.reference()
        .child('Account').child(toNumber).once()).value["Token"];

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': '$body',
            'title': 'new message from $toNumber'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'sound': 'pristine.mp3',
            'status': 'done'
          },
          'to': "$number"//"e9JKkgGjRXqqRV_1yu-SEt:APA91bExE7SRFbnW8cj_wzQ-9KStPXRyTpIC6QbasD7er1d0VYoltJZjrFgPQtcJFBpyb49rVd6kDOX6mrKD-wT0Z4wWKkU8pZU_IytY8YKu3vL-hkXQ4pOGmYLscNcahkWN745sImnA"//await firebaseMessaging.getToken(),
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
    Completer<Map<String, dynamic>>();


    return completer.future;
  }
  var data;



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

Future<void> isLiked(String toNumber, String id,String isLikedValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String senderNumber = prefs.get('PhoneNumber');
  if(isLikedValue=="true") {
      FirebaseDatabase.instance
          .reference()
          .child('Account')
          .child(senderNumber)
          .child('Chat')
          .child(toNumber)
          .child("$id")
          .update({"isLiked": "false"});
    }else{
    FirebaseDatabase.instance
        .reference()
        .child('Account')
        .child(senderNumber)
        .child('Chat')
        .child(toNumber)
        .child("$id")
        .update({"isLiked": "true"});
  }
  }

}
Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

}