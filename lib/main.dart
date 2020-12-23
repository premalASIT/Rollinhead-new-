import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rollinhead/begin.dart';
import 'package:rollinhead/homepage.dart';
import 'package:rollinhead/namepass.dart';
import 'package:rollinhead/startpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

void main(){

  runApp(new MaterialApp(
    home: new MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString('user_Id') != null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Homepage()),
              (Route<dynamic> route) => false);
    }else{
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (BuildContext context) => Startpage()), (
          Route<dynamic> route) => false);
    }
  }

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 5),() {
      checkLoginStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        body: Container(
            child: new Center(
              child: new Image.asset('assests/images/first.png',
                width: 200,
                height: 200,
              ),
            )
        )
    );
  }
}
