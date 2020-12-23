import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rollinhead/Model/Pri_Mutedaccount/UserMutedList.dart';
import 'package:rollinhead/UserProfile.dart';
import 'package:rollinhead/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Model/UnmuteFriend/UnMutefriendApi.dart';
class MutedAccounts extends StatefulWidget {
  @override
  _MutedAccountsState createState() => _MutedAccountsState();
}

class _MutedAccountsState extends State<MutedAccounts> {
  bool _isLoading = false;
  UserMutedList mute;
  UnMutefriendApi unmute;
  Future<List<dynamic>> fetchFriendList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');
    Map data = {
      'UserId': userid,

    };
    final response = await http.post(
        'http://rolinhead.dolphinfiresafety.com/registration/GetUserMutedAccounts', body: data
    );
    mute= new UserMutedList.fromJsonMap(json.decode(response.body.toString()));

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
  unmuteperson(String id) async {
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
            builder: (BuildContext context) => Homepage()));
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
  void initState() {
    super.initState();
    _isLoading = true;
    fetchFriendList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mute Accounts'),
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator()) :
      mute.mutedFriends.length > 0 ? ListView.builder(
          itemCount: mute.mutedFriends.length,
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
                      builder: (BuildContext context) => Userprofile(uid :mute.mutedFriends[index].userId.toString())));
                },
                child: Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: < Widget > [

                    ClipOval(
                      child: Image.network(mute.mutedFriends[index].profilePictureUrl,
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
                        mute.mutedFriends[index].firstName != null ? Text(
                          mute.mutedFriends[index].firstName,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ):
                        Text(
                          "Name",
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
                        child: Text('Unmute',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ), onPressed:() {
                      setState(() {
                        _isLoading = true;
                      });
                      unmuteperson(mute.mutedFriends[index].userId.toString());
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
