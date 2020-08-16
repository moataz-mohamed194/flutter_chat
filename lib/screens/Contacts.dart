import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class Contact0 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Contact0();
  }
}

class _Contact0 extends State<Contact0> {
  Iterable<Contact> contacts = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAll();
  }

  getAll() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      var _contacts = await ContactsService.getContacts();
      setState(() {
        contacts = _contacts;
        //Contact numbers = _contacts as Contact;
      });
      print(_contacts);
      print("fffffffffffffffffffffffffff");
      print(_contacts.toList());
      print("dddddddddddddddddddddddddddd");
      print(contacts.length);
    } else {
      print(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.disabled) {
      Map<PermissionGroup, PermissionStatus> permissionStatus =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.contacts]);
      return permissionStatus[PermissionGroup.contacts] ??
          PermissionStatus.unknown;
    } else {
      return permission;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: Column(
          children: <Widget>[
            Text("gggggggggg"),
            Text("${contacts.length}"),
            ListView.builder(
                shrinkWrap: true,
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  //List<Contact> numbers = contacts.toList();
                  Contact contact = contacts?.elementAt(index);
                  //[index];
                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 18),

                    title: Text(contact.displayName ?? ''),
                    subtitle:
                        Text('${contact.phones.elementAt(0).value}' ?? ''),
                    //This can be further expanded to showing contacts detail
                    // onPressed().
                  );
                })
          ],
        )),
      ),
    );
  }
}
