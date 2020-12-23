import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rollinhead/Model/ListOfFollowers/FollowersListApi.dart';
import 'package:rollinhead/Model/ListOfFollowing/ListFollowingApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class FollowingPage extends StatefulWidget {
  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  bool _isLoading =false;
  ListFollowingApi friendlist;
  Future<List<dynamic>> fetchFriendList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');
    final response = await http.get(
      'http://rolinhead.dolphinfiresafety.com/registration/followingsList?userId=$userid',
    );
    friendlist= new ListFollowingApi.fromJsonMap(json.decode(response.body.toString()));

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
  void initState() {
    super.initState();
    _isLoading = true;
    fetchFriendList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Following'),
        ),
        body:_isLoading ? Center(child: CircularProgressIndicator()) :

        friendlist.response.length> 0 ? ListView.builder(
            itemCount: friendlist.response.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),

                title: Row (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: < Widget > [

                    ClipOval(
                      child: Image.network(friendlist.response[index].profilePictureUrl,
                        height: 100,
                        width: 100,
                        //    placeholder: AssetImage('assets/images/placeholder.png'),
                        fit: BoxFit.fill,
                      ),
                    ),

                    // searchKeyword == null || searchKeyword.isEmpty
                    //     ?
                    SizedBox(width: 10,),
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
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Icon(Icons.cancel),
                    //     ),
                    //
                    //     Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Icon(Icons.arrow_forward_ios),
                    //     ),
                    //
                    //   ],
                    // ),


                  ],),
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
