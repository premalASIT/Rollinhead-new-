import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rollinhead/Model/Feedback/UserFeedback.dart';
import 'package:rollinhead/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelpUsPage extends StatefulWidget {
  @override
  _HelpUsPageState createState() => _HelpUsPageState();
}

class _HelpUsPageState extends State<HelpUsPage> {
  TextEditingController mail = new TextEditingController();
  TextEditingController msg = new TextEditingController();
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  UserFeedback feedback;
  Ufeedback(String message,mailid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =prefs.getString('user_Id');
    Map data = {
      'UserId': userId,
      'Email': mailid,
      'Content': message,

    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/SaveFeedback", body: data);
    feedback = new UserFeedback.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (feedback.status.code==200) {
        setState(() {
          _isLoading = false;
        });
        print(response.body);
        print("done2");
        print("done");
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (BuildContext context) => Homepage()), (
            Route<dynamic> route) => false);
        Fluttertoast.showToast(
            msg: feedback.status.message,
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
            msg: feedback.status.message,
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
        title: Text('Help Us Improve',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      body:_isLoading ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Rollinhead Feedback ',
                  // Text('Rollinhead \n Rollinhead \n Rollinhead \n Rollinhead \n Rollinhead \n Rollinhead \n ',
                  style : TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Enter Email Id',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  controller: mail,
                  validator: (value){
                    if(value.isEmpty){
                      return "* required";
                    }
                    else
                      return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Please enter your feedback',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                TextFormField(
                  controller: msg,
                  validator: (value){
                    if(value.isEmpty){
                      return "* required";
                    }
                    else
                      return null;
                  },
                ),
                SizedBox(height: 30,),
                RaisedButton(

                  onPressed: (){
                    setState(() {
                      _isLoading = true;
                    });
                      Ufeedback(msg.text, mail.text);
                  },
                  color: Colors.red,
                  child: Text(" Send ",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
//                        backgroundColor: Colors.black12,
                    ),),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

