import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rollinhead/Model/Loginapi/NewLoginApi.dart';
import 'package:rollinhead/editprofile.dart';
import 'package:rollinhead/homepage.dart';
import 'package:rollinhead/post.dart';
import 'package:rollinhead/profilepic.dart';
import 'package:rollinhead/Model/LoginOTP/LoginApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(Namepass());
}

class Namepass extends StatefulWidget {
  @override
  _NamepassState createState() => _NamepassState();
}

class _NamepassState extends State<Namepass> {
  bool isChecked = false;
  bool _isLoading = false;
  int flag = 0;
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  var resultHolder = 'Save Password';
  NewLoginApi login;
  loginpass(String user, pass) async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String userId =sharedPreferences.getString('user_Id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString('user_Id');

//    int cusId = int.parse(userid);
    print(user);

    Map data = {
      'name': user,
      'password': pass,
    };
    var response = await http.post(
        "http://rolinhead.dolphinfiresafety.com/registration/loginnew",
        body: data);
    login = new NewLoginApi.fromJsonMap(json.decode(response.body.toString()));
    if (response.statusCode == 200) {
      if (login.status.code == 200) {
        setState(() {
          _isLoading = false;
        });
        prefs.setString("user_Id", login.response.userId);
        print(response.body);
        print("done2");
        print("done");


          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => Homepage()),
                  (Route<dynamic> route) => false);
          

          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (BuildContext context) => Editprofile()),
          //         (Route<dynamic> route) => false);
          //

        Fluttertoast.showToast(
            msg: login.status.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2);
      } else {
        print("else");
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: login.status.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2);
        print(response.body);
      }
    } else {
      print("ELSE @");
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: login.status.message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);
      print(response.body);
    }
  }

  void toggleCheckbox(bool value) {
    if (isChecked == false) {
      // Put your code here which you want to execute on CheckBox Checked event.
      setState(() {
        isChecked = true;
        resultHolder = 'Password Saved';
      });
    } else {
      // Put your code here which you want to execute on CheckBox Un-Checked event.
      setState(() {
        isChecked = false;
        resultHolder = 'Save Password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 78.0),
                    child: Text(
                      "NAME AND PASSWORD",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 48.0,
                      right: 48.0,
                      top: 30.0,
                      bottom: 10.0,
                    ),
                    child: TextField(
                      autocorrect: true,
                      controller: user,
                      decoration: InputDecoration(
                        hintText: 'Email/Phone',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.black12,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide:
                              BorderSide(color: Colors.black26, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.black26),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 48.0,
                      right: 48.0,
                    ),
                    child: TextField(
                      controller: pass,
                      obscureText: true,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.black12,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide:
                              BorderSide(color: Colors.black26, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.black26),
                        ),
                      ),
                    ),
                  ),
//          Padding(
//            padding: const EdgeInsets.all(18.0),
//            child: Row(
//              children: <Widget>[
//                Checkbox(
//                  value: isChecked,
//                  onChanged: (value){toggleCheckbox(value);},
//                  activeColor: Colors.black12     ,
//                  checkColor: Colors.white,
//                  tristate: false,
//                ),
//                Text('$resultHolder', style: TextStyle(fontSize: 22),),
//              ],
//            ),
//          ),

                  Padding(
                    padding: const EdgeInsets.only(
                      right: 48.0,
                      left: 48.0,
                      top: 20.0,
                    ),
                    child: FlatButton(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.deepOrange,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _isLoading = true;
                        });
                        loginpass(user.text, pass.text);
                        // Sendotp(user.text);
//                Navigator.of(context).push(MaterialPageRoute(
//                    builder: (BuildContext context) => Profilepic()));
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
