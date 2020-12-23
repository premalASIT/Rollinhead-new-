import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rollinhead/Model/ResendOtp/ResendOtpApi.dart';
import 'package:rollinhead/bio.dart';
import 'package:rollinhead/namepass.dart';
import 'package:rollinhead/newpassword.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Model/VerifyOTPuser/VerifyOtpApi.dart';

void main() {
  runApp(Createphone());
}

class Createphone extends StatefulWidget {
  @override
  _CreatephoneState createState() => _CreatephoneState();
}

class _CreatephoneState extends State<Createphone> {
  TextEditingController otp = new TextEditingController();
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  VerifyOtpApi verifyotp;
  ResendOtpApi resend;
  String token;
  sendotp() async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String userId =sharedPreferences.getString('user_Id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');

    Map data = {
      'userId': userid,
    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/resendOtp", body: data);
    resend = new ResendOtpApi.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (resend.status.code==200) {
        setState(() {
          _isLoading = false;
        });
        //   sharedPreferences.setInt("user_Id",verifyotp.response.userId);
        print(response.body);
        print("done2");
        print("done");
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (BuildContext context) => Createphone()), (
            Route<dynamic> route) => false);
        Fluttertoast.showToast(
            msg: resend.status.message,
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
            msg: resend.status.message,
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
  Verify(String otp) async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String userId =sharedPreferences.getString('user_Id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');

//    int cusId = int.parse(userid);
    print(otp);
    print(userid);
    int newOtp = int.parse(otp);
    Map data = {
      'userId': userid,
      'OTP' : otp,
    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/verifyOtp", body: data);
    verifyotp = new VerifyOtpApi.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (verifyotp.status.code==200) {
        setState(() {
          _isLoading = false;
        });
     //   sharedPreferences.setInt("user_Id",verifyotp.response.userId);
        print(response.body);
        print("done2");
        print("done");
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (BuildContext context) => Bio()), (
            Route<dynamic> route) => false);
        Fluttertoast.showToast(
            msg: verifyotp.status.message,
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
            msg: verifyotp.status.message,
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

          child: Padding(
            padding: const EdgeInsets.only(top:128.0,),
            child: Column(
              children: <Widget>[
                Text("ENTER CONFIRMATION CODE",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),),
                Padding(
                  padding: const EdgeInsets.only(top:18.0,left: 40.0,right: 40.0,),
                  child: Text("Enter 6 digit code we sent.",
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black26,
                  ),),
                ),
                FlatButton(
                  onPressed: (){
                    sendotp();
                  },
                  child: Text("Request a New One",
                    style: TextStyle(

                      color: Colors.black,

                    ),
                  ),

                ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(left:48.0,right: 48.0,),
                child: TextFormField(
                  controller: otp,
                  autocorrect: true,
                  validator: (value){
                    if (value.isEmpty)
                      return 'OTP should not be empty';
                    else
                      return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Code',
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
            ),
                Padding(
                  padding: const EdgeInsets.only(right: 48.0,left: 48.0,top: 20.0,),
                  child: FlatButton(
                    child: Text("Next",
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
                        Verify(otp.text);

                      }
                      print(otp.text);

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
