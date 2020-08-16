import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/screens/home.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as JSON;
import 'SignUpProvider.dart';

class LoginProvider extends ChangeNotifier {
  ValidationItem _phoneNumber = new ValidationItem(null, null);
  ValidationItem _password = new ValidationItem(null, null);
  ValidationItem get phoneNumber => _phoneNumber;
  ValidationItem get password => _password;
  bool get isValid {
    if (_phoneNumber.value != null && _password.value != null) {
      return true;
    } else {
      return false;
    }
  }

  void changePhoneNumber(String value) {
    if (value.length == 13 && value.contains(RegExp('([0-9])')) == true) {
      _phoneNumber = ValidationItem(value, null);
    } else {
      _phoneNumber = ValidationItem(null, "Enter valid phone number");
    }
    notifyListeners();
  }

  alert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 4,
            backgroundColor: Colors.transparent,
            child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width / 3.5,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).accentColor,
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Message",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Enter your data",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            "Ok",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                )),
          );
        });
  }

  loginFacebook() async {
    final facebookLogin = FacebookLogin();

    final result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(token);
        print(profile);

        break;

      case FacebookLoginStatus.cancelledByUser:
        print("ggg");
        break;
      case FacebookLoginStatus.error:
        print(FacebookLoginStatus.error);
        break;
    }
  }

  void changePassword(String value) {
    bool passwordValid0 = RegExp(r"[a-z]").hasMatch(value);
    bool passwordValid1 = RegExp(r"[A-Z]").hasMatch(value);
    bool passwordValid2 = RegExp(r"[0-9]").hasMatch(value);
    bool passwordValid3 = RegExp(r"[.!#$%&'*+-/=?^_`{|}~]").hasMatch(value);
    if (passwordValid0 == true &&
        passwordValid1 == true &&
        passwordValid2 == true &&
        passwordValid3 == true &&
        value.length >= 6) {
      _password = ValidationItem(value, null);
      ValidationItem(value, null).password = value;
    } else {
      _password =
          ValidationItem(null, "Enter valid password and must be more than 6");
    }
    notifyListeners();
  }

  String _error;
  loginNext(BuildContext context) async {
    if (_phoneNumber.value == null || _password.value == null) {
    } else {
      String convertPhoneToEmail = '${_phoneNumber.value}@gmail.com';
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: convertPhoneToEmail, password: _password.value)
          .whenComplete(() {
        //prefs.setString('login', 'yes');
      }).catchError((e) {
        _error =
            "PlatformException(ERROR_WRONG_PASSWORD, The password is invalid or the user does not have a password., null)";
      }).whenComplete(() async {
        var _firebaseRef = FirebaseDatabase()
            .reference()
            .child('Account')
            .child('${_phoneNumber.value}')
            .once()
            .then((DataSnapshot snapshot) async {
          final value = snapshot.value as Map;
          print("vvvvvvvvvvvvvvvvvvvvvv");
          print("vvvvvvvvvvvvvvvvvvvvvv");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          for (final key in value.keys) {
            print(value);
            // department.add(value[key]['Name']);
            print('${value['Name']}');
            print('${value['Password']}');
            print('${value['PhoneNumber']}');
            print('${value['image']}');
            await prefs.setString('Login', 'Yes');
            await prefs.setString('Name', '${value['Name']}');
            await prefs.setString('Password', '${value['Password']}');
            await prefs.setString('PhoneNumber', '${value['PhoneNumber']}');
            await prefs.setString('image', '${value['image']}');
          }
        });
        ;
        // print(_firebaseRef);
        {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/HomeScreen', (Route<dynamic> route) => false);
        }
      });

      print(_phoneNumber.value);
      print(_password.value.toString());
      notifyListeners();
    }
  }
}
