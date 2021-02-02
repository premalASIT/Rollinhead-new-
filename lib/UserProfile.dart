import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rollinhead/ChatScreen.dart';
import 'package:rollinhead/FollowersList.dart';
import 'package:rollinhead/FollowingList.dart';
import 'package:rollinhead/Model/FollowRequest/FolllowrequestApi.dart';
import 'package:rollinhead/Model/GetProfiles/UserProfileApi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rollinhead/Model/GetUsersPost/UsersPosts.dart';
import 'package:rollinhead/Model/Unfollowrequest/UnfollowReqApi.dart';
import 'package:rollinhead/discoverfeed.dart';
import 'package:rollinhead/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profileinfo.dart';

class Userprofile extends StatefulWidget {
  String uid;
  Userprofile({this.uid});
  @override
  _UserprofileState createState() => _UserprofileState(uid);
}

class _UserprofileState extends State<Userprofile> {
  String uid;
  _UserprofileState(this.uid);
  bool  _isLoading = false;
  FolllowrequestApi addperson;
  UnfollowReqApi removeperson;
  String userId;
  UserProfileApi profile;
  Future<List<dynamic>> fetchUsersList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');
    print(uid);
    print(userid);
    final response = await http.get(
      'http://rolinhead.dolphinfiresafety.com/registration/getUserProfile?userId=$userid&friendId=$uid',
    );
    profile= new UserProfileApi.fromJsonMap(json.decode(response.body.toString()));

    if(response.statusCode == 200) {
      if (response != null) {
        setState(() {
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
     userId =prefs.getString('user_Id');
    int cusId = int.parse(userId);
    Map data = {
      'userId': userId,
      'friendId': uid,
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
  addingperson(String info) async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String userId =sharedPreferences.getString('user_Id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');

//    int cusId = int.parse(userid);
    print(info);

    Map data = {
      'userId': userid,
      'friendId' : info,
    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/friendRequestAdd", body: data);
    addperson = new FolllowrequestApi.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (addperson.status.code==200) {
        setState(() {
          _isLoading = false;
        });
        //   sharedPreferences.setInt("user_Id",verifyotp.response.userId);
        print(response.body);
        print("done2");
        print("done");
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Homepage()),
                (Route<dynamic> route) => false);
        Fluttertoast.showToast(
            msg: addperson.status.message,
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
            msg: addperson.status.message,
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

  unfollowperson(String info) async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String userId =sharedPreferences.getString('user_Id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');
    print(userid);
//    int cusId = int.parse(userid);
    print(info);

    Map data = {
      'userId': userid,
      'friendId' : info,
    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/unfriendRequestAdd", body: data);
    removeperson = new UnfollowReqApi.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (removeperson.status.code==200) {
        setState(() {
          _isLoading = false;
        });
        //   sharedPreferences.setInt("user_Id",verifyotp.response.userId);
        print(response.body);
        print("done2");
        print("done");
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Homepage()),
                (Route<dynamic> route) => false);
        Fluttertoast.showToast(
            msg: removeperson.status.message,
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
            msg: removeperson.status.message,
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
  void initState() {
    super.initState();
    _isLoading=true;

    fetchUsersList();

  }
  @override
  Widget build(BuildContext context) {
    return _isLoading ? Center(child: CircularProgressIndicator()) : Scaffold(
      appBar: AppBar(
        title: Text(profile.response.userName),
          actions: <Widget>[
        IconButton(
          icon: Icon(Icons.info, color: Colors.black),
          onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => Profileinfo(id :profile.response.userId.toString())));
        },
      ),
      ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(65),

                      child: Image.network(profile.response.profilePictureUrl,
                        height: 130,
                        fit: BoxFit.fill,
                      ),

                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 130.0,
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
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(profile.response.userName != null ? profile.response.userName : " Profile",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  ),
                ),
                Text(profile.response.bio != null ? profile.response.bio : " bio",
                    maxLines: 5,
                    style: TextStyle(
                      fontSize: 18,
                    ) ),
              ],
            ),

           userId!=uid ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: profile.response.isRequested !=  true  ? RaisedButton(
                    color: Colors.red,
                    onPressed: (){
                      addingperson(profile.response.userId.toString());
                    },
                    child: Text("Follow",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                  ): profile.response.isRequested ==  true && profile.response.isFriend ==  true?
                  RaisedButton(
                    color: Colors.red,
                    onPressed: (){
                      unfollowperson(profile.response.userId.toString());
                    },
                    child: Text("Unfollow",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                  ):  profile.response.isRequested ==  true && profile.response.isFriend !=  true?
                  RaisedButton(
                    color: Colors.red,
                    onPressed: (){

                    },
                    child: Text("Requested",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                  ): RaisedButton(onPressed: (){}),
                ),

                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: RaisedButton(
                    color: Colors.red,
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => MyChatScreen(uid :profile.response.userId.toString())));
                    },
                    child: Text("Message",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ],
            ):Container(),
          viewprofile.response.length>0 && profile.response.isFriend == true  ?  GridView.builder(
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
            ):
          profile.response.isPublic == true? Center(child: Text('No Post Available'),):
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30,left: 10),
              child: Image.asset(
                    'assests/images/private_account.png',
                    height: 200,
                    width: 200,
                    fit: BoxFit.fill,
                  ),
            ),
          ),
            // Row(
            //   children: <Widget>[
            //     Image.asset(
            //       'assests/images/1.jpg',
            //       fit: BoxFit.cover,
            //     ),
            //     Image.asset(
            //       'assests/images/1.jpg',
            //       fit: BoxFit.cover,
            //     ),
            //     Image.asset(
            //       'assests/images/1.jpg',
            //       fit: BoxFit.cover,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

