import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/Database/SQLDatabase.dart';
import 'package:flutter_chat_ui_starter/models/phonesnumber.dart';
import 'package:flutter_chat_ui_starter/provider/ContactsProvider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Contact0 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final contactProvider = Provider.of<ContactProvider>(context);
    final contactProvider = Provider.of<SQLDatabase>(context);

    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: StreamBuilder<List>(
              initialData: List(),
              stream: contactProvider.getAllProducts().asStream(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, int position) {
                          var _data = contactProvider.results;
                          return ListTile(
                              title: Text(_data[position].row[1]),
                              subtitle: Text(_data[position].row[2]),
                              leading: Container(
                                  child: Container(
                                width: MediaQuery.of(context).size.width /
                                    7.854545455,
                                height: MediaQuery.of(context).size.height /
                                    7.854545455,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(120)),
                                  child: Image.network(_data[position].row[3]),
                                ),
                              )));
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            )));
  }
}
