import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_ui_starter/Widget/buttonWidget.dart';
import 'package:flutter_chat_ui_starter/Widget/lineWordWeight.dart';
import 'package:flutter_chat_ui_starter/Widget/textfield.dart';
import 'package:flutter_chat_ui_starter/provider/LoginProvider.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'SignUp_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final validationService = Provider.of<LoginProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xff303c50),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: 500,
              width: MediaQuery.of(context).size.width - 20,
              margin: EdgeInsets.only(
                  right: 10,
                  left: 10,
                  top: MediaQuery.of(context).size.height / 6),
              decoration: BoxDecoration(
                color: Color(0xff626b7a),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                ),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Welcome!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width / 17),
                          ),
                          Text("Login to continue"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    textFileLogin(
                      hintText: "Phone Number",
                      errorText: validationService.phoneNumber.error,
                      textIcon: Icon(Icons.phone),
                      cursorColor: Colors.black,
                      borderSideColor: Theme.of(context).primaryColor,
                      textStyleColor: Colors.black,
                      textChange: (vals) {
                        validationService.changePhoneNumber(vals);
                      },
                      inputType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    textFileLogin(
                      hintText: "Password",
                      errorText: validationService.password.error,
                      textIcon: Icon(Icons.lock),
                      textChange: (vals) {
                        validationService.changePassword(vals);
                      },
                      cursorColor: Colors.black,
                      borderSideColor: Theme.of(context).primaryColor,
                      textStyleColor: Colors.black,
                      obscure: true,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextButtonWeight(
                      onTap: () {
                        print("dd");
                      },
                      textStyleColor: Theme.of(context).primaryColor,
                      buttonText: 'Forget Password?',
                      buttonSize: 12,
                      weightButton: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.25,
                      // margin: EdgeInsets.only(
                      //   bottom: MediaQuery.of(context).size.width / 10),
                      child: ButtonWidget(
                          height: 50,
                          color: Theme.of(context).primaryColor,
                          text: "LOGIN",
                          borderColor: Theme.of(context).primaryColor,
                          textColor: Theme.of(context).accentColor,
                          onPressed: () async {
                            (!validationService.isValid)
                                ? validationService.alert(context)
                                : Provider.of<LoginProvider>(context,
                                        listen: false)
                                    .loginNext(context);
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "New User? ",
                    style: TextStyle(
                        color: Theme.of(context).accentColor, fontSize: 15),
                  ),
                  TextButtonWeight(
                    onTap: () {
                      print("dd");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SignUp();
                      }));
                    },
                    buttonText: 'Sign Up',
                    buttonSize: 15,
                    textStyleColor: Theme.of(context).primaryColor,
                    weightButton: FontWeight.bold,
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/screens/SignUp_screen.dart';

class LoginScreen extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  String phoneNo, verificationId;
  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUp()));
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId, smsCode: code);

                        AuthResult result =
                            await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;

                        if (user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        } else {
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(32),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Login",
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 36,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Mobile Number"),
                controller: _phoneController,
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                child: FlatButton(
                  child: Text("LOGIN"),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(16),
                  onPressed: () {
                    final phone = _phoneController.text.trim();

                    loginUser('+201289555089', context);
                  },
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}*/
/*
class AuthService {
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return DashboardPage();
          } else {
            return LoginScreen();
          }
        });
  }

  signout() {
    FirebaseAuth.instance.signOut();
  }

  signIn(AuthCredential authcreds) {
    FirebaseAuth.instance.signInWithCredential(authcreds);
  }
}

class DashboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DashboardPage0();
  }
}

class DashboardPage0 extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text("signout"),
          onPressed: () {
            AuthService().signout();
          },
        ),
      ),
    );
  }
}
*/
