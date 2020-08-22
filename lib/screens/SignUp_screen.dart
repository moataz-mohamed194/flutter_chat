import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_ui_starter/Widget/buttonWidget.dart';
import 'package:flutter_chat_ui_starter/Widget/lineWordWeight.dart';
import 'package:flutter_chat_ui_starter/Widget/textfield.dart';
import 'package:flutter_chat_ui_starter/provider/SignUpProvider.dart';
import 'package:flutter_chat_ui_starter/provider/TextFieldProvider.dart';
import 'package:flutter_chat_ui_starter/screens/Authentication_Phone_Number.dart';
import 'package:flutter_chat_ui_starter/screens/Login_screen.dart';
import 'package:flutter_chat_ui_starter/screens/home.dart';
import 'package:provider/provider.dart';

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class SignUp extends StatelessWidget {
/*  final _codeController = TextEditingController();
  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();
          print("ggggggggggggggggggggggggggggg");
          AuthResult result = await _auth.signInWithCredential(credential);
          FirebaseUser user = result.user;
          if (user != null) {
            print("vvvvvvvvvvvvvvvvvvvvvvvvvvv");
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => home()));
          } else {
            print("Error");
          }
        },
        verificationFailed: (AuthException exception) {
          print(exception.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AuthenticationPhoneNumber()));
          final code = _codeController.text.trim();
          AuthCredential credential = PhoneAuthProvider.getCredential(
              verificationId: verificationId, smsCode: code);
          print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
          AuthResult result = await _auth.signInWithCredential(credential);
          FirebaseUser user = result.user;
          if (user != null) {
            print("kkkkkkkkkkkkkkkkkkkk");
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => home()));
          } else {
            print("Error");
          }
        },
        codeAutoRetrievalTimeout: null);
  }
*/
  final _codeController = TextEditingController();

  GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();
  showSnackBar(String data) {
    scaffoldState.currentState.showSnackBar(new SnackBar(
      content: new Text(data),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final addService = Provider.of<SignUpProvider>(context);
    final validationService = Provider.of<TextFieldProvider>(context);
    return SafeArea(
        child: Scaffold(
            key: scaffoldState,
            body: SingleChildScrollView(
              child: Container(
                child: Column(children: <Widget>[
                  Container(
                    height: 250,
                    child: Stack(
                      children: <Widget>[
                        ClipPath(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Theme.of(context).primaryColor,
                          ),
                          clipper: CustomClipPath(),
                        ),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * .85,
                            height: 815,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                            child: Column(children: <Widget>[
                              Text("Welcome!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25)),
                              Text("in our family",
                                  style: TextStyle(fontSize: 17)),
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
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                          height: 120,
                                          width: 120,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(120)),
                                            child:
                                                /* Image.network(
                                                'gs://whatsapp-523f6.appspot.com/Profiles/+201289555089',
                                                height: 120,
                                                width: 120,
                                              ) */
                                                addService.imageFile == null
                                                    ? Container(
                                                        height: 0,
                                                        width: 0,
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
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              addService.onChoseImage(context);
                                            }),
                                      ),
                                    ],
                                  )),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  textFileLogin(
                    hintText: "Your name",
                    errorText: validationService.name.error,
                    textIcon: Icon(Icons.person),
                    cursorColor: Colors.black,
                    borderSideColor: Theme.of(context).primaryColor,
                    textStyleColor: Colors.black,
                    textChange: (vals) {
                      validationService.changeName(vals);
                    },
                    inputType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  textFileLogin(
                    hintText: "Your phone Number",
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
                    hintText: "Your password",
                    errorText: validationService.password.error,
                    textIcon: Icon(Icons.lock),
                    cursorColor: Colors.black,
                    borderSideColor: Theme.of(context).primaryColor,
                    textStyleColor: Colors.black,
                    textChange: (vals) {
                      validationService.changePassword(vals);
                    },
                    obscure: true,
                    inputType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  textFileLogin(
                    hintText: "repeat password",
                    errorText: validationService.password2.error,
                    textIcon: Icon(Icons.repeat),
                    cursorColor: Colors.black,
                    borderSideColor: Theme.of(context).primaryColor,
                    textStyleColor: Colors.black,
                    textChange: (vals) {
                      validationService.changePassword2(vals);
                    },
                    obscure: true,
                    inputType: TextInputType.text,
                  ),
                  Container(
//                alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 8),
                    child: Column(
                      //                crossAxisAlignment: CrossAxisAlignment.center,
                      //              mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            validationService.passwordValid1 != true
                                ? Icon(Icons.clear)
                                : Icon(Icons.done),
                            Text("Password must to have capital Letter")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            validationService.passwordValid0 != true
                                ? Icon(Icons.clear)
                                : Icon(Icons.done),
                            Text("Password must to have small Letter")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            validationService.passwordValid2 != true
                                ? Icon(Icons.clear)
                                : Icon(Icons.done),
                            Text("Password must to have number")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            validationService.passwordValid3 != true
                                ? Icon(Icons.clear)
                                : Icon(Icons.done),
                            Text("Password must to have symbols")
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
                        text: "SIGN UP",
                        borderColor: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).accentColor,
                        onPressed: () {
                          //validationService.loginUser('+201221917976', context);
                          //validationService.loginUser('+201289555089', context);
                          //loginUser('+201221917976', context);
                          /*FirebaseDatabase.instance
                              .reference()
                              .child('000')
                              .push()
                              .set({
                            'PhoneNumber': '_phoneNumber.value',
                            'Name': '_name.value',
                            'Password': '_password.value'
                          });*/
                          (!validationService.signUpIsValid)
                              ? addService.alert(context)
                              : addService.signUpNext(
                                  context,
                                  validationService.nameData.value,
                                  validationService.phoneNumberData.value,
                                  validationService.passwordData.value,
                                  validationService.password2Data.value);
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButtonWeight(
                    onTap: () {
                      print("dd");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    },
                    buttonText: 'I have account',
                    buttonSize: 12,
                    weightButton: FontWeight.bold,
                  ),
                ]),
              ),
            )));
  }
}
