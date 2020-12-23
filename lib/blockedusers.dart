import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:rollinhead/Model/Pri_BlockedList/ListBlockedUser.dart';
import 'package:rollinhead/Model/UnblockFriend/unblockperson.dart';
import 'package:rollinhead/UserProfile.dart';
import 'package:rollinhead/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Model/Pri_BlockedList/ListBlockedUser.dart';
import 'Model/UnblockFriend/unblockperson.dart';

class BlockedUser extends StatefulWidget {
  @override
  _BlockedUserState createState() => _BlockedUserState();
}

class _BlockedUserState extends State<BlockedUser> {
  bool _isLoading = false;
  ListBlockedUser block;
  Unblockperson unblock;
  Future<List<dynamic>> fetchFriendList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');
    Map data = {
      'UserId': userid,

    };
    final response = await http.post(
      'http://rolinhead.dolphinfiresafety.com/registration/GetUserBlockedAccounts', body: data
    );
    block= new ListBlockedUser.fromJsonMap(json.decode(response.body.toString()));

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
  unblockedperson(String id) async {
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
            builder: (BuildContext context) => Homepage()));
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
  void initState() {
    super.initState();
    _isLoading = true;
    fetchFriendList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: _isLoading ? Center(child: CircularProgressIndicator()) :
      block.blockedFriends.length > 0 ? ListView.builder(
          itemCount:  block.blockedFriends.length,
          itemBuilder: (context, index) {
            return ListTile(

              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              // leading:  CircleAvatar(
              //     radius: 80,
              //
              //     foregroundColor: Theme.of(context).primaryColor,
              //     backgroundColor: Colors.grey,
              //
              //     backgroundImage: NetworkImage(usersListApi.response[index].profilePictureUrl,
              //     ),
              //   ),

              title: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Userprofile(uid :block.blockedFriends[index].userId.toString())));
                },
                child: Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: < Widget > [

                    ClipOval(
                      child: Image.network(block.blockedFriends[index].profilePictureUrl,
                        height: 100,
                        width: 100,
                        //    placeholder: AssetImage('assets/images/placeholder.png'),
                        fit: BoxFit.fill,
                      ),
                    ),

                    // searchKeyword == null || searchKeyword.isEmpty
                    //     ?
                    Column(
                      children: <Widget>[
                        block.blockedFriends[index].firstName != null ? Text(
                          block.blockedFriends[index].firstName,
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
                        // block.blockedFriends[index].userName != null ? Text(
                        //   block.blockedFriends[index].userName,
                        //   maxLines: 1,
                        //   style: TextStyle(
                        //     fontSize: 18.0,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ):
                        // Text(
                        //   "UserName",
                        //   maxLines: 1,
                        //   style: TextStyle(
                        //
                        //     fontSize: 18.0,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ],
                    ),
                    // : TextHelpers.getHighlightedText(
                    // usersListApi.response[index].firstName,
                    // searchKeyword,
                    // TextStyle(
                    //   fontSize: 18.0,
                    //   fontWeight: FontWeight.bold,
                    //   color: Colors.black,
                    // ),
                    // TextStyle(
                    //   fontSize: 18.0,
                    //   fontWeight: FontWeight.bold,
                    //   color: Colors.blue,
                    // )),
                    FlatButton(
                        color: Colors.red,
                        child: Text('Unblock',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ), onPressed:() {
                      setState(() {
                        _isLoading = true;
                      });
                    unblockedperson(block.blockedFriends[index].userId.toString());
                    })
                  ],),
              ),
              onTap: (){},
            );
          }):
          Center(child: Text('No User found'),),
    );
  }
}
