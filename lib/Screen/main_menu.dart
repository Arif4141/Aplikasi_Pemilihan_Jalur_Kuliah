import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
//import 'package:marquee/marquee.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mi_card/Screen/welcom.dart';
import 'constant.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:hexcolor/hexcolor.dart';

import 'daftar.dart';

class MainMenu extends StatefulWidget {
  static const String id = 'main_screen';
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/no_rect.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
//          appBar: PreferredSize(
//            preferredSize: Size.fromHeight(180.0),
//            child: AppBar(
//                elevation: 15,
////            centerTitle: true,
//                backgroundColor: Colors.transparent,
//                flexibleSpace: Container(
//                  decoration: BoxDecoration(
//                    image: DecorationImage(
//                      image: AssetImage('images/Card1.png'),
//                      fit: BoxFit.cover,
//                    ),
//                  ),
//                ),
//                title: Container(
//                  child: Column(
//                    children: <Widget>[
//                      Row(
//                        children: <Widget>[
//                          CircleAvatar(
//                            radius: 80.0,
//                            backgroundImage: AssetImage('images/Misaka_2.png'),
//                          ),
//                        ],
//                      ),
//                      Row(
//                        children: <Widget>[],
//                      )
//                    ],
//                  ),
//                )),
//          ),
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
//                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/Card1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius:
                                        MediaQuery.of(context).size.width * 0.1,
                                    backgroundImage:
                                        AssetImage('images/Misaka_2.png'),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
//                                      Text(
//                                        'Misaka Mikoto',
//                                        style: TextStyle(
//                                          color: Colors.white,
//                                          fontSize: 18.0,
//                                          fontFamily: 'Montserrat',
//                                        ),
//                                      ),
//                                      Text(
//                                        'Tokiwadai Middle School',
//                                        style: TextStyle(
//                                          color: Colors.white,
//                                          fontSize: 18.0,
//                                          fontFamily: 'Montserrat',
//                                        ),
//                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        height: 20,
                                        child: Marquee(
                                          child: Text(
                                            'Misaka Mikoto',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          animationDuration:
                                              Duration(seconds: 5),
                                          backDuration:
                                              Duration(milliseconds: 2500),
                                          pauseDuration:
                                              Duration(milliseconds: 2500),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        height: 20,
                                        child: Marquee(
                                          child: Text(
                                            'Tokiwadai Middle School',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                          animationDuration:
                                              Duration(seconds: 5),
                                          backDuration:
                                              Duration(milliseconds: 2500),
                                          pauseDuration:
                                              Duration(milliseconds: 2500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.21,
                                    child: Center(
                                      child: Image.asset(
                                          'images/PNG-FC-Signature Biru-Vertikal.png'),
                                    ),
                                  )
                                ],
                              ),
                              Divider(
                                color: Colors.white54,
                                height: 20,
                                thickness: 2,
                                indent: 3,
                                endIndent: 3,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.27,
                                          child: Marquee(
                                            child: Text(
                                              'NEM SMA/SMK',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            animationDuration:
                                                Duration(seconds: 5),
                                            backDuration:
                                                Duration(milliseconds: 2500),
                                            pauseDuration:
                                                Duration(milliseconds: 2500),
                                          ),
                                        ),
                                        Text(
                                          '400',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 40.0,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.27,
                                          child: Marquee(
                                            child: Text(
                                              'Nilai Rata-Rata SMA/SMK',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            animationDuration:
                                                Duration(seconds: 5),
                                            backDuration:
                                                Duration(milliseconds: 2500),
                                            pauseDuration:
                                                Duration(milliseconds: 2500),
                                          ),
                                        ),
                                        Text(
                                          '100',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 40.0,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.27,
                                          child: Marquee(
                                            child: Text(
                                              'Nilai Mata Pelajaran Terbaik',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            animationDuration:
                                                Duration(seconds: 5),
                                            backDuration:
                                                Duration(milliseconds: 2500),
                                            pauseDuration:
                                                Duration(milliseconds: 2500),
                                          ),
                                        ),
                                        Text(
                                          '100',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30.0,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Matematika',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
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
//                    Hero(
//                      tag: 'logo_uii',
//                      child: Container(
//                        width: 320,
//                        child: Image.asset(
//                          'images/PNG-FC-Signature Biru-Tengah.png',
//                        ),
//                      ),
//                    ),
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/Card1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
//                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            iconSize: 30,
                            icon: Icon(Icons.insert_chart),
                            color: Colors.black,
                            onPressed: () {},
                          ),
                          Text(
                            'Dashboard',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15.0,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//                      Container(
//                        width: MediaQuery.of(context).size.width * 0.3,
//                        height: MediaQuery.of(context).size.height * 0.2,
//                        child: Card(
//                          child: Column(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              IconButton(
//                                iconSize: 30,
//                                icon: Icon(Icons.insert_chart),
//                                color: Colors.black,
//                                onPressed: () {},
//                              ),
//                              Text(
//                                'Dashboard',
//                                style: TextStyle(
//                                    color: Colors.black87,
//                                    fontSize: 10.0,
//                                    fontFamily: 'Montserrat',
//                                    fontWeight: FontWeight.bold),
//                              )
//                            ],
//                          ),
//                        ),
//                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                iconSize: 50,
                                icon: Icon(Icons.school),
                                color: Colors.black,
                                onPressed: () {},
                              ),
                              Text(
                                'Tentang UII',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 20.0,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                iconSize: 50,
                                icon: Icon(Icons.settings),
                                color: Colors.black,
                                onPressed: () {
                                  _auth.signOut();
                                  Navigator.pushReplacementNamed(
                                      context, WelcomeScreen.id);
                                },
                              ),
                              Text(
                                'Setting',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 20.0,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
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
