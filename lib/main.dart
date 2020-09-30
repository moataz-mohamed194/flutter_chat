import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/provider/AppColorTheme.dart';
import 'package:flutter_chat_ui_starter/provider/TextFieldProvider.dart';
import 'package:flutter_chat_ui_starter/provider/oldDataProvider.dart';
import 'provider/HomeProvider.dart';
import 'provider/LoginProvider.dart';
import 'provider/SignUpProvider.dart';
import 'screens/LoginAndSignUpPages/Login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/MainPages/home.dart';

Future main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => SignUpProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => HomeProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => LoginProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => TextFieldProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => OldDataProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeNotifier(),
      ),
    ],
    child: ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chat',
          theme: notifier.darkMode ? darkMode : lightMode,
          routes: <String, WidgetBuilder>{
            '/HomeScreen': (BuildContext context) => new HomeScreen(),
            '/Login': (BuildContext context) => new LoginScreen(),
          },
          home:
              prefs.getString('Login') == 'Yes' ? HomeScreen() : LoginScreen(),
        );
      }),
    ),
  ));
}
