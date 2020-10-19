import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeProvider.dart';

class OldDataProvider extends ChangeNotifier {
  String name;
  String password;
  String image;
  //get the name from shared preferences
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('Name');
    password = prefs.getString('Password');
    image = prefs.getString('image');
    notifyListeners();
  }

  File imageFile;
  //check if user want change password, image or name will send that new data to database
  addTheEdit(var imageNew, var passwordNew, var acceptPassword, var nameNew,
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String convertPhoneToEmail = '${await prefs.get('PhoneNumber')}@gmail.com';
    String passwordD = await prefs.get('Password');
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: convertPhoneToEmail, password: passwordD);

    imageFile = imageNew;
    if (imageNew != null) {
      /*final StorageReference storageReference = FirebaseStorage()
          .ref()
          .child('Profiles')
          .child('${prefs.getString('PhoneNumber')}.jpg');*/
      var data = 'Profiles/${prefs.getString('PhoneNumber')}.jpg';
      /*final StorageUploadTask uploadTask =
          storageReference.putData(imageFile.readAsBytesSync());

      final StreamSubscription<StorageTaskEvent> streamSubscription =
          uploadTask.events.listen((event) {
        print('EVENT ${event.type}');
      });*/
      final ref = FirebaseStorage().ref().child(data);
      var imageString = await ref.getDownloadURL();
      await prefs.setString('image', '$imageString');

      print(imageString);
    }
    if (passwordNew != null && acceptPassword == true) {
      var user = await FirebaseAuth.instance.currentUser;

      user.updatePassword(passwordNew).then((_) {
        print("Succesfull changed password");
      }).catchError((error) {
        print("Password can't be changed" + error.toString());
      });
      await prefs.setString('Password', '$passwordNew');

      print(passwordNew);
    }
    if (nameNew != null) {
      await prefs.setString('Name', '$nameNew');
      print(nameNew);
    }
    FirebaseDatabase.instance
        .reference()
        .child('Account')
        .child(await prefs.get('PhoneNumber'))
        .set({
      'PhoneNumber': await prefs.get('PhoneNumber'),
      'Name': await prefs.get('Name'),
      'Password': await prefs.get('Password'),
      'image': await prefs.get('image')
    }).whenComplete(() {
      if (passwordNew != null && acceptPassword == true) {
        HomeProvider().logOut(context);
      }
      if (nameNew != null || imageNew != null) {
        Navigator.of(context).pop();
      }
    });
  }
}
