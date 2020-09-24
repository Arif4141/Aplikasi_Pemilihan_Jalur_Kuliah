import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'constant.dart';
import 'main_menu.dart';
import 'login.dart';
import 'daftar.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:validators/validators.dart' as Validators;

import 'main_menu.dart';

class Form_Satu extends StatelessWidget {
  static const String id = 'form_satu';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/no_rect.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: FormID(),
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
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  @override
  void initState() {
    super.initState();

    Firebase.initializeApp();
    getCurrentUser();
    myController.addListener(_printLatestValue);
//    getProvince();
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

  final _formsPageViewController = PageController();
  List _forms;
  final _formKey = GlobalKey<FormState>();
  String dropdownValue;
  String dropdownValue2;
  bool aktivasiForm = false;

  //Jenis Kelamin Radio
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

  //SMA Radio
  String smak = '';
  void _pilihsmak(String values) {
    setState(() {
      smak = values;
    });
  }

  //Prov & Kota
//  String baseUrl = "http://192.168.10.232/news_server/index.php/Api/";
//  String _valProvince, _valCity;
//  List<dynamic> _dataProvince = List(), _dataCity = List();
//
//  void getProvince() async {
//    final response = await http
//        .get(baseUrl + "getProvince1"); //untuk melakukan request ke webservice
//    var listData = jsonDecode(response.body); //lalu kita decode hasil datanya
//    setState(() {
//      _dataProvince = listData; // dan kita set kedalam variable _dataProvince
//    });
//    print("Data Province : $listData");
//  }
//
//  void getCity(String idProvince) async {
//    final response =
//        await http.post(baseUrl + "getCity", body: {'id': idProvince});
//
//    var listData = jsonDecode(response.body);
//    setState(() {
//      _dataCity = listData;
//    });
//    print("Data City : $listData");
//  }

  //Textfield Jenis Kelamin
  final myController = TextEditingController();

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
    _forms = [
      WillPopScope(
        onWillPop: () => Future.sync(this.onWillPop),
        child: Container(
          child: ListView(
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
                        hintText: 'Masukan Nama Lengkap',
                        labelText: 'Nama Lengkap',
                        hintStyle: kHintTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
//              Container(
//                alignment: Alignment.centerLeft,
//                decoration: kBoxDecorationStyle,
//                child: Column(
//                  children: <Widget>[
//                    TextFormField(
//                      enabled: false,
//                      keyboardType: TextInputType.emailAddress,
//                      style: TextStyle(
//                        color: Colors.black,
//                        fontFamily: 'OpenSans',
//                      ),
//                      decoration: InputDecoration(
//                        border: InputBorder.none,
//                        contentPadding: EdgeInsets.all(14.0),
//                        hintText: 'Masukan NIM',
//                        labelText: 'NIM',
//                        hintStyle: kHintTextStyle,
//                      ),
//                    ),
//                  ],
//                ),
//              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                alignment: Alignment.centerLeft,
                decoration: kBoxDecorationStyle,
                child: Row(children: <Widget>[
                  Expanded(
                    child: new TextFormField(
                      enabled: false,
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
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onPressed: () {
                        _nextFormStep();
                      },
                      color: Hexcolor("#093697"),
                      textColor: Colors.white,
                      child: Text("Lanjut".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      WillPopScope(
        onWillPop: () => Future.sync(this.onWillPop),
        child: Container(
          child: ListView(
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
                        hintText: 'Masukan Nama Sekolah Asal',
                        labelText: 'SMA/SMK',
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
                        hintText: 'Jenis Sekolah',
                        hintStyle: kHintTextStyle,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          value: 'Negeri',
                          groupValue: smak,
                          onChanged: (String value) {
                            setState(
                              () {
//                              group = T;
                                smak = 'Negeri';
                                _pilihjk(value);
                                print(smak);
                              },
                            );
                          },
                        ),
                        Text('Negeri'),
                        SizedBox(
                          height: 8.0,
                        ),
                        Radio(
                          value: 'Swasta',
                          groupValue: smak,
                          onChanged: (String value) {
                            setState(
                              () {
//                              group = T;
                                smak = 'Swasta';
                                _pilihjk(value);
                                print(smak);
                              },
                            );
                          },
                        ),
                        Text('Swasta'),
                      ],
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
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: DropdownButton<String>(
                        hint: Text("Jurusan SMA/SMK"),
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black45,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>[
                          'IPA',
                          'IPS',
                          'Bahasa',
                          'Rekayasa Perangkat Lunak',
                          'Teknik Komunikasi & Jaringan',
                          'Multi Media',
                          'Desain Komunikasi Visual',
                          'Akuntansi',
                          'Perbankan',
                          'Perhotelan',
                          'Otomatisasi & Tata Kelola Perkantoran',
                          'Jasa Boga',
                          'Tata Busana',
                          'Teknik Kecantikan Kulit',
                          'Pemasaran',
                          'Alfaclass',
                          'Pertanian',
                          'Perikanan'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
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
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: DropdownButton(
                        hint: Text("Provinsi SMA/SMK"),
//                        value: _valProvince,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black45,
                        ),
                        onChanged: (value) {},
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
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: DropdownButton(
                        hint: Text("Kota/Kabupaten SMA/SMK"),
//                        value: _valProvince,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black45,
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onPressed: () {
                        _backFormStep();
                      },
                      color: Hexcolor("#f6d106"),
                      textColor: Colors.black,
                      child: Text("Kembali".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onPressed: () {
                        _nextFormStep();
                      },
                      color: Hexcolor("#093697"),
                      textColor: Colors.white,
                      child: Text("Lanjut".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      WillPopScope(
        onWillPop: () => Future.sync(this.onWillPop),
        child: Container(
          child: ListView(
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
                        hintText: 'Masukan Tahun Lulus SMA/SMK',
                        labelText: 'Tahun Lulus SMA/SMK',
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
                        hintText: 'Masukan NEM SMA/SMK',
                        labelText: 'NEM SMA/SMK',
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
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: DropdownButton<String>(
                        hint: Text("Jalur Masuk"),
                        value: dropdownValue2,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black45,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue2 = newValue;
                          });
                        },
                        items: <String>[
                          'SIBER (Seleksi Berbasis Rapor)',
                          'Penelusuran Siswa Berprestasi',
                          'Penelusuran Hafiz Al-Qur’an',
                          'Penelusuran Pemimpin Muda',
                          'CBT',
                          'PBT'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
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
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(14.0),
                        hintText: 'Masukan Cacat Badan (Jika Ada)',
                        labelText: 'Cacat Badan (Jika Ada)',
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
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: new TextFormField(
                        enabled: false,
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(14.0),
                          hintText: 'Pilih Foto Profile',
                          labelText: 'Foto Profile',
                          hintStyle: kHintTextStyle,
                        ),
//                        controller: _controller,
//                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                    new IconButton(
                      icon: new Icon(Icons.camera_alt),
                      tooltip: 'Pilih Foto',
                      onPressed: (() {}),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onPressed: () {
                        _backFormStep();
                      },
                      color: Hexcolor("#f6d106"),
                      textColor: Colors.black,
                      child: Text("Kembali".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onPressed: () {
                        _nextFormStep();
                      },
                      color: Hexcolor("#093697"),
                      textColor: Colors.white,
                      child: Text("Lanjut".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      //TODO Form 4
//      WillPopScope(
//        onWillPop: () => Future.sync(this.onWillPop),
//        child: Container(
//          child: ListView(
//            children: <Widget>[
//              Container(
//                alignment: Alignment.centerLeft,
//                decoration: kBoxDecorationStyle,
//                child: Column(
//                  children: <Widget>[
//                    TextFormField(
//                      keyboardType: TextInputType.emailAddress,
//                      style: TextStyle(
//                        color: Colors.black,
//                        fontFamily: 'OpenSans',
//                      ),
//                      decoration: InputDecoration(
//                        border: InputBorder.none,
//                        contentPadding: EdgeInsets.all(14.0),
//                        hintText: 'Masukan Tahun Lulus SMA/SMK',
//                        labelText: 'Tahun Lulus SMA/SMK',
//                        hintStyle: kHintTextStyle,
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              SizedBox(
//                height: 8.0,
//              ),
//              Container(
//                alignment: Alignment.centerLeft,
//                decoration: kBoxDecorationStyle,
//                child: Column(
//                  children: <Widget>[
//                    TextFormField(
//                      keyboardType: TextInputType.emailAddress,
//                      style: TextStyle(
//                        color: Colors.black,
//                        fontFamily: 'OpenSans',
//                      ),
//                      decoration: InputDecoration(
//                        border: InputBorder.none,
//                        contentPadding: EdgeInsets.all(14.0),
//                        hintText: 'Masukan NEM SMA/SMK',
//                        labelText: 'NEM SMA/SMK',
//                        hintStyle: kHintTextStyle,
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              SizedBox(
//                height: 8.0,
//              ),
//              Container(
//                alignment: Alignment.centerLeft,
//                decoration: kBoxDecorationStyle,
//                child: Column(
//                  children: <Widget>[
//                    Padding(
//                      padding: const EdgeInsets.all(14.0),
//                      child: DropdownButton<String>(
//                        hint: Text("Jalur Masuk"),
//                        value: dropdownValue2,
//                        icon: Icon(Icons.arrow_downward),
//                        iconSize: 24,
//                        elevation: 16,
//                        style: TextStyle(color: Colors.black),
//                        underline: Container(
//                          height: 2,
//                          color: Colors.black45,
//                        ),
//                        onChanged: (String newValue) {
//                          setState(() {
//                            dropdownValue2 = newValue;
//                          });
//                        },
//                        items: <String>[
//                          'SIBER (Seleksi Berbasis Rapor)',
//                          'Penelusuran Siswa Berprestasi',
//                          'Penelusuran Hafiz Al-Qur’an',
//                          'Penelusuran Pemimpin Muda',
//                          'CBT',
//                          'PBT'
//                        ].map<DropdownMenuItem<String>>((String value) {
//                          return DropdownMenuItem<String>(
//                            value: value,
//                            child: Text(value),
//                          );
//                        }).toList(),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              SizedBox(
//                height: 8.0,
//              ),
//              Container(
//                alignment: Alignment.centerLeft,
//                decoration: kBoxDecorationStyle,
//                child: Column(
//                  children: <Widget>[
//                    TextFormField(
//                      maxLines: null,
//                      keyboardType: TextInputType.multiline,
//                      style: TextStyle(
//                        color: Colors.black,
//                        fontFamily: 'OpenSans',
//                      ),
//                      decoration: InputDecoration(
//                        border: InputBorder.none,
//                        contentPadding: EdgeInsets.all(14.0),
//                        hintText: 'Masukan Cacat Badan (Jika Ada)',
//                        labelText: 'Cacat Badan (Jika Ada)',
//                        hintStyle: kHintTextStyle,
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              SizedBox(
//                height: 8.0,
//              ),
//              Container(
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.end,
//                  children: <Widget>[
//                    FlatButton(
//                      shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(5.0),
//                      ),
//                      onPressed: () {
//                        _backFormStep();
//                      },
//                      color: Hexcolor("#f6d106"),
//                      textColor: Colors.black,
//                      child: Text("Kembali".toUpperCase(),
//                          style: TextStyle(fontSize: 14)),
//                    ),
//                    SizedBox(
//                      width: 10,
//                    ),
//                    FlatButton(
//                      shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(5.0),
//                      ),
//                      onPressed: () {
//                        _nextFormStep();
//                      },
//                      color: Hexcolor("#093697"),
//                      textColor: Colors.white,
//                      child: Text("Lanjut".toUpperCase(),
//                          style: TextStyle(fontSize: 14)),
//                    ),
//                  ],
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
      WillPopScope(
        onWillPop: () => Future.sync(this.onWillPop),
        child: Container(
          child: ListView(
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
                        hintText: 'Masukan Pendidikan Terakhir Ayah',
                        labelText: 'Pendidikan Terakhir Ayah',
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
                        hintText: 'Masukan Pekerjaan Ayah',
                        labelText: 'Pekerjaan Ayah',
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
                        hintText: 'Masukan Jabatan Ayah (Opsional)',
                        labelText: 'Jabatan Ayah (Opsional)',
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
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(14.0),
                        hintText: 'Masukan Instansi Ayah (Opsional)',
                        labelText: 'Instansi Ayah (Opsional)',
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onPressed: () {
                        _backFormStep();
                      },
                      color: Hexcolor("#f6d106"),
                      textColor: Colors.black,
                      child: Text("Kembali".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onPressed: () {
                        _nextFormStep();
                      },
                      color: Hexcolor("#093697"),
                      textColor: Colors.white,
                      child: Text("Lanjut".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      WillPopScope(
        onWillPop: () => Future.sync(this.onWillPop),
        child: Container(
          child: ListView(
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
                        hintText: 'Masukan Pendidikan Terakhir Ibu',
                        labelText: 'Pendidikan Terakhir Ibu',
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
                        hintText: 'Masukan Pekerjaan Ibu',
                        labelText: 'Pekerjaan Ibu',
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
                        hintText: 'Masukan Jabatan Ibu (Opsional)',
                        labelText: 'Jabatan Ibu (Opsional)',
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
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(14.0),
                        hintText: 'Masukan Instansi Ibu (Opsional)',
                        labelText: 'Instansi Ibu (Opsional)',
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onPressed: () {
                        _backFormStep();
                      },
                      color: Hexcolor("#f6d106"),
                      textColor: Colors.black,
                      child: Text("Kembali".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onPressed: () {
                        _nextFormStep();
                      },
                      color: Hexcolor("#093697"),
                      textColor: Colors.white,
                      child: Text("Lanjut".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      WillPopScope(
        onWillPop: () => Future.sync(this.onWillPop),
        child: Container(
          child: ListView(
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
                        hintText: 'Masukan Pendidikan Terakhir Wali (Opsional)',
                        labelText: 'Pendidikan Terakhir Wali (Opsional)',
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
                        hintText: 'Masukan Pekerjaan Wali (Opsional)',
                        labelText: 'Pekerjaan Wali (Opsional)',
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
                        hintText: 'Masukan Jabatan Wali (Opsional)',
                        labelText: 'Jabatan Wali (Opsional)',
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
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(14.0),
                        hintText: 'Masukan Instansi Wali (Opsional)',
                        labelText: 'Instansi Wali (Opsional)',
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onPressed: () {
                        _backFormStep();
                      },
                      color: Hexcolor("#f6d106"),
                      textColor: Colors.black,
                      child: Text("Kembali".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onPressed: () {
                        _submitForm();
                      },
                      color: Hexcolor("#093697"),
                      textColor: Colors.white,
                      child: Text("Daftar".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ];

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
//            Text(
//              'APLIKASI PEMBANTU PEMILIHAN\nPROGRAM STUDI SARJANA',
//              textAlign: TextAlign.center,
//              style: TextStyle(
//                  fontSize: 18.0,
//                  fontFamily: 'Montserrat',
//                  color: Colors.black87),
//            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: PageView.builder(
                controller: _formsPageViewController,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return _forms[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _nextFormStep() {
    _formsPageViewController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _submitForm() {
    Navigator.pushReplacementNamed(context, MainMenu.id);
  }

  void _backFormStep() {
    _formsPageViewController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  bool onWillPop() {
    if (_formsPageViewController.page.round() ==
        _formsPageViewController.initialPage) return true;

    _formsPageViewController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );

    return false;
  }
}
