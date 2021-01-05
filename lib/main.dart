import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weight_o_gram/HomeScreen/HomeScreen1.dart';
import 'package:weight_o_gram/HomeScreen/HomeScreen2.dart';
import 'package:weight_o_gram/SignInScreen/AnonymousSignIn.dart';
import 'package:weight_o_gram/SplashScreen.dart/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weight Ogram',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(82, 215, 170, 1),
      ),
      home: SplashScreen(),
      routes: {
        SplashScreen.routeName: (ctx) => SplashScreen(),
        AnonymousSignIn.routeName: (ctx) => AnonymousSignIn(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        HomeScreen2.routeName: (ctx) => HomeScreen2(),
      },
    );
  }
}
