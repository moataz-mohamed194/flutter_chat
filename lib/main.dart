import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/provider/AppColorTheme.dart';
import 'package:flutter_chat_ui_starter/provider/ContactsProvider.dart';
import 'package:flutter_chat_ui_starter/provider/TextFieldProvider.dart';
import 'package:flutter_chat_ui_starter/provider/oldDataProvider.dart';
import 'Database/SQLDatabase.dart';
import 'Widget/Loading_Screen.dart';
import 'provider/HomeProvider.dart';
import 'provider/LoginProvider.dart';
import 'provider/SignUpProvider.dart';
import 'provider/chatProvider.dart';
import 'screens/LoginAndSignUpPages/Login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/MainPages/home.dart';

Future main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SQLDatabase.db.initDB();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => SignUpProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ContactProvider(),
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
      ChangeNotifierProvider(
        create: (context) => SQLDatabase(),
      ),
      ChangeNotifierProvider(
        create: (context) => ChatProvider(),
      ),
    ],
    child: ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
        //   var data = Provider.of<HomeProvider>(context, listen: true);
        // data.index = 0;
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

//  runApp(LoadingScreen());
}
