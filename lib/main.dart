import 'package:flutter/material.dart';
import 'provider/HomeProvider.dart';
import 'provider/LoginProvider.dart';
import 'provider/SignUpProvider.dart';
import 'screens/Login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('Login') == 'Yes') {
    runApp(StartFromChatScreens());
  } else {
    runApp(StartFromLoginScreens());
  }
}

class StartFromChatScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              primaryColor: Color(0xffff3e3e),
              accentColor: Color(0xFFFEF9EB),
              textSelectionColor: Colors.black),
          routes: <String, WidgetBuilder>{
            '/HomeScreen': (BuildContext context) => new HomeScreen(),
            '/Login': (BuildContext context) => new LoginScreen(),
          },
          home: HomeScreen(),
        ));
  }
}

class StartFromLoginScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          routes: <String, WidgetBuilder>{
            '/HomeScreen': (BuildContext context) => new HomeScreen(),
            '/Login': (BuildContext context) => new LoginScreen(),
          },
          theme: ThemeData(
            primaryColor: Colors.red,
            accentColor: Color(0xFFFEF9EB),
          ),
          home: LoginScreen(),
        ));
  }
}
