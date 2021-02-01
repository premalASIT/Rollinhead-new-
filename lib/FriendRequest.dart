import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rollinhead/Model/FriendReqList/FriendReqApi.dart';
import 'package:rollinhead/Model/friendAcceptapi/FriendReqAccept.dart';
import 'package:rollinhead/Model/friendRejectapi/FriendReqReject.dart';
import 'package:rollinhead/UserProfile.dart';
import 'package:rollinhead/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class Friendrequest extends StatefulWidget {
  @override
  _FriendrequestState createState() => _FriendrequestState();
}

class _FriendrequestState extends State<Friendrequest> {
  bool _isLoading =false;
  FriendReqApi friendlist;
  FriendReqAccept acceptreq;
  FriendReqReject rejectreq;
  Future<List<dynamic>> fetchFriendList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');
    final response = await http.get(
      'http://rolinhead.dolphinfiresafety.com/registration/friendRequestList?userId=$userid',
    );
    friendlist= new FriendReqApi.fromJsonMap(json.decode(response.body.toString()));

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
  addingperson(String info) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');
    print(info);

    Map data = {
      'friend_list_id' : info,
    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/acceptFriendRequest", body: data);
    acceptreq = new FriendReqAccept.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (acceptreq.status.code==200) {
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
            msg: acceptreq.status.message,
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
            msg: acceptreq.status.message,
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
  rejectingperson(String info) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');
    print(info);

    Map data = {
      'friend_list_id' : info,
    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/acceptFriendRequest", body: data);
    rejectreq = new FriendReqReject.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (rejectreq.status.code==200) {
        setState(() {
          _isLoading = false;
        });
        //   sharedPreferences.setInt("user_Id",verifyotp.response.userId);
        print(response.body);
        print("done2");
        print("done");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => Homepage()));
        Fluttertoast.showToast(
            msg: rejectreq.status.message,
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
            msg: rejectreq.status.message,
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
  void initState() {
    super.initState();
    _isLoading = true;
    fetchFriendList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Friend Request',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),
        ),
      ),
      body:_isLoading ? Center(child: CircularProgressIndicator()) :

        friendlist.response.length> 0 ? ListView.builder(
        itemCount: friendlist.response.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),

            title: InkWell(
              onTap: (){

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Userprofile(uid :friendlist.response[index].userId.toString())));
              },
              child: Row (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: < Widget > [

                  ClipOval(
                    child: Image.network(friendlist.response[index].profilePictureUrl,
                      height: 80,
                      width: 80,
                      //    placeholder: AssetImage('assets/images/placeholder.png'),
                      fit: BoxFit.fill,
                    ),
                  ),

                  // searchKeyword == null || searchKeyword.isEmpty
                  //     ?
                  Column(
                    children: <Widget>[
                      friendlist.response[index].firstName != null ? Text(
                        friendlist.response[index].firstName,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ):
                      Text(
                        "abc",
                        maxLines: 1,
                        style: TextStyle(

                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      friendlist.response[index].userName != null ? Text(
                        friendlist.response[index].userName,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ):
                      Text(
                        "UserName",
                        maxLines: 1,
                        style: TextStyle(

                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton( icon: Icon(Icons.cancel), onPressed: (){
                            setState(() {
                              _isLoading = true;
                            });
                            addingperson(friendlist.response[index].friend_list_id.toString());
                      },),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton( icon: Icon(Icons.arrow_back_ios), onPressed: (){
                        setState(() {
                          _isLoading = true;
                        });
                        rejectingperson(friendlist.response[index].friend_list_id.toString());
                      },),
                    ),

                  ],
                ),


                ],),
            ),
          );
        }
        ):
            Center(child: Text('No Request',
            style: TextStyle(
              fontSize: 18,
            ),
            ),)

    );
  }
}
