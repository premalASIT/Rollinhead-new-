import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rollinhead/Model/RegistrationEmail/RegisterEmailApi.dart';
import 'package:rollinhead/Model/RegistrationPhone/RegisterPhoneApi.dart';
import 'package:rollinhead/Widgets/Emailvalidate.dart';
import 'package:rollinhead/createemail.dart';
import 'package:rollinhead/createphone.dart';
import 'package:rollinhead/namepass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(CreateAcc1());
}


class CreateAcc1 extends StatefulWidget {
  @override
  _CreateAcc1State createState() => _CreateAcc1State();
}

class _CreateAcc1State extends State<CreateAcc1> {
  TextEditingController phone = new TextEditingController();
  TextEditingController mail = new TextEditingController();
  final formKey = new GlobalKey<FormState>();
  final Formkey = new GlobalKey<FormState>();

  RegisterPhoneApi registerapi;
  RegisterEmailApi registermailapi;
//  RegisterEmail registermailapi;

  bool _isLoading = false;
  String token;
  register(String mobile) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map data = {
      'userMobile': mobile,

    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/registerusingphone", body: data);
    registerapi = new RegisterPhoneApi.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (registerapi.status.code==200) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("user_Id",registerapi.response.userId);

        print(response.body);
        print("done2");

        print("done");
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (BuildContext context) => Createphone()), (
            Route<dynamic> route) => false);
        Fluttertoast.showToast(
            msg: registerapi.status.message,
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
            msg: registerapi.status.message,
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
      Fluttertoast.showToast(
          msg: registerapi.status.message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2
      );
      print(response.body);
    }
  }
  registermail(String mail) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'userEmail': mail,
    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/registerusingemail", body: data);
    registermailapi = new RegisterEmailApi.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (registermailapi.status.code==200) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("user_Id",registermailapi.response.userId);
        print(response.body);
        print("done2");
        print("done");
        Fluttertoast.showToast(
            msg: registermailapi.status.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 10
        );
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (BuildContext context) => Createphone()), (
            Route<dynamic> route) => false);
      }
      else{
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: registermailapi.status.message,
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
      body:   Center(
        child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: new Icon(Icons.queue_play_next,
                    size: 200.0,
                    color: Colors.black,
                  ),
                ),
                _tabsection(context),

              ],
        ),
      ),
      persistentFooterButtons: <Widget>[
        new Text("Already have an account?",
        style: TextStyle(
          color: Colors.black87,
        ),),
        Padding(
          padding: const EdgeInsets.only(right:56.0),
          child: new FlatButton(onPressed: null, child: Text("Log In",
            style: TextStyle(
              color: Colors.black,
            ),)),
        ),
      ],

    );
  }

Widget _tabsection(BuildContext context){

  return DefaultTabController(
    length: 2,

    child: Padding(
      padding: const EdgeInsets.only(left:48.0,right: 48.0,top: 20.0,),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: Colors.transparent,
            child: TabBar(
                labelColor: Colors.black,
                tabs: [
              Tab(text: "Phone"),
              Tab(text: "Email"),

            ]),

          ),
          Container(
            //Add this to give height
            height: MediaQuery.of(context).size.height/4.6,
            child: TabBarView(children: [
              Container(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top:28.0),
                        child: ClipRect(
                          child: TextFormField(
                            controller: phone,
                             maxLength: 10,
                            validator: (value){
                              if (value.length != 10)
                              return 'Mobile Number must be of 10 digit';
                              else
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(
                              fillColor: Colors.black26,
                              //labelStyle: Icons.rounded_corner,
                              labelText: "Registration Number",
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 48.0,left: 48.0,),
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
                              register(phone.text);
                            }
                            },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Form(
                    key: Formkey,
                    child: Padding(
                      padding: const EdgeInsets.only(top:28.0),
                      child: Container(
                        child: TextFormField(
                       controller: mail,
                          obscureText: false,
                          validator: (value){
                            if (!EmailValidator.validate(value))
                              return 'Please enter valid email';
                            else
                              return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration:  InputDecoration(
                            //labelStyle: Icons.rounded_corner,
                            labelText: "Registration Email",
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),

                              ),
                            ),
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
                        final form = Formkey.currentState;
                        if (form.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          registermail(mail.text);

                        }
                        print(mail.text);

//                        Navigator.of(context).push(MaterialPageRoute(
//                            builder: (BuildContext context) => Createmail()));
                      },
                    ),
                  ),
                ],
              ),

            ]),
          ),

        ],
      ),
    ),
  );
}}