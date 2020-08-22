import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/Widget/textfield.dart';
import 'package:flutter_chat_ui_starter/provider/LoginProvider.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final validationService = Provider.of<LoginProvider>(context);

    // TODO: implement build
    return SafeArea(
        child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
              title: Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 5.5),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              elevation: 0.0,
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: [],
              ),
            )));
  }
}
