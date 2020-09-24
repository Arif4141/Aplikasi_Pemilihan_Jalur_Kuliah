import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:mi_card/Screen/main_menu.dart';
import 'constant.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:hexcolor/hexcolor.dart';

import 'daftar.dart';

class Login extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String _error;
  String password;
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
  }

  @override
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
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Hero(
                      tag: 'logo_uii',
                      child: Container(
                        width: 320,
                        child: Image.asset(
                          'images/PNG-FC-Signature Biru-Horisontal_ed.png',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      child: Column(
                        children: <Widget>[
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.black45,
                              ),
                              hintText: 'Masukan Email',
                              hintStyle: kHintTextStyle,
                            ),
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      child: Column(
                        children: <Widget>[
                          TextField(
                            obscureText: _obscureText,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.black45,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon((_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                                onPressed: _toggle,
                                color: Colors.black45,
                              ),
                              hintText: 'Masukan Password',
                              hintStyle: kHintTextStyle,
                            ),
                            onChanged: (value) {
                              password = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Errorr(),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(width: 2, color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, Daftar.id);
                            },
                            color: Colors.white,
                            textColor: Colors.black,
                            child: Text("Daftar".toUpperCase(),
                                style: TextStyle(fontSize: 14)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            onPressed: () async {
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                final user =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                if (user != null) {
                                  Navigator.pushReplacementNamed(
                                      context, MainMenu.id);
                                }
                                setState(() {
                                  showSpinner = false;
                                });
                              } catch (e) {
                                if (email != null && password != null) {
                                  if (e.message ==
                                      'The email address is badly formatted.') {
                                    setState(() {
                                      _error = 'Format email salah.';
                                    });
                                  } else if (e.message ==
                                      'There is no user record corresponding to this identifier. The user may have been deleted.') {
                                    setState(() {
                                      _error = 'Email tidak ditemukan.';
                                    });
                                  } else if (e.message ==
                                      'The password is invalid or the user does not have a password.') {
                                    setState(() {
                                      _error = 'Password salah.';
                                    });
                                  }
                                } else if (email != null && password == null) {
                                  setState(() {
                                    _error = 'Password tidak boleh kosong!';
                                  });
                                } else if (email == null && password != null) {
                                  setState(() {
                                    _error = 'Email tidak boleh kosong!';
                                  });
                                } else if (email == null && password == null) {
                                  setState(() {
                                    _error =
                                        'Email dan password tidak boleh kosong!';
                                  });
                                }

                                print(e);
                              }
                              setState(() {
                                showSpinner = false;
                              });
                            },
                            color: Hexcolor("#093697"),
                            textColor: Colors.white,
                            child: Text("Masuk".toUpperCase(),
                                style: TextStyle(fontSize: 14)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Errorr() {
    if (_error == null) {
      return SizedBox(
        height: 1,
      );
    } else if (_error != null) {
      return Container(
        color: Colors.amberAccent,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Icon(Icons.error_outline),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: AutoSizeText(
                _error,
                maxLines: 3,
                style: TextStyle(fontSize: 15),
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _error = null;
                });
              },
            )
          ],
        ),
      );
    }
    SizedBox(
      height: 10.0,
    );
  }
}
