import 'package:flutter/cupertino.dart';
import '../models/ValidationItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextFieldProvider extends ChangeNotifier {
  ValidationItem nameData = new ValidationItem(null, null);
  ValidationItem passwordData = new ValidationItem(null, null);
  ValidationItem password2Data = new ValidationItem(null, null);
  ValidationItem phoneNumberData = new ValidationItem(null, null);
  ValidationItem codeData = new ValidationItem(null, null);
  ValidationItem get name => nameData;
  ValidationItem get phoneNumber => phoneNumberData;
  ValidationItem get password => passwordData;
  ValidationItem get password2 => password2Data;
  ValidationItem get code => codeData;
  ValidationItem currentPassword = new ValidationItem(null, null);
  ValidationItem get cPassword => currentPassword;
  bool get boolEdit {
    if (currentPassword.value != null &&
        passwordData.value != null &&
        password2Data.value != null) {
      return true;
    } else {
      return false;
    }
  }

  changeCurrentPassword(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String password = prefs.getString('Password');
    if (password == value) {
      currentPassword = ValidationItem(value, null);
    } else {
      currentPassword =
          ValidationItem(null, "password not the same your current password");
    }
    notifyListeners();
  }

  //to check if full data is added in sign up
  bool get signUpIsValid {
    if (nameData.value != null &&
        phoneNumberData.value != null &&
        passwordData.value != null &&
        password2Data.value != null) {
      return true;
    } else {
      return false;
    }
  }

  //to check if full data is added in sign in
  bool get signInIsValid {
    if (phoneNumberData.value != null && passwordData.value != null) {
      return true;
    } else {
      return false;
    }
  }

  //validation of name the user add it
  void changeName(String value) {
    if (value.length >= 3 && value.contains(RegExp('([0-9])')) == false) {
      nameData = ValidationItem(value, null);
    } else {
      nameData = ValidationItem(null, "must be longer and don't have numbers");
    }
    notifyListeners();
  }

  // validation of phone number to the user add it
  void changePhoneNumber(String value) {
    bool phoneNumberValid = RegExp("([0-9])").hasMatch(value);
    if (phoneNumberValid == true && value.length == 13) {
      phoneNumberData = ValidationItem(value, null);
    } else {
      phoneNumberData = ValidationItem(null, "Enter valid phone number");
    }

    notifyListeners();
  }

  //bool values to check if password user validated
  bool passwordValid0;
  bool passwordValid1;
  bool passwordValid2;
  bool passwordValid3;
  //validation the user password entered have small char, chape  char, special mark and number
  void changePassword(String value) {
    passwordValid0 = RegExp(r"[a-z]").hasMatch(value);
    passwordValid1 = RegExp(r"[A-Z]").hasMatch(value);
    passwordValid2 = RegExp(r"[0-9]").hasMatch(value);
    passwordValid3 = RegExp(r"[.!#$%&'*+-/=?^_`{|}~]").hasMatch(value);
    if (passwordValid0 == true &&
        passwordValid1 == true &&
        passwordValid2 == true &&
        passwordValid3 == true &&
        value.length >= 6) {
      passwordData = ValidationItem(value, null);
      ValidationItem(value, null).password = value;
    } else {
      passwordData =
          ValidationItem(null, "the password must be more than 6 digits");
    }

    notifyListeners();
  }

  void changePassword2(String value) {
    if (passwordData.value == value) {
      password2Data = ValidationItem(value, null);
    } else {
      password2Data = ValidationItem(null, "the passwords are not same");
    }
    notifyListeners();
  }

  //check the code the user will enter
  changecode(String value) {
    codeData = ValidationItem(value, null);
    notifyListeners();
  }
}
