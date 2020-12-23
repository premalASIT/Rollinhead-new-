import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rollinhead/namepass.dart';
import 'package:rollinhead/newpassword.dart';
import 'package:rollinhead/personality.dart';
import 'package:rollinhead/post.dart';
import 'package:rollinhead/profilepage.dart';
import 'package:rollinhead/Model/AddBio/BioAddApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
void main() {
  runApp(Bio());
}
class Bio extends StatefulWidget {
  @override
  _BioState createState() => _BioState();
}

class _BioState extends State<Bio> {
  bool _isLoading = false;
  TextEditingController info = new TextEditingController();
  BioAddApi bioadd;
  addingbio(String info) async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String userId =sharedPreferences.getString('user_Id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');

//    int cusId = int.parse(userid);
    print(info);

    Map data = {
      'userId': userid,
      'bio' : info,
    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/addBio", body: data);
    bioadd = new BioAddApi.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (bioadd.status.code==200) {
        setState(() {
          _isLoading = false;
        });
        //   sharedPreferences.setInt("user_Id",verifyotp.response.userId);
        print(response.body);
        print("done2");
        print("done");
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (BuildContext context) => Personality()), (
            Route<dynamic> route) => false);
        Fluttertoast.showToast(
            msg: bioadd.status.message,
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
            msg: bioadd.status.message,
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
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:78.0,bottom: 30.0,),
              child: new Icon(Icons.text_fields,
                size: 150.0,
                color: Colors.black,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text("Add a Bio",
                  style: TextStyle(
                    fontSize: 27.0,
                    fontWeight: FontWeight.bold,
                  ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,left: 65.0,right: 65.0,),
              child: Text("You write about yourself, things that excites you",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black26,
                ),),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left:48.0,right: 48.0,),
                child: TextField(
                  controller: info,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  maxLength: 100,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: ClipRect(

                  child: SizedBox(
                    height: 50,
                    width: 270,

                    child: new  RaisedButton(
                      onPressed: (){
                        print(info.text);
                    addingbio(info.text);
                      },
                      child: Text("Add a Bio",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
//                        backgroundColor: Colors.black12,
                        ),),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                      ),
                    ),

                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 48.0,left: 48.0,top:12.0,),
              child: FlatButton(
                child: Text("Skip",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.deepOrange,
                  ),),
                onPressed: (){ Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Personality()));},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
