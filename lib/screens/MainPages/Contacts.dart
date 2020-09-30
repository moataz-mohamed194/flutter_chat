import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Contact0 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Contact0();
  }
}

class _Contact0 extends State<Contact0> {
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  Map<String, Color> contactsColorMap = new Map();

  @override
  void initState() {
    super.initState();
    getPermissions();
  }

  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      getAllContacts();
    }
  }

//  String flattenPhoneNumber(String phoneStr) {
//    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
//      return m[0] == "+" ? "+" : "";
//    });
//  }

  getAllContacts() async {
    List colors = [Colors.green, Colors.indigo, Colors.yellow, Colors.orange];
    int colorIndex = 0;
    List<Contact> _contacts =
        (await ContactsService.getContacts(withThumbnails: false)).toList();
    _contacts.forEach((contact) {
      Color baseColor = colors[colorIndex];
      contactsColorMap[contact.displayName] = baseColor;
      colorIndex++;
      if (colorIndex == colors.length) {
        colorIndex = 0;
      }
    });
    setState(() {
      contacts = _contacts;
    });

/*
  var data = new Map();

    for (int i = 0; i < contacts.length; i++) {
      Contact contact = contacts[i];
      data[i]['Name'] = contact.displayName;
      data[i]['Name'] =
          contact.phones.length > 0 ? contact.phones.elementAt(0).value : '';
    }
    print(data);*/
  }

  @override
  Widget build(BuildContext context) {
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
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            Contact contact = contacts[index];

            return contact.phones.length > 0
                ? ListTile(
                    title: Text(
                      contact.displayName == null ? '' : contact.displayName,
                      style: TextStyle(
                          color: Theme.of(context).textSelectionColor),
                    ),
                    subtitle: Text(
                        contact.phones.length > 0
                            ? contact.phones.elementAt(0).value
                            : '',
                        style: TextStyle(
                            color: Theme.of(context).textSelectionColor)),
                  )
                : Container();
          },
        ),
      ),
    );
  }
}
