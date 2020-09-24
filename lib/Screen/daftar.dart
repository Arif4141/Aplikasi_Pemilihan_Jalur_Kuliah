import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mi_card/Model/daftar_model.dart';
import 'package:mi_card/Screen/form_satu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mi_card/Screen/login.dart';
import 'constant.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:validators/validators.dart' as validator;

class Daftar extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _DaftarState createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  bool FormPass = false;
  String email;
  String password;
  String konfirmasi_password;
  bool isEmail = false;
  String _error;

  final _formKey = GlobalKey<FormState>();
  DaftarModel model = DaftarModel();
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Hero(
                        tag: 'logo_uii',
                        child: Container(
                          width: 320,
                          child: Image.asset(
                              'images/PNG-FC-Signature Biru-Horisontal_ed.png'),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: kBoxDecorationStyle,
                        child: DaftarForm(
                          hintText: 'Masukan Email',
                          isEmail: true,
                          validator: (String value) {
                            if (!validator.isEmail(value)) {
                              return 'Masukan email yang valid';
                            }
                            _formKey.currentState.save();
                            return null;
                          },
                          onSaved: (value) {
                            model.email = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: kBoxDecorationStyle,
                        child: DaftarForm(
                          hintText: 'Masukan Password',
                          isPassword: true,
                          validator: (value) {
                            if (value.length < 7) {
                              return 'Password harus lebih dari 7 karakter';
                            }
                            _formKey.currentState.save();
                            return null;
                          },
                          onSaved: (value) {
                            model.password = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: kBoxDecorationStyle,
                        child: DaftarForm(
                          hintText: 'Konfirmasi Password',
                          isPassword: true,
                          validator: (value) {
                            if (value.length < 7) {
                              return 'Password harus lebih dari 7 karakter';
                            } else if (model.password != null &&
                                value != model.password) {
                              return 'Password tidak sesuai';
                            }
                            return null;
                          },
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
                                Navigator.pushNamed(context, Login.id);
                              },
                              color: Colors.white,
                              textColor: Colors.black,
                              child: Text("Masuk".toUpperCase(),
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
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  try {
                                    final newUser = await _auth
                                        .createUserWithEmailAndPassword(
                                            email: model.email,
                                            password: model.password);
                                    if (newUser != null) {
                                      _fireStore
                                          .collection('Users')
                                          .doc(model.email)
                                          .set({'FormPass': FormPass});
                                      Navigator.pushNamed(
                                          context, Form_Satu.id);
                                    }
                                  } catch (e) {
                                    if (e.message ==
                                        'The email address is already in use by another account.') {
                                      setState(() {
                                        _error =
                                            'Email sudah digunakan oleh akun lain';
                                      });
                                    }
                                    print(e);
                                  }
                                }
                                setState(() {
                                  showSpinner = false;
                                });
                              },
                              color: Hexcolor("#f6d106"),
                              textColor: Colors.black87,
                              child: Text("Daftar".toUpperCase(),
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

class DaftarForm extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isEmail;
  final bool isPassword;

  DaftarForm({
    this.hintText,
    this.validator,
    this.onSaved,
    this.isEmail = false,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          obscureText: isPassword,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: isPassword
                ? Icon(
                    Icons.lock,
                    color: Colors.black45,
                  )
                : Icon(
                    Icons.email,
                    color: Colors.black45,
                  ),
            hintText: hintText,
            hintStyle: kHintTextStyle,
          ),
          validator: validator,
          onSaved: onSaved,
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
        ),
      ],
    );
  }
}
