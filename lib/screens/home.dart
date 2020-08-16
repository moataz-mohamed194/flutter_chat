import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/Widget/CategorySelector.dart';
import 'package:flutter_chat_ui_starter/Widget/FloatingButton.dart';
import 'package:flutter_chat_ui_starter/Widget/RecentChats.dart';
import 'package:flutter_chat_ui_starter/provider/HomeProvider.dart';
import 'package:provider/provider.dart';

import 'Contacts.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreen0();
  }
}

class HomeScreen0 extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          'Chats',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            CategorySelector(),
            Text("${data.index}"),
            Expanded(
              flex: 1,
              child: Container(
                child: Stack(
                  children: <Widget>[data.widgets[data.index]],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingButton(),
    );
  }
}
