import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rollinhead/Model/BlockFriend/BlockfriendApi.dart';
import 'package:rollinhead/Model/MuteFriend/MuteFriendApi.dart';
import 'package:rollinhead/Model/ReportUser/ReportuserApi.dart';
import 'package:rollinhead/Model/UnblockFriend/unblockperson.dart';
import 'package:rollinhead/Model/GetProfiles/UserProfileApi.dart';
import 'package:rollinhead/Model/UnmuteFriend/UnMutefriendApi.dart';
import 'package:rollinhead/discoverfeed.dart';
import 'package:rollinhead/profilepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class Profileinfo extends StatefulWidget {
  String id;
  Profileinfo({this.id});
  @override
  _ProfileinfoState createState() => _ProfileinfoState(id);
}

class _ProfileinfoState extends State<Profileinfo> {
  String id;
  _ProfileinfoState(this.id);
  bool  _isLoading = false;
  BlockfriendApi blockperson;
  Unblockperson unblock;
  UserProfileApi profile;
  MuteFriendApi mute;
  UnMutefriendApi unmute;
  ReportuserApi report;
  String content;
  blockedperson() async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String userId =sharedPreferences.getString('user_Id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');
    print(userid);
    print(id);
    Map data = {
      'userId': userid,
      'friendId' : id,
    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/blockFriend", body: data);
    blockperson = new BlockfriendApi.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (blockperson.status.code==200) {
        setState(() {
          _isLoading = false;
        });
        //   sharedPreferences.setInt("user_Id",verifyotp.response.userId);
        print(response.body);
        print("done2");
        print("done");
        Navigator.of(context).push(MaterialPageRoute(
                   builder: (BuildContext context) => Discoverfeed()));
        Fluttertoast.showToast(
            msg: blockperson.status.message,
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
            msg: blockperson.status.message,
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
  unblockedperson() async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String userId =sharedPreferences.getString('user_Id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');
    print(userid);
    print(id);
    Map data = {
      'userId': userid,
      'friendId' : id,
    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/unblockFriend", body: data);
    unblock = new Unblockperson.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (unblock.status.code==200) {
        setState(() {
          _isLoading = false;
        });
        //   sharedPreferences.setInt("user_Id",verifyotp.response.userId);
        print(response.body);
        print("done2");
        print("done");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => Discoverfeed()));
        Fluttertoast.showToast(
            msg: unblock.status.message,
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
            msg: unblock.status.message,
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
  muteperson() async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String userId =sharedPreferences.getString('user_Id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');
    print(userid);
    print(id);
    Map data = {
      'userId': userid,
      'friendId' : id,
    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/muteFriend", body: data);
    mute = new MuteFriendApi.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (mute.status.code==200) {
        setState(() {
          _isLoading = false;
        });
        //   sharedPreferences.setInt("user_Id",verifyotp.response.userId);
        print(response.body);
        print("done2");
        print("done");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => Discoverfeed()));
        Fluttertoast.showToast(
            msg: mute.status.message,
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
            msg: unblock.status.message,
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
  unmuteperson() async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String userId =sharedPreferences.getString('user_Id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');
    print(userid);
    print(id);
    Map data = {
      'userId': userid,
      'friendId' : id,
    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/unmuteFriend", body: data);
    unmute = new UnMutefriendApi.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (unmute.status.code==200) {
        setState(() {
          _isLoading = false;
        });
        //   sharedPreferences.setInt("user_Id",verifyotp.response.userId);
        print(response.body);
        print("done2");
        print("done");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => Discoverfeed()));
        Fluttertoast.showToast(
            msg: unmute.status.message,
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
            msg: unmute.status.message,
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
  reportuser() async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String userId =sharedPreferences.getString('user_Id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');
    print(userid);
    print(id);
    Map data = {
      'userId': userid,
      'friendId' : id,
      'reportContent': content
    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/reportFriend", body: data);
    report = new ReportuserApi.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (report.status.code==200) {
        setState(() {
          _isLoading = false;
        });
        //   sharedPreferences.setInt("user_Id",verifyotp.response.userId);
        print(response.body);
        print("done2");
        print("done");
        Navigator.pop(context, true);
        Fluttertoast.showToast(
            msg: report.status.message,
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
            msg: report.status.message,
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

  Future<List<dynamic>> fetchUsersList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');
    final response = await http.get(
      'http://rolinhead.dolphinfiresafety.com/registration/getUserProfile?userId=$userid & friendId=$id',
    );
    profile= new UserProfileApi.fromJsonMap(json.decode(response.body.toString()));

    if(response.statusCode == 200) {
      if (response != null) {
        setState(() {

          _isLoading = false;
        });
        print(response.body);
      }
    }else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }

  }
  Widget getcontent() {
    return Container(
      height: 150.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child:  Column(
        children: [
          ListTile(
                onTap: (){

                setState(() {
                  content = "spam";
                  _isLoading = true;
                });
                reportuser();
                },
                title: Column(
                  children: <Widget>[

                    Text("Spam",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 18,
                      ),),

                    Text("",
                      style: TextStyle(

                        fontSize: 11,
                      ),
                    ),
                    Container(width: 400,height:1,color: Colors.deepPurple,),
                  ],
                ),
              ),
            ListTile(
              onTap: () {
    
                setState(() {
                  content = "inappropriate";
                  _isLoading = true;
                });
                reportuser();
              },
              title: Column(
                children: <Widget>[

                  Text("Inappropriate",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 18,
                    ),),

                  Text("",
                    style: TextStyle(

                      fontSize: 11,
                    ),
                  ),
                  Container(width: 400,height:1,color: Colors.deepPurple,),
                ],
              ),
            ),
          ],
        ),


      );
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
        title: Text("Details",
        style: TextStyle(
          fontSize: 18,
        ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(160),

              child: profile.response.profilePictureUrl != null ?
              Image.network(profile.response.profilePictureUrl,
                height: 150,
                width: 150,
              ):
              Image.asset("assests/images/1.jpg",
                height: 150,
                width: 150,
              )

            ),
          ),
          Text(profile.response.userName!= null ? profile.response.userName : "Profile Name",
            style: TextStyle(
              fontSize: 18,

              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                 child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FlatButton(

                        child: Text("Following",

                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Discoverfeed()));
                      },
                    ),
                  )

            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FlatButton(
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Select reason'),
                            content: getcontent(),
                          );
                        }
                    );
                  },
                  child:Text("Report",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            profile.response.isBlocked!= true ?
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FlatButton(
                  onPressed: (){
                   blockedperson();
                  },
                  child:Text("Block",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                ),
              ):
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FlatButton(
                onPressed: (){
                  unblockedperson();
                },
                child:Text("Unblock",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
              profile.response.isMuted!= true ?   ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FlatButton(
                  onPressed: (){
                    muteperson();
                  },
                  child:Text("Mute",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,

                    ),
                  ),
                ),
              ):ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FlatButton(
                  onPressed: (){
                    unmuteperson();
                  },
                  child:Text("Unmute",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,

                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
