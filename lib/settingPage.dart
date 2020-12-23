import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rollinhead/Helpus.dart';
import 'package:rollinhead/Model/GetProfiles/UserProfileApi.dart';
import 'package:rollinhead/Model/personalitychanging/ChangePersonalityApi.dart';
import 'package:rollinhead/Privacysetting.dart';
import 'package:rollinhead/aboutpage.dart';
import 'package:rollinhead/accountsetting.dart';
import 'package:rollinhead/feedspage.dart';
import 'package:rollinhead/namepass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage1 extends StatefulWidget {
  @override
  _SettingPage1State createState() => _SettingPage1State();
}

class _SettingPage1State extends State<SettingPage1> {
  bool isSwitched = false;
  bool  _isLoading = false;
  ChangePersonalityApi person;
  UserProfileApi profile;
  Future<List<dynamic>> fetchUsersList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');
    final response = await http.get(
      'http://rolinhead.dolphinfiresafety.com/registration/getUserProfile?userId=$userid & friendId=$userid',
    );
    profile= new UserProfileApi.fromJsonMap(json.decode(response.body.toString()));

    if(response.statusCode == 200) {
      if (response != null) {
        setState(() {

          _isLoading = false;

        });
        String x = profile.response.personalityType;
        print(x);
        if(x=="Introvert"){
//          toogle(false);
          isSwitched=false;
        }
        else{
//          toogle(true);
          isSwitched=true;
        }
        print(response.body);
      }
    }else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }

  }
  Changepesonal(String a) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =prefs.getString('user_Id');
    int cusId = int.parse(userId);
    Map data = {
      'userId': userId,
      'PersonalityType' : a,
    };
    final response = await http.post(
        'http://rolinhead.dolphinfiresafety.com/registration/savePersonalityType',body:data
    );
    person= new ChangePersonalityApi.fromJsonMap(json.decode(response.body.toString()));

    if(response.statusCode == 200) {

      setState(() {
        _isLoading = false;
      });

      print(response.body);
    }else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }

  }
  void toogle(bool s){
    if(s == true){
      Changepesonal("Introvert");
      setState(() {
        _isLoading = false;
      });
    }
    else if(s == false){
      Changepesonal("Extrovert");
      _isLoading = false;
    }
  }
  @override
  void initState() {
    super.initState();
    _isLoading=true;

    fetchUsersList();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',
        style: TextStyle(
          color: Colors.black,
        ),
        ),
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: Container(
        height: 52,
        width: 20,
        color: Colors.red,
        child: InkWell(
          onTap: ()async {
            final pref = await SharedPreferences.getInstance();
            await pref.clear();
            return
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (BuildContext context) => Namepass()), (
                  Route<dynamic> route) => false);
          },

          child: Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Column(
              children: <Widget>[

                Text('Logout',
                  textAlign: TextAlign.end,

                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),),
              ],
            ),
          ),
        ),
      ),

      body: _isLoading ? Center(child: CircularProgressIndicator()) : ListView(
        children: <Widget>[
          ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AccountSetting()));
            },
            leading:Icon(
              Icons.account_circle,
              color: Colors.black,
              size: 40.0,
            ),
            title:Text("Account",
              style: TextStyle(
                fontSize: 19.0,
              ),),
          ),
          //
          // ListTile(
          //   onTap: (){
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (BuildContext context) => FeedPage()));
          //   },
          //   leading:Icon(
          //     Icons.notifications,
          //     color: Colors.black,
          //     size: 40.0,
          //   ),
          //   title:Text("Notification",
          //     style: TextStyle(
          //       fontSize: 19.0,
          //     ),),
          // ),
          ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AboutPage()));
            },
            leading:Icon(
              Icons.account_box,
              color: Colors.black,
              size: 40.0,
            ),
            title:Text("About",
              style: TextStyle(
                fontSize: 19.0,
              ),),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => PrivacySettings()));
            },
            leading:Icon(
              Icons.lock,
              color: Colors.black,
              size: 40.0,
            ),
            title:Text("Privacy",
              style: TextStyle(
                fontSize: 19.0,
              ),),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => HelpUsPage()));
            },
            leading:Icon(
              Icons.feedback,
              color: Colors.black,
              size: 40.0,
            ),
            title:Text("Send Feedback",
              style: TextStyle(
                fontSize: 19.0,
              ),),

          ),
          SizedBox(height: 25,),
          Center(
            child: Text('Personality',
                style : TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                )
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(top:14.0,left:24,right:48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Introvert',
                style: TextStyle(
                  fontSize: 22.0,
                )
                ),
                Switch(
                  value: isSwitched,

                  onChanged: (value){
                    setState(() {
                      isSwitched=value;
                      print(isSwitched);
                      _isLoading = true;
                    });
                    toogle(value);
                  },
                  activeTrackColor: Colors.red,
                  activeColor: Colors.red,
                ),
                Text('Extrovert',
                style: TextStyle(
                  fontSize: 22.0,
                )
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top:14.0,left:24,right:48),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text('Extrovert',
          //           style: TextStyle(
          //             fontSize: 22.0,
          //           )),
          //
          //       Switch(
          //         value: isSwitched,
          //         onChanged: (value){
          //           setState(() {
          //             isSwitched=value;
          //             print(isSwitched);
          //           });
          //         },
          //         activeTrackColor: Colors.red,
          //         activeColor: Colors.red,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),

    );
  }
}
