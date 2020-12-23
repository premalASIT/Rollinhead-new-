import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rollinhead/Model/AddBio/status.dart';
import 'package:rollinhead/Model/AddPersonality/AddPersonalityApi.dart';
import 'package:rollinhead/namepass.dart';
import 'package:rollinhead/newpassword.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Personality extends StatefulWidget {
  @override
  _PersonalityState createState() => _PersonalityState();
}

class _PersonalityState extends State<Personality> {
  AddPersonalityApi addperson;
  String type;
  bool _isLoading = false;
  addingperson(String info) async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String userId =sharedPreferences.getString('user_Id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');

//    int cusId = int.parse(userid);
    print(info);

    Map data = {
      'userId': userid,
      'personalityType' : info,
    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/addPersonalityType", body: data);
    addperson = new AddPersonalityApi.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (addperson.status.code==200) {
        setState(() {
          _isLoading = false;
        });
        //   sharedPreferences.setInt("user_Id",verifyotp.response.userId);
        print(response.body);
        print("done2");
        print("done");
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (BuildContext context) => NewPassword()), (
            Route<dynamic> route) => false);
        Fluttertoast.showToast(
            msg: addperson.status.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
      }
      else{
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: addperson.status.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
        print(response.body);
      }
    }else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          Image.asset("assests/images/4.png",
            height: 100,
            width: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              InkWell(
                onTap: (){
                  addingperson("Introvert");
                },
                child:  Image.asset("assests/images/t1.png",

                  width: 150,
                ),
              ),
              InkWell(
                onTap: (){
                  addingperson("Extrovert");
                },
                child:  Image.asset("assests/images/t2.png",

                  width: 150,
                ),
              ),

            ],
          ),
        SizedBox(height: 20,),
              Image.asset("assests/images/img.png",),



        ],
      ),
    ),
     // height: MediaQuery.of(context).size.height,

    );
  }
}
