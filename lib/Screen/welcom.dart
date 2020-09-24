import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mi_card/Screen/main_menu.dart';
import 'login.dart';
import 'daftar.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/rect.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'logo_uii',
                    child: Container(
                      width: 320,
                      child: Image.asset(
                          'images/PNG-FC-Signature Biru-Horisontal_ed.png'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        width: 120,
                        height: 45,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
//                          side: BorderSide(width: 4, color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, Daftar.id);
                          },
                          color: Hexcolor("#f6d106"),
                          textColor: Colors.black,
                          child: Text("Daftar".toUpperCase(),
                              style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        width: 120,
                        height: 45,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, Login.id);
                          },
                          color: Hexcolor("#093697"),
                          textColor: Colors.white,
                          child: Text("Masuk".toUpperCase(),
                              style: TextStyle(fontSize: 14)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
