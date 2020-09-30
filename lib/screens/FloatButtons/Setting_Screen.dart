import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/Widget/buttonWidget.dart';
import 'package:flutter_chat_ui_starter/Widget/textfield.dart';
import 'package:flutter_chat_ui_starter/provider/SignUpProvider.dart';
import 'package:flutter_chat_ui_starter/provider/TextFieldProvider.dart';
import 'package:flutter_chat_ui_starter/provider/oldDataProvider.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addService = Provider.of<SignUpProvider>(context);
    final validationService = Provider.of<TextFieldProvider>(context);
    final getOldData = Provider.of<OldDataProvider>(context);
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
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                        height: 130,
                        width: 200,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 10,
                              left: 40,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).accentColor,
                                ),
                                height: 120,
                                width: 120,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(120)),
                                  child: addService.imageFile == null
                                      ? Image.network(
                                          getOldData.image,
                                          height: 120,
                                          width: 120,
                                        )
                                      : Image.file(
                                          addService.imageFile,
                                          height: 120,
                                          width: 120,
                                        ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 15,
                              right: 25,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.control_point,
                                    size: 35,
                                    color: Theme.of(context).textSelectionColor,
                                  ),
                                  onPressed: () {
                                    addService.onChoseImage(context);
                                  }),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    TextFileLogin(
                        hintText: "Your name",
                        errorText: validationService.name.error,
                        textIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).textSelectionColor,
                        ),
                        borderSideColor: Theme.of(context).primaryColor,
                        textStyleColor: Theme.of(context).textSelectionColor,
                        cursorColor: Theme.of(context).textSelectionColor,
                        textChange: (vals) {
                          validationService.changeName(vals);
                        },
                        inputType: TextInputType.text,
                        hintStyle: TextStyle(
                            color: Theme.of(context).textSelectionColor),
                        oldData: getOldData.name),
                    SizedBox(
                      height: 20,
                    ),
                    TextFileLogin(
                      hintText: "Current password",
                      errorText: validationService.currentPassword.error,
                      textIcon: Icon(
                        Icons.lock,
                        color: Theme.of(context).textSelectionColor,
                      ),
                      borderSideColor: Theme.of(context).primaryColor,
                      textStyleColor: Theme.of(context).textSelectionColor,
                      cursorColor: Theme.of(context).textSelectionColor,
                      textChange: (vals) {
                        validationService.changeCurrentPassword(vals);
                      },
                      obscure: true,
                      inputType: TextInputType.text,
                      hintStyle: TextStyle(
                          color: Theme.of(context).textSelectionColor),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFileLogin(
                      hintText: "New password",
                      errorText: validationService.password.error,
                      textIcon: Icon(
                        Icons.lock,
                        color: Theme.of(context).textSelectionColor,
                      ),
                      textStyleColor: Theme.of(context).textSelectionColor,
                      cursorColor: Theme.of(context).textSelectionColor,
                      borderSideColor: Theme.of(context).primaryColor,
                      textChange: (vals) {
                        validationService.changePassword(vals);
                      },
                      obscure: true,
                      inputType: TextInputType.text,
                      hintStyle: TextStyle(
                          color: Theme.of(context).textSelectionColor),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFileLogin(
                      hintText: "repeat new password",
                      errorText: validationService.password2.error,
                      textIcon: Icon(
                        Icons.repeat,
                        color: Theme.of(context).textSelectionColor,
                      ),
                      textStyleColor: Theme.of(context).textSelectionColor,
                      cursorColor: Theme.of(context).textSelectionColor,
                      borderSideColor: Theme.of(context).primaryColor,
                      textChange: (vals) {
                        validationService.changePassword2(vals);
                      },
                      obscure: true,
                      inputType: TextInputType.text,
                      hintStyle: TextStyle(
                          color: Theme.of(context).textSelectionColor),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 8),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              validationService.passwordValid1 != true
                                  ? Icon(
                                      Icons.clear,
                                      color:
                                          Theme.of(context).textSelectionColor,
                                    )
                                  : Icon(
                                      Icons.done,
                                      color:
                                          Theme.of(context).textSelectionColor,
                                    ),
                              Text("Password must to have capital Letter",
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).textSelectionColor))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              validationService.passwordValid0 != true
                                  ? Icon(
                                      Icons.clear,
                                      color:
                                          Theme.of(context).textSelectionColor,
                                    )
                                  : Icon(
                                      Icons.done,
                                      color:
                                          Theme.of(context).textSelectionColor,
                                    ),
                              Text("Password must to have small Letter",
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).textSelectionColor))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              validationService.passwordValid2 != true
                                  ? Icon(
                                      Icons.clear,
                                      color:
                                          Theme.of(context).textSelectionColor,
                                    )
                                  : Icon(
                                      Icons.done,
                                      color:
                                          Theme.of(context).textSelectionColor,
                                    ),
                              Text("Password must to have number",
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).textSelectionColor))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              validationService.passwordValid3 != true
                                  ? Icon(
                                      Icons.clear,
                                      color:
                                          Theme.of(context).textSelectionColor,
                                    )
                                  : Icon(
                                      Icons.done,
                                      color:
                                          Theme.of(context).textSelectionColor,
                                    ),
                              Text(
                                "Password must to have symbols",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).textSelectionColor),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.25,
                      child: ButtonWidget(
                          height: 50,
                          color: Theme.of(context).primaryColor,
                          text: "Add Edit",
                          borderColor: Theme.of(context).primaryColor,
                          textColor: Theme.of(context)
                              .textSelectionColor, //Theme.of(context).accentColor,
                          onPressed: () {
                            getOldData.addTheEdit(
                                addService.imageFile,
                                validationService.passwordData.value,
                                validationService.boolEdit,
                                validationService.nameData.value,
                                context);
//                           (!validationService.signUpIsValid)
//                              ? addService.alert(context)
//                              : addService.signUpNext(
//                              context,
//                              validationService.nameData.value,
//                              validationService.phoneNumberData.value,
//                              validationService.passwordData.value,
//                              validationService.password2Data.value);
                          }),
                    ),
                  ],
                ),
              ),
            )));
  }
}
