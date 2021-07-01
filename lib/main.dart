import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kitchenappliances/screen/home_screen.dart';
import 'package:kitchenappliances/screen/orderList.dart';
import 'package:kitchenappliances/screen/orders_screen.dart';
import './provider/product.dart';
import 'package:provider/provider.dart';
import './provider/auth.dart';
import './screen/auth_screen.dart';
import './screen/add_product.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Auth auth = Auth();
  bool isLoggedin = true;

  @override
  void initState() {
    auth.autoLogin().then(
      (value) {
        print(value);
        if (value == 'null') {
          setState(
            () {
              isLoggedin = false;
            },
          );
        } else {
          setState(
            () {
              isLoggedin = true;
            },
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home: isLoggedin ? Homescreen() : Authscreen(),
        routes: {
          Authscreen.route: (ctx) => Authscreen(),
          Addproduct.route: (ctx) => Addproduct(),
          OrderDetailscreen.route: (ctx) => OrderDetailscreen(),
          OrdersList.route: (ctx) => OrdersList(),
          Homescreen.route: (ctx) => Homescreen(),
        },
      ),
    );
  }
}
