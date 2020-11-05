import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'provider/AppColorTheme.dart';
import 'provider/ContactsProvider.dart';
import 'provider/TextFieldProvider.dart';
import 'provider/oldDataProvider.dart';
import 'screens/mainPage/home.dart';
import 'Database/SQLDatabase.dart';
import 'provider/HomeProvider.dart';
import 'provider/LoginProvider.dart';
import 'provider/SignUpProvider.dart';
import 'provider/chatProvider.dart';
import 'screens/LoginAndSignUpPages/Login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
