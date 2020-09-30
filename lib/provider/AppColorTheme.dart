import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData lightMode = ThemeData(
  primaryColor: Color(0xffff3e3e),
  accentColor: Color(0xFFFEF9EB),
  textSelectionColor: Colors.black,
  cursorColor: Color(0xFFFEF9EB),
);

ThemeData darkMode = ThemeData(
  primaryColor: Color(0xff330000),
  accentColor: Color(0xff00001a),
  textSelectionColor: Color(0xFFFEF9EB),
  cursorColor: Color(0xff4d4d4d),
);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _preferences;
  bool _darkMode;

  bool get darkMode => _darkMode;

  ThemeNotifier() {
    _darkMode = true;
    _loadFromPreferences();
  }

  _initialPreferences() async {
    if (_preferences == null)
      _preferences = await SharedPreferences.getInstance();
  }

  _savePreferences() async {
    await _initialPreferences();
    _preferences.setBool(key, _darkMode);
  }

  _loadFromPreferences() async {
    await _initialPreferences();
    _darkMode = _preferences.getBool(key) ?? true;
    notifyListeners();
  }

  toggleChangeTheme() {
    _darkMode = !_darkMode;
    _savePreferences();
    notifyListeners();
  }
}
