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
          sendAndRetrieveMessage(body,toNumber);
          print("Done");
        } catch (e) {
          print("000" + e);
        }
      });
    });
    notifyListeners();
  }

//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   final String serverToken =
//       'AAAA6jQXgJE:APA91bGIVbn0OinH6MkJMBAIHMXqmphFGlI9GgN9AFBZZkHaoma8eoR2MrOR9qFGyNmwJBdSreMsC2WiSazdBgHu6DvH1Em3_IoeufVZWhzZr__MDAqteiAS6sAVuR2ta6Jgw9kqa_Fw';
//
//   Future<Map<String, dynamic>> sendAndRetrieveMessage(String body, String toNumber) async {
//     var number=(await FirebaseDatabase.instance.reference()
//         .child('Account').child(toNumber).once()).value["Token"];
//
//
//     print("00000000:$number");
//     messaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: true,
//       criticalAlert: true,
//       provisional: true,
//       sound: true,
//     );
//
//     await http.post(
//       'https://fcm.googleapis.com/fcm/send',
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'key=$serverToken',
//       },
//       body: jsonEncode(
//         <String, dynamic>{
//           'notification': <String, dynamic>{
//             'body': 'new message message',
//             'title': '$body'
//           },
//           // add new token
//           'to':
//           '$number' ,
//         },
//       ),
//     );
//
//     final Completer<Map<String, dynamic>> completer =
//     Completer<Map<String, dynamic>>();
// /*
//     firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         completer.complete(message);
//       },
//     );*/
//     return completer.future;
//   }
// Replace with server token from firebase console settings.
  //final String serverToken ='AAAASpmKavY:APA91bHkuh7zS_DUHCOFmZ3jvXFyQu3OlOmn0-FBFhLSfF6b2NrhaDstl-t4yjICTcGKchByjnKcgMhiipUijDOApRAHc_YCFi0WHUfxmtCtF-o2ic0P53vaIVg0hT0UaqacCmSPQle5';
//      'AAAASpmKavY:APA91bHkuh7zS_DUHCOFmZ3jvXFyQu3OlOmn0-FBFhLSfF6b2NrhaDstl-t4yjICTcGKchByjnKcgMhiipUijDOApRAHc_YCFi0WHUfxmtCtF-o2ic0P53vaIVg0hT0UaqacCmSPQle5';
//   final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//   Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
//     messaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: true,
//       criticalAlert: true,
//       provisional: true,
//       sound: true,
//     );
//     // await FirebaseMessaging.instance.sendMessage(
//     //     collapseKey: "1005896302737",
//     //     messageId: '1005896302737',
//     //     messageType: 'high',
//     //     to: 'cNPntY3wFRw:APA91bESrgQJomPnZrH5k-efwhbKk3SU4-tFKmehy-_6yoBKprbHFoY2TfXMamowaqtiel3E9MMNsbjDRrlKEIQvjw8WEtYKznHaAG0QiaTb2k0QppKEkkCAqVYNgDPc84OQt3RoO5wE',
//     //     data: {},
//     //     ttl: 1005896302737);
//     // await FirebaseMessaging.instance.unsubscribeFromTopic('weather');
//
//     await http.post(
//       'https://fcm.googleapis.com/fcm/send',
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'key=$serverToken',
//       },
//       body: jsonEncode(
//         <String, dynamic>{
//           'notification': <String, dynamic>{
//             'body': 'this is a body',
//             'title': 'this is a title'
//           },
//           // 'to': ''
//           'to':
//           //"e9JKkgGjRXqqRV_1yu-SEt:APA91bExE7SRFbnW8cj_wzQ-9KStPXRyTpIC6QbasD7er1d0VYoltJZe9JKkgGjRXqqRV_1yujrFgPQtcJFBpyb49rVd6kDOX6mrKD-wT0Z4wWKkU8pZU_IytY8YKu3vL-hkXQ4pOGmYLscNcahkWN745sImnA"
//
//           "e3at0KG8SnanDwDCPW2sLQ:APA91bEIj62YM_a89ws3N4vZIxVhXtkMLWAFvmUC_Gwq9XTtPZcflGGaITergnylq5cVQdaeDbrbIwACwhuff05GYVlDrcMH7Iwg6dqzosoFbD9UZ2tUPH8O6m1KHDuHFgZGOJynzK-5"
//
//           //"d6x-jDbXQkyKyBOd8Vo6Jz:APA91bEB6mz5b6wz4BiRO76FRTwGMDy6NGyc9ypAo0xhLk_SCr9fFkBLZ8ydyybnE9LI0lJTuaN5mShH-9Wq75pwM8287k2hAZRQHS0Cp_qLtuC22qdELgpNco7bekTLiWIj8xuEHkG4" //await firebaseMessaging.getToken(),
//         },
//       ),
//     );
//
//     final Completer<Map<String, dynamic>> completer =
//     Completer<Map<String, dynamic>>();
// /*
//     firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         completer.complete(message);
//       },
//     );*/
//     return completer.future;
//   }
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

  // Or do other work.
}