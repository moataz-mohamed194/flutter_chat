import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_ui_starter/Widget/buttonWidget.dart';
import 'package:flutter_chat_ui_starter/Widget/lineWordWeight.dart';
import 'package:flutter_chat_ui_starter/models/ValidationItem.dart';
import 'package:flutter_chat_ui_starter/screens/Choose_Image.dart';
import 'package:flutter_chat_ui_starter/screens/Login_screen.dart';
import 'package:flutter_chat_ui_starter/screens/SignUp_screen.dart';
import 'package:flutter_chat_ui_starter/screens/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:toast/toast.dart';

class GetNoConnectionWidget extends StatelessWidget {
  final Function onPressed;
  GetNoConnectionWidget({this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 60.0,
        ),
        new Text("No Internet Connection"),
        FlatButton(
            color: Theme.of(context).primaryColor,
            child: new Text(
              "Retry",
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            onPressed: onPressed)
      ],
    );
  }
}
//
//class ValidationItem {
//  final String value;
//  final String error;
//  String name;
//  String email;
//  String password;
//  ValidationItem(this.value, this.error);
//}

class SignUpProvider extends ChangeNotifier {
//  ValidationItem _name = new ValidationItem(null, null);
//  ValidationItem _password = new ValidationItem(null, null);
//  ValidationItem _password2 = new ValidationItem(null, null);
//  ValidationItem _phoneNumber = new ValidationItem(null, null);
  ValidationItem _code = new ValidationItem(null, null);

  File imageFile;
//  ValidationItem get name => _name;
//  ValidationItem get phoneNumber => _phoneNumber;
//  ValidationItem get password => _password;
//  ValidationItem get password2 => _password2;
  ValidationItem get code => _code;
//  bool get isValid {
//    if (_name.value != null &&
//        _phoneNumber.value != null &&
//        _password.value != null &&
//        _password2.value != null) {
//      return true;
//    } else {
//      return false;
//    }
//  }
//
//  void changeName(String value) {
//    if (value.length >= 3 && value.contains(RegExp('([0-9])')) == false) {
//      _name = ValidationItem(value, null);
//    } else {
//      _name = ValidationItem(null, "must be longer and don't have numbers");
//    }
//    notifyListeners();
//  }
//
//  void changePhoneNumber(String value) {
//    bool phoneNumberValid = RegExp("([0-9])").hasMatch(value);
//    if (phoneNumberValid == true && value.length == 13) {
//      _phoneNumber = ValidationItem(value, null);
//    } else {
//      _phoneNumber = ValidationItem(null, "Enter valid phone number");
//    }
//    notifyListeners();
//  }
//
//  bool passwordValid0;
//  bool passwordValid1;
//  bool passwordValid2;
//  bool passwordValid3;
//  void changePassword(String value) {
//    passwordValid0 = RegExp(r"[a-z]").hasMatch(value);
//    passwordValid1 = RegExp(r"[A-Z]").hasMatch(value);
//    passwordValid2 = RegExp(r"[0-9]").hasMatch(value);
//    passwordValid3 = RegExp(r"[.!#$%&'*+-/=?^_`{|}~]").hasMatch(value);
//
//    if (passwordValid0 == true &&
//        passwordValid1 == true &&
//        passwordValid2 == true &&
//        passwordValid3 == true &&
//        value.length >= 6) {
//      _password = ValidationItem(value, null);
//      ValidationItem(value, null).password = value;
//    } else {
//      _password =
//          ValidationItem(null, "the password must be more than 6 digits");
//    }
//    notifyListeners();
//  }
//
//  void changePassword2(String value) {
//    //print(_password.value);
//    // print("sssssssssssssssssssssssssssss");
//    if (_password.value == value) {
//      //print(value);
//      _password2 = ValidationItem(value, null);
//    } else {
//      _password2 = ValidationItem(null, "the passwords are not same");
//    }
//    notifyListeners();
//  }

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

  signUpNext(BuildContext context, var nameD, var phoneNumberD, var passwordD,
      var password2D) {
    if (nameD == null ||
        phoneNumberD == null ||
        passwordD == null ||
        password2D == null) {
    } else {
      signUpUser(nameD, phoneNumberD, passwordD, password2D, context);

      /* Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AuthenticationPhoneNumber(
          name: _name.value,
          phoneNumber: _phoneNumber.value,
          password: _password.value,
          image: imageFile.toString(),
        );
      }));*/
      //loginUser(_phoneNumber.value,context);
      //loginUser('+201289555089', context);

      /*print(imageFile);
      print(_name.value);
      print(_phoneNumber.value);
      print(_password.value.toString());*/
      notifyListeners();
    }
  }

  changecode(String value) {
    _code = ValidationItem(value, null);
    notifyListeners();
  }

  final _codeController = TextEditingController();

  String _error, _convertPhoneToEmail;
  Future<bool> signUpUser(String name, String phone, String password,
      String password2, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    print("hhhh");
    var count = 70;

    Stream<int> counter() async* {
      while (count >= 0) {
        await Future.delayed(Duration(seconds: 1));
        yield count--;
        print(count);
      }
    }

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 20),
        verificationCompleted: (AuthCredential credential) async {
          //Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;
          _convertPhoneToEmail = '$phone@gmail.com';
          if (user != null) {
            await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _convertPhoneToEmail, password: password)
                .whenComplete(() async {
              //     print("added");
              final StorageReference storageReference =
                  FirebaseStorage().ref().child('Profiles').child('$phone.jpg');
              var data = 'Profiles/$phone.jpg';
              final StorageUploadTask uploadTask =
                  storageReference.putData(imageFile.readAsBytesSync());

              final StreamSubscription<StorageTaskEvent> streamSubscription =
                  uploadTask.events.listen((event) {
                print('EVENT ${event.type}');
              });
              final ref = FirebaseStorage().ref().child(data);
              var imageString = await ref.getDownloadURL();
              print("sssssssssssssssssssssssssssss");
              print(imageString);
              print("sssssssssssssssssssssssssssss");
              await uploadTask.onComplete.whenComplete(() async {
                FirebaseDatabase.instance
                    .reference()
                    .child('Account')
                    .child(phone)
                    .set({
                  'PhoneNumber': phone,
                  'Name': name,
                  'Password': password,
                  'image': imageString
                }).whenComplete(() async {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/HomeScreen', (Route<dynamic> route) => false);
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString('Login', 'Yes');
                  Toast.show("That admin is added", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                });
              });
            }).catchError((e) {
              //  print("Erroeee: $e");
              _error =
                  "PlatformException(ERROR_EMAIL_ALREADY_IN_USE, The email address is already in use by another account., null)";
            });
          } else {
            print("Error");
          }
        },
        verificationFailed: (AuthException exception) {
          print(exception.message);
          Toast.show("${exception.message}", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 4,
                  backgroundColor: Theme.of(context).accentColor,
                  child: Container(
                      //padding: EdgeInsets.all(10),
                      //width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
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
                          Text(
                            "Add authentication code",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width / 20),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: TextField(
                                controller: _codeController,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).textSelectionColor),
                                cursorColor:
                                    Theme.of(context).textSelectionColor,
                                autofocus: false,
                                keyboardType: TextInputType.text,
                                onChanged: (vals) {
                                  changecode(vals);
                                },
                                decoration: InputDecoration(
                                  //prefixIcon: textIcon,
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(40.0),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.0)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.0)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2),
                                  ),
//                                hintText: "   $hintText",
                                  helperStyle: TextStyle(
                                      color:
                                          Theme.of(context).textSelectionColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
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
//                          TextButtonWeight(
//                            onTap: () {
//                              if (count > 0) {
//                                print("the code will send after 70 second");
//                                Toast.show("the code will send after 70 second",
//                                    context,
//                                    duration: Toast.LENGTH_SHORT,
//                                    gravity: Toast.BOTTOM);
//                              } else {
//                                Toast.show("the code sent again", context,
//                                    duration: Toast.LENGTH_SHORT,
//                                    gravity: Toast.BOTTOM);
//                                print("the code sent again ");
//                              }
//                            },
//                            buttonText: 'Send activate code again',
//                            buttonSize: 15,
//                            textStyleColor: Color(0xffff3e3e),
//                            weightButton: FontWeight.bold,
//                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.25,
                            child: ButtonWidget(
                                height: 50,
                                color: Theme.of(context).primaryColor,
                                text: "Activate account",
                                borderColor: Theme.of(context).primaryColor,
                                textColor: Theme.of(context).accentColor,
                                onPressed: () async {
                                  final code = _codeController.text.trim();
                                  AuthCredential credential =
                                      PhoneAuthProvider.getCredential(
                                          verificationId: verificationId,
                                          smsCode: code);

                                  AuthResult result = await _auth
                                      .signInWithCredential(credential);

                                  FirebaseUser user = result.user;
                                  _convertPhoneToEmail = '$phone@gmail.com';

                                  //print("dddddddddddddddddddddddddddddddd");
                                  if (user != null) {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: '$phone@gmail.com',
                                            password: password)
                                        .whenComplete(() async {
                                      //     print("added");
                                      final StorageReference storageReference =
                                          FirebaseStorage()
                                              .ref()
                                              .child('Profiles')
                                              .child('$phone.jpg');
                                      var data = 'Profiles/$phone.jpg';
                                      final StorageUploadTask uploadTask =
                                          storageReference.putData(
                                              imageFile.readAsBytesSync());

                                      final StreamSubscription<StorageTaskEvent>
                                          streamSubscription =
                                          uploadTask.events.listen((event) {
                                        print('EVENT ${event.type}');
                                      });
                                      final ref =
                                          FirebaseStorage().ref().child(data);
                                      var imageString =
                                          await ref.getDownloadURL();
                                      print("sssssssssssssssssssssssssssss");
                                      print(imageString);
                                      print("sssssssssssssssssssssssssssss");
                                      await uploadTask.onComplete
                                          .whenComplete(() async {
                                        FirebaseDatabase.instance
                                            .reference()
                                            .child('Account')
                                            .child(phone)
                                            .set({
                                          'PhoneNumber': phone,
                                          'Name': name,
                                          'Password': password,
                                          'image': imageString
                                        }).whenComplete(() async {
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/HomeScreen',
                                                  (Route<dynamic> route) =>
                                                      false);
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          await prefs.setString('Login', 'Yes');
                                          Toast.show(
                                              "That admin is added", context,
                                              duration: Toast.LENGTH_SHORT,
                                              gravity: Toast.BOTTOM);
                                        });
                                      });
                                    }).catchError((e) {
                                      //  print("Erroeee: $e");
                                      _error =
                                          "PlatformException(ERROR_EMAIL_ALREADY_IN_USE, The email address is already in use by another account., null)";
                                    });
                                  } else {
                                    print("Error");
                                  }
                                }),
                          ),
                        ],
                      )),
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  Future<void> openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    imageFile = picture;
    // print(imageFile);
    notifyListeners();
  }

  onChoseImage(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ChooseImage();
        });
  }

  Future<void> openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    imageFile = picture;
    //print(imageFile.toString());
    notifyListeners();
  }

  int counter = 70;
  Timer _timer;

  Page() {
    counter = 70;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (counter > 0) {
        counter--;
        notifyListeners();
      } else {
        _timer.cancel();
      }
    });
  }
}
