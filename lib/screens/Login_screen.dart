import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_ui_starter/Widget/buttonWidget.dart';
import 'package:flutter_chat_ui_starter/Widget/lineWordWeight.dart';
import 'package:flutter_chat_ui_starter/Widget/textfield.dart';
import 'package:flutter_chat_ui_starter/provider/LoginProvider.dart';
import 'package:flutter_chat_ui_starter/provider/TextFieldProvider.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'SignUp_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final validationService = Provider.of<TextFieldProvider>(context);
    final addService = Provider.of<LoginProvider>(context);
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
                            (!validationService.signInIsValid)
                                ? addService.alert(context)
                                : addService.loginNext(
                                    context,
                                    validationService.phoneNumberData.value,
                                    validationService.passwordData.value);
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
