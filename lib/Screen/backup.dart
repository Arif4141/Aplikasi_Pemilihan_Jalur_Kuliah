import 'package:flutter/material.dart';
import 'constant.dart';
import 'login.dart';
import 'daftar.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:validators/validators.dart' as Validators;

class Form_Satu extends StatelessWidget {
  static const String id = 'form_satu';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/rect.png'), fit: BoxFit.cover),
            ),
            child: FormID(),
          ),
        ),
      ),
    );
  }
}

class FormID extends StatefulWidget {
  @override
  _FormIDState createState() => _FormIDState();
}

class _FormIDState extends State<FormID> {
  final _formKey = GlobalKey<FormState>();

  //Tidak ada catatan pengguna yang sesuai dengan pengenal ini. Pengguna tersebut mungkin telah dihapus.The password is invalid or the user does not have a password.
  int group = 0;
  String jk = '';
  void _pilihjk(String value) {
    setState(() {
      jk = value;
    });
  }

  //Golongan Darah Radio
  String gol = '';
  void _pilihgol(String values) {
    setState(() {
      gol = values;
    });
  }

  //Textfield Jenis Kelamin
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("${myController.text}");
  }

  //Date
  final TextEditingController _controller = new TextEditingController();
  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());

    if (result == null) return;

    setState(() {
      _controller.text = new DateFormat.yMd().format(result);
    });
  }

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: 'logo_uii',
              child: Container(
                width: 320,
                child: Image.asset(
                  'images/PNG-FC-Signature Biru-Horisontal.png',
                ),
              ),
            ),
            Text(
              'APLIKASI PEMBANTU PEMILIHAN\nPROGRAM STUDI SARJANA',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Montserrat',
                  color: Colors.black87),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: kBoxDecorationStyle,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(14.0),
                                  hintText: 'Masukan NIM',
                                  labelText: 'NIM',
                                  hintStyle: kHintTextStyle,
                                ),
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
                          child: Row(children: <Widget>[
                            Expanded(
                              child: new TextFormField(
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(14.0),
                                  hintText: 'Masukan Tanggal Lahir',
                                  labelText: 'Tanggal Lahir',
                                  hintStyle: kHintTextStyle,
                                ),
                                controller: _controller,
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                            new IconButton(
                              icon: new Icon(Icons.calendar_today),
                              tooltip: 'Choose date',
                              onPressed: (() {
                                _chooseDate(context, _controller.text);
                              }),
                            )
                          ]),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: kBoxDecorationStyle,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(14.0),
                                  hintText: 'Masukan Tempat Lahir',
                                  labelText: 'Tempat Lahir',
                                  hintStyle: kHintTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
//              alignment: Alignment.centerLeft,
                          decoration: kBoxDecorationStyle,
                          child: Column(
                            children: <Widget>[
                              TextField(
                                enabled: false,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(14.0),
                                  hintText: 'Jenis Kelamin',
                                  hintStyle: kHintTextStyle,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Radio(
                                    value: 'Laki-Laki',
                                    groupValue: jk,
                                    onChanged: (String value) {
                                      setState(
                                        () {
//                              group = T;
                                          jk = 'Laki-Laki';
                                          _pilihjk(value);
                                          print(jk);
                                        },
                                      );
                                    },
                                  ),
                                  Text('Laki-Laki'),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Radio(
                                    value: 'Perempuan',
                                    groupValue: jk,
                                    onChanged: (String value) {
                                      setState(
                                        () {
//                              group = T;
                                          jk = 'Perempuan';
                                          _pilihjk(value);
                                          print(jk);
                                        },
                                      );
                                    },
                                  ),
                                  Text('Perempuan'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
//              alignment: Alignment.centerLeft,
                          decoration: kBoxDecorationStyle,
                          child: Column(
                            children: <Widget>[
                              TextField(
                                enabled: false,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(14.0),
                                  hintText: 'Golongan Darah',
                                  hintStyle: kHintTextStyle,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Radio(
                                    value: 'A',
                                    groupValue: gol,
                                    onChanged: (String values) {
                                      setState(
                                        () {
//                              group = T;
                                          gol = 'A';
                                          _pilihgol(values);
                                          print(gol);
                                        },
                                      );
                                    },
                                  ),
                                  Text('A'),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Radio(
                                    value: 'B',
                                    groupValue: gol,
                                    onChanged: (String values) {
                                      setState(
                                        () {
//                              group = T;
                                          gol = 'B';
                                          _pilihgol(values);
                                          print(gol);
                                        },
                                      );
                                    },
                                  ),
                                  Text('B'),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Radio(
                                    value: 'AB',
                                    groupValue: gol,
                                    onChanged: (String values) {
                                      setState(
                                        () {
//                              group = T;
                                          gol = 'AB';
                                          _pilihgol(values);
                                          print(gol);
                                        },
                                      );
                                    },
                                  ),
                                  Text('AB'),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Radio(
                                    value: 'O',
                                    groupValue: gol,
                                    onChanged: (String values) {
                                      setState(
                                        () {
//                              group = T;
                                          gol = 'O';
                                          _pilihgol(values);
                                          print(gol);
                                        },
                                      );
                                    },
                                  ),
                                  Text('O'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
