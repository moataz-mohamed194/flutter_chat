import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/ValidationItem.dart';
import '../Widget/Choose_Image.dart';
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

class SignUpProvider extends ChangeNotifier {
  ValidationItem _code = new ValidationItem(null, null);

  File imageFile;
  ValidationItem get code => _code;
  // alert if there is any wrong will display
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
      alert(context);
    } else {
      signUpUser(nameD, phoneNumberD, passwordD, password2D, context);
      //notifyListeners();
    }
  }

  //check the code the user will enter
  changecode(String value) {
    _code = ValidationItem(value, null);
    notifyListeners();
  }

  // final _codeController = TextEditingController();

  // String _convertPhoneToEmail;
  String error;
  //sign up to add user data to database and when receive code check if code is right or not
  Future<void> signUpUser(String name, String phone, String password,
      String password2, BuildContext context) async {
    print("hhhh");
    // var count = 70;

   /* Stream<int> counter() async* {
      while (count >= 0) {
        await Future.delayed(Duration(seconds: 1));
        yield count--;
        print(count);
      }
    }*/
    if(imageFile!=null){

    final StorageReference storageReference =
                  FirebaseStorage().ref().child('Profiles').child('$phone.jpg');
              var data = 'Profiles/$phone.jpg';
              final StorageUploadTask uploadTask =
                  storageReference.putData(imageFile.readAsBytesSync());
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
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString('Name', '$name');
                  await prefs.setString('Password', '$password');
                  await prefs.setString('PhoneNumber', '$phone');
                  await prefs.setString('image', '$imageString');

                  await prefs.setString('Login', 'Yes');
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/HomeScreen', (Route<dynamic> route) => false);

                  Toast.show("That admin is added", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                });
              });}else{
      FirebaseDatabase.instance
          .reference()
          .child('Account')
          .child(phone)
          .set({
        'PhoneNumber': phone,
        'Name': name,
        'Password': password,
        'image': 'https://firebasestorage.googleapis.com/v0/b/whatsapp-523f6.appspot.com/o/Profiles%2Fempty.png?alt=media&token=22ba5c0f-00d3-491d-971d-dfc0c0112b31'
      }).whenComplete(() async {
        SharedPreferences prefs =
        await SharedPreferences.getInstance();
        await prefs.setString('Login', 'Yes');
        await prefs.setString('Name', '$name');
        await prefs.setString('Password', '$password');
        await prefs.setString('PhoneNumber', '$phone');
        await prefs.setString('image', 'https://firebasestorage.googleapis.com/v0/b/whatsapp-523f6.appspot.com/o/Profiles%2Fempty.png?alt=media&token=22ba5c0f-00d3-491d-971d-dfc0c0112b31');
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/HomeScreen', (Route<dynamic> route) => false);

        Toast.show("That admin is added", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      });

    }

    // FirebaseAuth auth = FirebaseAuth.instance;
    // await auth.verifyPhoneNumber(
    //   phoneNumber: "+201006138028",
    //   verificationCompleted: (PhoneAuthCredential credential) async {
    //     print("verificationCompleted");
    //     await auth.signInWithCredential(credential);
    //   },
    //   verificationFailed: (FirebaseAuthException e) {
    //     print("verificationFailed");
    //     if (e.code == 'invalid-phone-number') {
    //       print('The provided phone number is not valid.');
    //     }
    //   },
    //   codeSent: (String verificationId, int resendToken) async {
    //     print("codeSent");
    //     // Update the UI - wait for the user to enter the SMS code
    //     String smsCode = 'xxxx';
    //
    //     // Create a PhoneAuthCredential with the code
    //     PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    //
    //     // Sign the user in (or link) with the credential
    //     await auth.signInWithCredential(phoneAuthCredential);
    //
    //   },
    //   codeAutoRetrievalTimeout: (String verificationId) {
    //     print("codeAutoRetrievalTimeout");
    //   },
    //   timeout: const Duration(seconds: 60),
    //
    // );


    // _auth.verifyPhoneNumber(
    //     phoneNumber: phone,
    //     timeout: Duration(seconds: 20),
    //     verificationCompleted: (AuthCredential credential) async {
    //       var result = await _auth.signInWithCredential(credential);
    //
    //       FirebaseUser user = result.user;
    //       _convertPhoneToEmail = '$phone@gmail.com';
    //       if (user != null) {
    //         await FirebaseAuth.instance
    //             .createUserWithEmailAndPassword(
    //                 email: _convertPhoneToEmail, password: password)
    //             .whenComplete(() async {
    //           final StorageReference storageReference =
    //               FirebaseStorage().ref().child('Profiles').child('$phone.jpg');
    //           var data = 'Profiles/$phone.jpg';
    //           final StorageUploadTask uploadTask =
    //               storageReference.putData(imageFile.readAsBytesSync());
    //           final ref = FirebaseStorage().ref().child(data);
    //           var imageString = await ref.getDownloadURL();
    //           print("sssssssssssssssssssssssssssss");
    //           print(imageString);
    //           print("sssssssssssssssssssssssssssss");
    //           await uploadTask.onComplete.whenComplete(() async {
    //             FirebaseDatabase.instance
    //                 .reference()
    //                 .child('Account')
    //                 .child(phone)
    //                 .set({
    //               'PhoneNumber': phone,
    //               'Name': name,
    //               'Password': password,
    //               'image': imageString
    //             }).whenComplete(() async {
    //               Navigator.of(context).pushNamedAndRemoveUntil(
    //                   '/HomeScreen', (Route<dynamic> route) => false);
    //               SharedPreferences prefs =
    //                   await SharedPreferences.getInstance();
    //               await prefs.setString('Login', 'Yes');
    //               Toast.show("That admin is added", context,
    //                   duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    //             });
    //           });
    //         }).catchError((e) {
    //           error =
    //               "PlatformException(ERROR_EMAIL_ALREADY_IN_USE, The email address is already in use by another account., null)";
    //         });
    //       } else {
    //         print("Error");
    //       }
    //     },
    //     verificationFailed: (var exception) {
    //       print(exception.message);
    //       Toast.show("${exception.message}", context,
    //           duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    //     },
    //     codeSent: (String verificationId, [int forceResendingToken]) {
    //       showDialog(
    //           context: context,
    //           barrierDismissible: false,
    //           builder: (context) {
    //             return Dialog(
    //               shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(20)),
    //               elevation: 4,
    //               backgroundColor: Theme.of(context).accentColor,
    //               child: Container(
    //                   height: MediaQuery.of(context).size.height / 3,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(20),
    //                     color: Theme.of(context).accentColor,
    //                   ),
    //                   child: Column(
    //                     children: <Widget>[
    //                       Row(
    //                         crossAxisAlignment: CrossAxisAlignment.end,
    //                         mainAxisAlignment: MainAxisAlignment.end,
    //                         children: <Widget>[
    //                           IconButton(
    //                               icon: Icon(
    //                                 Icons.close,
    //                                 size: 30,
    //                               ),
    //                               onPressed: () {
    //                                 Navigator.pop(context);
    //                               }),
    //                         ],
    //                       ),
    //                       Text(
    //                         "Add authentication code",
    //                         style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize:
    //                                 MediaQuery.of(context).size.width / 20),
    //                       ),
    //                       Container(
    //                           width: MediaQuery.of(context).size.width / 2.5,
    //                           child: TextField(
    //                             controller: _codeController,
    //                             style: TextStyle(
    //                                 color:
    //                                     Theme.of(context).textSelectionColor),
    //                             cursorColor:
    //                                 Theme.of(context).textSelectionColor,
    //                             autofocus: false,
    //                             keyboardType: TextInputType.text,
    //                             onChanged: (vals) {
    //                               changecode(vals);
    //                             },
    //                             decoration: InputDecoration(
    //                               border: new OutlineInputBorder(
    //                                 borderRadius: const BorderRadius.all(
    //                                   const Radius.circular(40.0),
    //                                 ),
    //                               ),
    //                               enabledBorder: OutlineInputBorder(
    //                                 borderRadius:
    //                                     BorderRadius.all(Radius.circular(40.0)),
    //                                 borderSide: BorderSide(
    //                                     color: Theme.of(context).primaryColor,
    //                                     width: 2),
    //                               ),
    //                               focusedBorder: OutlineInputBorder(
    //                                 borderRadius:
    //                                     BorderRadius.all(Radius.circular(40.0)),
    //                                 borderSide: BorderSide(
    //                                     color: Theme.of(context).primaryColor,
    //                                     width: 2),
    //                               ),
    //                               helperStyle: TextStyle(
    //                                   color:
    //                                       Theme.of(context).textSelectionColor,
    //                                   fontWeight: FontWeight.bold),
    //                             ),
    //                           )),
    //                       StreamBuilder(
    //                         stream: counter(),
    //                         builder: (context, snapshot) {
    //                           if (snapshot.data != null) {
    //                             return Text(
    //                               "${snapshot.data.toString()} seconds",
    //                               style: TextStyle(
    //                                 fontSize: 15,
    //                               ),
    //                             );
    //                           } else {
    //                             return Text(
    //                               "70 seconds",
    //                               style: TextStyle(
    //                                 fontSize: 15,
    //                               ),
    //                             );
    //                           }
    //                         },
    //                       ),
    //                       Container(
    //                         width: MediaQuery.of(context).size.width / 1.25,
    //                         child: ButtonWidget(
    //                             height: 50,
    //                             color: Theme.of(context).primaryColor,
    //                             text: "Activate account",
    //                             borderColor: Theme.of(context).primaryColor,
    //                             textColor: Theme.of(context).accentColor,
    //                             onPressed: () async {
    //                               final code = _codeController.text.trim();
    //                               AuthCredential credential =
    //                                   PhoneAuthProvider.getCredential(
    //                                       verificationId: verificationId,
    //                                       smsCode: code);
    //
    //                               var result = await _auth
    //                                   .signInWithCredential(credential);
    //
    //                               FirebaseUser user = result.user;
    //                               _convertPhoneToEmail = '$phone@gmail.com';
    //
    //                               if (user != null) {
    //                                 await FirebaseAuth.instance
    //                                     .createUserWithEmailAndPassword(
    //                                         email: '$phone@gmail.com',
    //                                         password: password)
    //                                     .whenComplete(() async {
    //                                   final StorageReference storageReference =
    //                                       FirebaseStorage()
    //                                           .ref()
    //                                           .child('Profiles')
    //                                           .child('$phone.jpg');
    //                                   var data = 'Profiles/$phone.jpg';
    //                                   final StorageUploadTask uploadTask =
    //                                       storageReference.putData(
    //                                           imageFile.readAsBytesSync());
    //
    //                                   /*final StreamSubscription<StorageTaskEvent>
    //                                       streamSubscription =
    //                                       uploadTask.events.listen((event) {
    //                                     print('EVENT ${event.type}');
    //                                   });*/
    //                                   final ref =
    //                                       FirebaseStorage().ref().child(data);
    //                                   var imageString =
    //                                       await ref.getDownloadURL();
    //                                   print("sssssssssssssssssssssssssssss");
    //                                   print(imageString);
    //                                   print("sssssssssssssssssssssssssssss");
    //                                   await uploadTask.onComplete
    //                                       .whenComplete(() async {
    //                                     FirebaseDatabase.instance
    //                                         .reference()
    //                                         .child('Account')
    //                                         .child(phone)
    //                                         .set({
    //                                       'PhoneNumber': phone,
    //                                       'Name': name,
    //                                       'Password': password,
    //                                       'image': imageString
    //                                     }).whenComplete(() async {
    //                                       Navigator.of(context)
    //                                           .pushNamedAndRemoveUntil(
    //                                               '/HomeScreen',
    //                                               (Route<dynamic> route) =>
    //                                                   false);
    //                                       SharedPreferences prefs =
    //                                           await SharedPreferences
    //                                               .getInstance();
    //                                       await prefs.setString('Login', 'Yes');
    //                                       Toast.show(
    //                                           "That admin is added", context,
    //                                           duration: Toast.LENGTH_SHORT,
    //                                           gravity: Toast.BOTTOM);
    //                                     });
    //                                   });
    //                                 }).catchError((e) {
    //                                   error =
    //                                       "PlatformException(ERROR_EMAIL_ALREADY_IN_USE, The email address is already in use by another account., null)";
    //                                 });
    //                               } else {
    //                                 print("Error");
    //                               }
    //                             }),
    //                       ),
    //                     ],
    //                   )),
    //             );
    //           });
    //     },
    //     codeAutoRetrievalTimeout: null);
  }

  //open gallery to choose between pics in gallery
  Future<void> openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    imageFile = picture;
    notifyListeners();
  }

  onChoseImage(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ChooseImage();
        });
  }

  //open camera to take pic
  Future<void> openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    imageFile = picture;
    notifyListeners();
  }

  int counter = 70;
  Timer _timer;
  //is the counter when be zero send code again
  page() {
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
