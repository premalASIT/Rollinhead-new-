import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rollinhead/FollowersList.dart';
import 'package:rollinhead/FollowingList.dart';
import 'package:rollinhead/Model/GetProfiles/UserProfileApi.dart';
import 'package:rollinhead/Model/GetUsersPost/UsersPosts.dart';
import 'package:rollinhead/discoverfeed.dart';
import 'package:rollinhead/editprofile.dart';
import 'package:rollinhead/namepass.dart';
import 'package:rollinhead/profileinfo.dart';
import 'package:rollinhead/settingPage.dart';
import 'package:rollinhead/uploadpost.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(Profilepage());
}
class Profilepage extends StatefulWidget {
  @override
  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  int _currentIndex = 0;
  int _index = 0;
  String user;
  bool _isLoading=false;
  UserProfileApi profile;

  @override
  void initState() {
    super.initState();
    _isLoading=true;
    fetchUsersList();

  }

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
           user = userid;
          _isLoading = true;

        });
        fetchGetpost();
        print(response.body);
      }
    }else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }

  }
  UsersPosts viewprofile;
  Future<List<dynamic>> fetchGetpost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =prefs.getString('user_Id');
    int cusId = int.parse(userId);
    Map data = {
      'userId': userId,
      'friendId': userId,
      'start' : "0",
      'limit' : '100'
    };
    final response = await http.post(
        'http://rolinhead.dolphinfiresafety.com/registration/getUserPosts',body:data
    );
    viewprofile= new UsersPosts.fromJsonMap(json.decode(response.body.toString()));

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


  @override
  Widget build(BuildContext context) {
    return _isLoading ? Center(child: CircularProgressIndicator()) :  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

          title: Text( profile.response.userName != null ? profile.response.userName : "Username",
          style: TextStyle(
            color: Colors.black,
          ),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info, color: Colors.black),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SettingPage1()));

            },
          ),

        ],
      ),

      body:
      SingleChildScrollView(
        child: Center(

            child: Column(
              children: <Widget>[

                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(75),

                        child: Image.network(profile.response.profilePictureUrl,
                          fit: BoxFit.fill,
                          height: 150,
                          width: 150,
                        ),

                      ),
                    ),
                    Container(
                      height: 130.0,
                      width: 220.0,
                      color: Colors.transparent,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(70.0),
                                bottomRight: Radius.circular(70.0),),
                              border: Border.all(width: 3,color: Colors.black,style: BorderStyle.solid),
                          ),

                          child:Column(
                            children: <Widget>[
                               Row(
                                 children: <Widget>[
                                   Padding(
                                     padding: const EdgeInsets.only(left:18.0,top:18.0,),
                                     child: new Text("Posts",
                                        style: TextStyle(color: Colors.black, fontSize: 18),

                                        ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.only(left:11.0,top:18.0,),
                                     child: Text(profile.response.postsCount.toString(),
                                       style: TextStyle(color: Colors.black, fontSize: 18,
                                       fontWeight: FontWeight.bold,
                                       ),),
                                   ),
                                 ],
                               ),
                              Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(
                                         builder: (BuildContext context) => FollowersPage()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:18.0,top:8.0,),
                                      child: new Text("Followers",
                                        style: TextStyle(color: Colors.black, fontSize: 18),

                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:11.0,top:8.0,),
                                    child: Text(profile.response.followersCount.toString(),
                                      style: TextStyle(color: Colors.black, fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) => FollowingPage()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:18.0,top:8.0,),
                                      child: new Text("Following",
                                        style: TextStyle(color: Colors.black, fontSize: 18),

                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:11.0,top:8.0,),
                                    child: Text(profile.response.followingsCount.toString(),
                                      style: TextStyle(color: Colors.black, fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                  ),
                                ],
                              ),

                            ],
                          ),
                          ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left:0.0),


                    child:Text(profile.response.bio!=null ? profile.response.bio : "NO",
                      textAlign: TextAlign.start,

                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),

                    ),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: RaisedButton(
                      color: Colors.red,
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Editprofile()));
                      },
                      child: Text("Edit",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                // Padding(
                //   padding: const EdgeInsets.all(11.0),
                //   child: RaisedButton(
                //     color: Colors.red,
                //     onPressed:  ()async {
                //         final pref = await SharedPreferences.getInstance();
                //         await pref.clear();
                //         return
                //           Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                //               builder: (BuildContext context) => Namepass()), (
                //               Route<dynamic> route) => false);
                //       },
                //
                //     child: Text("Logout",
                //       style: TextStyle(
                //         fontSize: 20,
                //         color: Colors.white,
                //       ),),
                //     shape: new RoundedRectangleBorder(
                //       borderRadius: new BorderRadius.circular(15.0),
                //     ),
                //   ),
                // ),
                // Container(
                //   height: 260,
                //   width: 300,
                //   margin: EdgeInsets.all(10.0),
                //   decoration: BoxDecoration(
                //       color: Colors.grey,
                //       shape: BoxShape.circle
                //   ),
                //   child: Container(
                //
                //     margin: EdgeInsets.only(left:90.0,right: 90.0,top: 80,bottom: 80,),
                //     decoration: BoxDecoration(
                //         color: Colors.white,
                //       borderRadius: BorderRadius.all(Radius.circular(20)),
                //
                //     ),
                //     child: Center(
                //       child:Text("P",
                //       style: TextStyle(
                //         fontSize: 80,
                //         fontWeight: FontWeight.bold,
                //       ),
                //       ),
                //     ),
                //   ),
                // ),
                //
                // Text("Private Account",
                // style: TextStyle(
                //   fontWeight: FontWeight.bold,
                //   fontSize: 20,
                // ),
                // ),
                GridView.builder(
                  // padding: EdgeInsets.only(top: 310,
                  // left: 15,right: 15,bottom: 15),
                  itemCount: viewprofile.response.length,
                  shrinkWrap: true,
                  primary: false,
                  // physics: ScrollPhysics(),
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 2.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network(viewprofile.response[index].imagePath);
                  }
                ),
              ],
            ),

        ),
      ),


    );
  }
}

