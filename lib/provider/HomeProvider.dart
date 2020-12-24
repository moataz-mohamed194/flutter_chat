import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/Pages/Contacts.dart';
import '../screens/Pages/Favorite.dart';
import '../screens/Pages/RecentChats.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider with ChangeNotifier  {
  int index0 = 0;
  restartIndex() {
    this.index0 = 0;
  }
  final FirebaseMessaging _fcm = FirebaseMessaging();

  String d0;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  Future<void> logOut(BuildContext context) async {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/Login', (Route<dynamic> route) => false);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('Login', 'No');
  }

  List<Widget> widgets = <Widget>[
    Container(
      child: RecentChats(),
    ),
    Container(
      child: Contact0(),
    ),
    Container(
      child: Favorite(),
    )
  ];
  changeNumber(int number) async {
    index0 = number;
    print(index0);
    notifyListeners();
  }
  void getMainData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.d0 = prefs.get('PhoneNumber').toString();

      String fcmToken = await _fcm.getToken();
      print("your number: $d0");
      print("token:$fcmToken");

      FirebaseDatabase.instance
          .reference()
          .child('Account').child(this.d0).update(
          {"Token": fcmToken});
      print("your number: $d0");
      print("token:$fcmToken");
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );

      print('User granted permission: ${settings.authorizationStatus}');
// Get any messages which caused the application to open from
      // a terminated state.
      messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );
    } catch (e) {
      print("error: $e");
    }

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
// Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    print(initialMessage);
    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['type'] == 'chat') {
        print(message);
      }
      print("000000000$message");
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    print("ssss$_firebaseMessagingBackgroundHandler");

    // notifyListeners();
  }
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    //await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }



}
