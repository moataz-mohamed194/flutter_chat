import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// colors of the app in light style
ThemeData lightMode = ThemeData(
    primaryColor: Color(0xffff3e3e),
    accentColor: Color(0xFFFEF9EB),
    textSelectionColor: Colors.black,
    cursorColor: Color(0xFFFEF9EB),
    cardColor: Color(0xFFFFEFEE));
// colors of the app in dark style
ThemeData darkMode = ThemeData(
    primaryColor: Color(0xff330000),
    accentColor: Color(0xff00001a),
    textSelectionColor: Color(0xFFFEF9EB),
    cursorColor: Color(0xff4d4d4d),
    cardColor: Color(0xFF000033));

class ThemeNotifier extends ChangeNotifier {
  //name of shared preferences
  final String key = "theme";
  // implement the shared preference
  SharedPreferences _preferences;
  // value of display dark mode or not
  bool _darkMode;
  //the get for _darkMode values
  bool get darkMode => _darkMode;
  //the contractor for change _darkMode values and display shared preference
  ThemeNotifier() {
    _darkMode = true;
    _loadFromPreferences();
  }
  //to full implementation shared preferences
  _initialPreferences() async {
    if (_preferences == null)
      _preferences = await SharedPreferences.getInstance();
  }

  // to the values saved in the shared preferences to new one
  _savePreferences() async {
    await _initialPreferences();
    _preferences.setBool(key, _darkMode);
  }

  // to get the values saved in the shared preferences
  _loadFromPreferences() async {
    await _initialPreferences();
    _darkMode = _preferences.getBool(key) ?? true;
    notifyListeners();
  }

  // to switch the values saved in the shared preferences to new one
  toggleChangeTheme() {
    _darkMode = !_darkMode;
    _savePreferences();
    notifyListeners();
  }
}
