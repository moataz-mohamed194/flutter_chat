import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widget/buttonWidget.dart';
import '../../Widget/lineWordWeight.dart';
import '../../Widget/textfield.dart';
import '../../provider/TextFieldProvider.dart';
import 'package:provider/provider.dart';

var count = 70;

class AuthenticationPhoneNumber extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String image;
  final String password;
  AuthenticationPhoneNumber(
      {this.image, this.name, this.phoneNumber, this.password});
  Stream<int> counter() async* {
    while (count >= 0) {
      await Future.delayed(Duration(seconds: 1));
      yield count--;
      print(count);
    }
  }

  GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();
  showSnackBar(String data) {
    scaffoldState.currentState.showSnackBar(new SnackBar(
      content: new Text(data),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final validationService = Provider.of<TextFieldProvider>(context);

    return Scaffold(
        key: scaffoldState,
        backgroundColor: Color(0xff303c50),
        body: SingleChildScrollView(
            child: Container(
                child: Column(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height / 2,
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
                  child: Column(children: <Widget>[
                    Text(
                      "Add authentication code",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width / 17),
                    ),
                    TextFileLogin(
                      hintText: "",
                      cursorColor: Theme.of(context).textSelectionColor,
                      borderSideColor: Theme.of(context).primaryColor,
                      textStyleColor: Theme.of(context).textSelectionColor,
                      inputType: TextInputType.text,
                      textChange: (vals) {
                        validationService.changecode(vals);
                      },
                    ),
                    StreamBuilder(
                      stream: counter(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return Text(
                            "${snapshot.data.toString()} seconds",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          );
                        } else {
                          return Text(
                            "70 seconds",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          );
                        }
                      },
                    ),
                    TextButtonWeight(
                      onTap: () {
                        if (count > 0) {
                          print("the code will send after 70 second");
                          showSnackBar("the code will send after 70 second");
                        } else {
                          showSnackBar("the code sent again");
                          print("the code sent again ");
                        }
                      },
                      buttonText: 'Send activate code again',
                      buttonSize: 15,
                      textStyleColor: Theme.of(context).primaryColor,
                      weightButton: FontWeight.bold,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.25,
                      child: ButtonWidget(
                          height: 50,
                          color: Theme.of(context).primaryColor,
                          text: "Activate account",
                          borderColor: Theme.of(context).primaryColor,
                          textColor: Theme.of(context).accentColor,
                          onPressed: () {
                            //validationService.loginUser(context);
                            // validationService.loginUser0(context);
                          }),
                    ),
                  ]),
                ))
          ],
        ))));
  }
}
