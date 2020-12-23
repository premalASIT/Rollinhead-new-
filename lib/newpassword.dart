import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rollinhead/Model/Passwordadd/AddPassword.dart';
import 'package:rollinhead/bio.dart';
import 'package:rollinhead/namepass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPassword extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController pass = new TextEditingController();
  TextEditingController cpass = new TextEditingController();
  final formKey = new GlobalKey<FormState>();
  bool _isLoading = false;

  AddPassword addpass;
  password(String pass) async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String userId =sharedPreferences.getString('user_Id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');

    Map data = {
      'userId': userid,
      'password' : pass,
    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/addPassword", body: data);
    addpass = new AddPassword.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (addpass.status.code==200) {
        setState(() {
          _isLoading = false;
        });
        //   sharedPreferences.setInt("user_Id",verifyotp.response.userId);
        print(response.body);
        print("done2");
        print("done");
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (BuildContext context) => Namepass()), (
            Route<dynamic> route) => false);
        Fluttertoast.showToast(
            msg: addpass.status.message,
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
            msg: addpass.status.message,
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
      body: Form(
        key:formKey,
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:78.0),
                child: Text("CREATE PASSWORD",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:48.0,right: 48.0,top: 30.0,bottom: 10.0,),
                child: TextFormField(
                  autocorrect: true,
                  controller: pass,
                  obscureText: true,
                  validator: (value){
                    if(value.isEmpty){
                      return "Password Can't be empty";
                    }
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Password',
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
                  controller: cpass,
                  obscureText: true,
                  validator: (value){
                    if(value.isEmpty){
                      return "Password Can't be empty";
                    }
                      else if(value != pass.text){
                        return "Password doesn't matches";
                      }
                      else
                        return null;
                  },
                  decoration: InputDecoration(

                    hintText: 'Confirm Password',
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
                  child: Text("Add password",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.deepOrange,
                    ),),
                  onPressed: (){
                    final form = formKey.currentState;
                    if (form.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      password(pass.text);

                    }

//                Navigator.of(context).push(MaterialPageRoute(
//                    builder: (BuildContext context) => Profilepic()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
