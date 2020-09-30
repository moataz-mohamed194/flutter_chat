import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/Widget/RecentChats.dart';
import 'package:flutter_chat_ui_starter/screens/MainPages/Contacts.dart';
import 'package:flutter_chat_ui_starter/screens/MainPages/Favorite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  int index = 0;
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
  changeNumber(int number) {
    index = number;
    print(index);
    notifyListeners();
  }
}
