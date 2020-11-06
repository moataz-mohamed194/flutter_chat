import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../Widget/buttonWidget.dart';
import '../../Widget/lineWordWeight.dart';
import '../../Widget/textfield.dart';
import '../../provider/LoginProvider.dart';
import '../../provider/TextFieldProvider.dart';
import 'package:provider/provider.dart';
import 'SignUp_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final validationService = Provider.of<TextFieldProvider>(context);
    final addService = Provider.of<LoginProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xff303c50),
      body: Center(
        child: SingleChildScrollView(
            child: Container(
          //alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //  crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 500,
                width: MediaQuery.of(context).size.width - 20,
                margin: EdgeInsets.only(
                  right: 10,
                  left: 10,
                  //    top: MediaQuery.of(context).size.height / 10
                ),
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
                                      MediaQuery.of(context).size.width / 17,
                                  color: Theme.of(context).textSelectionColor),
                            ),
                            Text(
                              "Login to continue",
                              style: TextStyle(
                                  color: Theme.of(context).textSelectionColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFileLogin(
                        hintText: "Phone Number",
                        errorText: validationService.phoneNumber.error,
                        textIcon: Icon(
                          Icons.phone,
                          color: Theme.of(context).textSelectionColor,
                        ),
                        cursorColor: Theme.of(context).textSelectionColor,
                        borderSideColor: Theme.of(context).primaryColor,
                        textStyleColor: Theme.of(context).textSelectionColor,
                        textChange: (vals) {
                          validationService.changePhoneNumber(vals);
                        },
                        inputType: TextInputType.phone,
                        hintStyle: TextStyle(
                            color: Theme.of(context).textSelectionColor),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFileLogin(
                        hintText: "Password",
                        errorText: validationService.password.error,
                        textIcon: Icon(
                          Icons.lock,
                          color: Theme.of(context).textSelectionColor,
                        ),
                        textChange: (vals) {
                          validationService.changePassword(vals);
                        },
                        cursorColor: Theme.of(context).textSelectionColor,
                        borderSideColor: Theme.of(context).primaryColor,
                        textStyleColor: Theme.of(context).textSelectionColor,
                        hintStyle: TextStyle(
                            color: Theme.of(context).textSelectionColor),
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
                        buttonSize: 16,
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
                            textColor: Theme.of(context).textSelectionColor,
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
      ),
    );
  }
}
