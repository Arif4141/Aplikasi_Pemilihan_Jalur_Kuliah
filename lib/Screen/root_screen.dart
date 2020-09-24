import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mi_card/Screen/main_menu.dart';
import 'package:mi_card/Screen/welcom.dart';
import 'login.dart';
import 'daftar.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class RootScreen extends StatefulWidget {
  static const String id = 'root_screen';

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
    print('INITTTTT');
    if (user == null) {
      getCurrentUser();

      print('aAAAWW');
    }
    ;
  }

  Future getCurrentUser() async {
//    try {
//      user = await _auth.currentUser;
//      if (user != null) {
//        print(user.email);
//      }
//    } catch (e) {
//      print(e);
//    }
    return user = await _auth.currentUser;
  }

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    if (user != null) {
      print('QWERTY');
      return MainMenu();
    } else if (user == null) {
      print('ASDFGH');
      return WelcomeScreen();
    }
  }
}
