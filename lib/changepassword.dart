import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rollinhead/Model/passWordChanging/ChangedPassword.dart';
import 'package:rollinhead/namepass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController newpass = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController conpass = new TextEditingController();
  final Formkey = new GlobalKey<FormState>();
  bool _isLoading =false;
  ChangedPassword change;
  passwords(String passw,npassw) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String user =sharedPreferences.getString('user_Id');
    Map data = {
      'OldPassword': passw,
      'UserId': user,
      'NewPassword': npassw,
    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/ChangePassword", body: data);
    change = new ChangedPassword.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (change.status.code==200) {
        setState(() {
          _isLoading = false;
        });

        print(response.body);
        print("done2");
        print("done");
        Fluttertoast.showToast(
            msg: change.status.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 10
        );
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (BuildContext context) => Namepass()), (
            Route<dynamic> route) => false);
      }
      else{
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: change.status.message,
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
      appBar: AppBar(

      ),
      body : Form(
        key: Formkey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:48.0,right: 48.0,top: 30.0,bottom: 10.0,),
              child: TextFormField(
                autocorrect: true,
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(

                  hintText: 'OLD PASSWORD',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.black12,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.black26, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.black26),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:48.0,right: 48.0,top: 30.0,bottom: 10.0,),
              child: TextFormField(
                autocorrect: true,
                controller: newpass,
                obscureText: true,
                decoration: InputDecoration(

                  hintText: 'NEW PASSWORD',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.black12,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.black26, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.black26),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:48.0,right: 48.0,top: 30.0,bottom: 10.0,),
              child: TextFormField(
                autocorrect: true,
                controller: conpass,
                obscureText: true,
                decoration: InputDecoration(

                  hintText: 'CONFIRM PASSWORD',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.black12,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.black26, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.black26),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 48.0,left: 48.0,top: 20.0,),
              child: FlatButton(
                child: Text("Change password",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.deepOrange,
                  ),),
                onPressed: (){
                    final form = Formkey.currentState;
                    if (form.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      if(newpass.text == conpass.text){
                            passwords(pass.text,newpass.text);
                      }
                      else{
                        Fluttertoast.showToast(
                            msg: "Password and confirm password doesn't matches",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2
                        );
                      }
                    }
                 // loginpass(user.text,pass.text);
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
