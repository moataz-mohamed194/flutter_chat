import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'HomeProvider.dart';
import 'TextFieldProvider.dart';

class LoginProvider extends ChangeNotifier {
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
//
//  loginFacebook() async {
//    final facebookLogin = FacebookLogin();
//
//    final result = await facebookLogin.logInWithReadPermissions(['email']);
//
//    switch (result.status) {
//      case FacebookLoginStatus.loggedIn:
//        final token = result.accessToken.token;
//        final graphResponse = await http.get(
//            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
//        final profile = JSON.jsonDecode(graphResponse.body);
//        print(token);
//        print(profile);
//
//        break;
//
//      case FacebookLoginStatus.cancelledByUser:
//        print("ggg");
//        break;
//      case FacebookLoginStatus.error:
//        print(FacebookLoginStatus.error);
//        break;
//    }
//  }

  loginNext(BuildContext context, var phoneNumberD, var passwordD) async {
    if (phoneNumberD == null || passwordD == null) {
      print(TextFieldProvider().phoneNumberData.value);
      print(TextFieldProvider().passwordData.value);
      alert(context);
    } else {
      String convertPhoneToEmail = '$phoneNumberD@gmail.com';
      //try {
      //   await FirebaseAuth.instance.signInWithEmailAndPassword(
      //       email: convertPhoneToEmail, password: passwordD);
        FirebaseDatabase()
            .reference()
            .child('Account')
            .child('$phoneNumberD')
            .once()
            .then((DataSnapshot snapshot) async {
          final value = snapshot.value as Map;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          try{
          for (final key in value.keys) {
            if(passwordD==value['Password']){
              await prefs.setString('Login', 'Yes');
              await prefs.setString('Name', '${value['Name']}');
              await prefs.setString('Password', '${value['Password']}');
              await prefs.setString('PhoneNumber', '${value['PhoneNumber']}');
              await prefs.setString('image', '${value['image']}');
//final data = Provider.of<HomeProvider>(context);
              HomeProvider q = new HomeProvider();
              q.restartIndex();

              Provider.of<HomeProvider>(context, listen: false).index0 = 0;
              //Provider.of<SQLDatabase>(context, listen: false).cleanTables();
              print("ddddddddddddddddddddddddddd");
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/HomeScreen', (Route<dynamic> route) => false);

            }
            else{
              Toast.show('Wrong password provided for that user.', context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

            }
            }}catch(e){
            Toast.show('not found user.', context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

          }
        });
        // } catch (e) {
        // print(e);
        /*if (e.code == 'user-not-found') {
          print('No user found for that email.');
          Toast.show('No user found for that phone number.', context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          Toast.show('Wrong password provided for that user.', context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }else{

          Toast.show('$e.', context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }*/
       // }
    }
  }
}
