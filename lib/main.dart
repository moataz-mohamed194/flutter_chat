import 'package:flutter/material.dart';
import 'package:flutter_chat_ui_starter/provider/TextFieldProvider.dart';
import 'provider/HomeProvider.dart';
import 'provider/LoginProvider.dart';
import 'provider/SignUpProvider.dart';
import 'screens/Login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home.dart';

Future main() async {
  Provider.debugCheckInvalidValueType = null;

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('Login') == 'Yes') {
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
//          ChangeNotifierProxyProvider<TextFieldProvider, LoginProvider>(
//            create: (ctx) => LoginProvider(),
//            update: (_, auth, data) =>
//                data..update(auth.phoneNumberData, auth.passwordData),
//          )
        ],
        child: Provider<LoginProvider>(
            create: (_) => LoginProvider(),
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
              home: StartFromChatScreens(),
            ))));
  } else {
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
        ],
        child: Provider<LoginProvider>(
            create: (_) => LoginProvider(),
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
              home: StartFromLoginScreens(),
            ))));
  }
}

class StartFromChatScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
//      MultiProvider(
//        providers: [
//          ChangeNotifierProvider(
//            create: (context) => SignUpProvider(),
//          ),
//          ChangeNotifierProvider(
//            create: (context) => HomeProvider(),
//          ),
//          ChangeNotifierProvider(
//            create: (context) => TextFieldProvider(),
//          ),
//          ChangeNotifierProvider(
//            create: (context) => LoginProvider(),
//          ),
//        ],
//        child: Provider<TextFieldProvider>(
//            create: (_) => TextFieldProvider(),
//            child:
//
//            MaterialApp(
//              debugShowCheckedModeBanner: false,
//              title: 'Flutter Demo',
//              theme: ThemeData(
//                  primaryColor: Color(0xffff3e3e),
//                  accentColor: Color(0xFFFEF9EB),
//                  textSelectionColor: Colors.black),
//              routes: <String, WidgetBuilder>{
//                '/HomeScreen': (BuildContext context) => new HomeScreen(),
//                '/Login': (BuildContext context) => new LoginScreen(),
//              },
//              home:
//
        HomeScreen();
//              ,
//            )));
  }
}

class StartFromLoginScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
//    MultiProvider(
//        providers: [
//          ChangeNotifierProvider(
//            create: (context) => SignUpProvider(),
//          ),
//          ChangeNotifierProvider(
//            create: (context) => HomeProvider(),
//          ),
//          ChangeNotifierProvider(
//            create: (context) => LoginProvider(),
//          ),
//          ChangeNotifierProvider(
//            create: (context) => TextFieldProvider(),
//          ),
//        ],
//        child: Provider<LoginProvider>(
//            create: (_) => LoginProvider(),
//            child:
//            MaterialApp(
//              debugShowCheckedModeBanner: false,
//              title: 'Flutter Demo',
//              routes: <String, WidgetBuilder>{
//                '/HomeScreen': (BuildContext context) => new HomeScreen(),
//                '/Login': (BuildContext context) => new LoginScreen(),
//              },
//              theme: ThemeData(
//                primaryColor: Colors.red,
//                accentColor: Color(0xFFFEF9EB),
//              ),
        LoginScreen();
//            )));
  }
}
