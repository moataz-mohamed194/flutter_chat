import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/Widget/CategorySelector.dart';
import 'package:flutter_chat_ui_starter/Widget/FloatingButton.dart';
import 'package:flutter_chat_ui_starter/Widget/RecentChats.dart';
import 'package:flutter_chat_ui_starter/provider/HomeProvider.dart';
import 'package:provider/provider.dart';
import 'Contacts.dart';
import 'Favorite.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<HomeProvider>(context, listen: true);

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
      body: Column(
        children: <Widget>[
          CategorySelector(),
          Expanded(
            flex: 1,
            child: data.widgets[data.index],
          ),
        ],
      ),
//      ),
      floatingActionButton: FloatingButton(),
    );
  }
}
