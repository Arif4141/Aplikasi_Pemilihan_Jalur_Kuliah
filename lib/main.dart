import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mi_card/Screen/form_satu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mi_card/Screen/root_screen.dart';

import 'Screen/daftar.dart';
import 'Screen/login.dart';
import 'Screen/main_menu.dart';
import 'Screen/welcom.dart';

final _auth = FirebaseAuth.instance;
User user;
bool Masuk = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  getCurrentUser();
  runApp(MainPage());
}

Future getCurrentUser() async {
  try {
    user = await _auth.currentUser;
    if (user != null) {
      print('Masuk Berhasil');
      Masuk = true;
      print(user.email);
    } else if (user == null) {
      print('Masuk Gagal');
      Masuk = false;
    }
  } catch (e) {
    print(e);
  }
//    return user = await _auth.currentUser;
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Masuk ? MainMenu() : WelcomeScreen(),
      routes: {
        RootScreen.id: (context) => RootScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        Daftar.id: (context) => Daftar(),
        Login.id: (context) => Login(),
        Form_Satu.id: (context) => Form_Satu(),
        MainMenu.id: (context) => MainMenu(),
//        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
