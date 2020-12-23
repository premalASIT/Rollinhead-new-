import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rollinhead/Model/FollowRequest/FolllowrequestApi.dart';
import 'package:rollinhead/Model/SearchProfile/SerachProfileApi.dart';
import 'package:rollinhead/Model/Unfollowrequest/UnfollowReqApi.dart';
import 'package:rollinhead/UserProfile.dart';
import 'package:rounded_floating_app_bar/rounded_floating_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Discoverfeed extends StatefulWidget {
  @override
  _DiscoverfeedState createState() => _DiscoverfeedState();
}

class _DiscoverfeedState extends State<Discoverfeed> {
  String searchKeyword;
  bool _isLoading = false;
  bool _isSearching;
  SerachProfileApi usersListApi;
  SerachProfileApi _searchUsersListApi;
  TextField _searchBar;
  TextEditingController _searchBarController;
  List<Widget> _actionButtons;
  String _searchKeyword = '';
  bool _searhBarOpen = false;
  String filter;
  FolllowrequestApi addperson;
  UnfollowReqApi removeperson;
  Future<List<dynamic>> fetchUsersList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');
    final response = await http.get(
      'http://rolinhead.dolphinfiresafety.com/registration/filterFriendList?userId=$userid & key=$_searchKeyword',
    );
    usersListApi= new SerachProfileApi.fromJsonMap(json.decode(response.body.toString()));
    _searchUsersListApi= new SerachProfileApi.fromJsonMap(json.decode(response.body.toString()));
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
  // Future<List<dynamic>> fetchFriendList() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final response = await http.get(
  //     PsConfig.ps_app_url+'user/friendList?limit=100&start=0',
  //     headers: {'x-auth-token': prefs.getString('userToken')},
  //   );
  //   friendListApi= new FriendListApi.fromJsonMap(json.decode(response.body.toString()));
  //   if(response.statusCode == 200) {
  //     if (response != null) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       print(response.body);
  //     }
  //   }else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     print(response.body);
  //   }
  //
  // }

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
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => Discoverfeed()));
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
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => Discoverfeed()));
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
    _isSearching = false;
    fetchUsersList();
    _searchBarController = new TextEditingController();
    _searchBarController.addListener(() {
      setState(() {
        searchKeyword = _searchBarController.text;
      });
    });

    _searchBar = new TextField(
      controller: _searchBarController,
      autofocus: true,
      textInputAction: TextInputAction.search,
      onChanged:onSearchTextChanged,
      decoration: InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
      ),
    );
    _actionButtons = <Widget>[
      IconButton(
        tooltip: "Search",
        icon: const Icon(Icons.search),
        onPressed: () {
          setState(() {
            _searhBarOpen = true;
            _isSearching = true;
            _searchBarController?.text = "";
          });
        },
      ),
    ];
// contacts = getContacts();
// _getNumContacts().then((num) {
// setState(() {
// numContacts = num;
// });
// });
  }

  onSearchTextChanged(String text) async {
    _searchUsersListApi.response.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    usersListApi.response.forEach((userDetail) {
      if (userDetail.firstName.toLowerCase().contains(text.toLowerCase()))
        _searchUsersListApi.response.add(userDetail);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _isSearching
            ? Colors.white
            : null,
        leading: _isSearching
            ? IconButton(
          icon: Icon(Icons.arrow_back),
          color: const Color(0xFFE07E1B),
          onPressed: () {
            setState(() {
              _searhBarOpen = false;
              _isSearching = false;
             _searchBarController?.text = "";
              _searchKeyword ="";
              fetchUsersList();
            });
          },
        )
            : null,
        title: _isSearching
            ? _searchBar
            : Text(
          'Search',
        ),
        actions: _isSearching
            ? null
            : _actionButtons,
      ),
      body:_isLoading ? Center(child: CircularProgressIndicator()) :
      _searchBarController.text.isEmpty?
      GridView.builder(
          itemCount: usersListApi.response.length,
          shrinkWrap: true,

          primary: true,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 25.0,
          ),
          itemBuilder: (context, index) {
            return Container(
              height: 400,
              width: 120,
//              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              // leading:  CircleAvatar(
              //     radius: 80,
              //
              //     foregroundColor: Theme.of(context).primaryColor,
              //     backgroundColor: Colors.grey,
              //
              //     backgroundImage: NetworkImage(usersListApi.response[index].profilePictureUrl,
              //     ),
              //   ),

              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Userprofile(uid :usersListApi.response[index].userId.toString())));
                },
                child: Column (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: < Widget > [

//                    Container(
////                      height: 400,
//                      child: ClipRRect(
//                        borderRadius: BorderRadius.circular(8.0),
//                        child: Image.network(usersListApi.response[index].profilePictureUrl,
//                          height: 170,
//                          width: 150,
//                          //    placeholder: AssetImage('assets/images/placeholder.png'),
//                          fit: BoxFit.fill,
//                        ),
//                      ),
//                    ),
                    Container(
                      width: 170.0,
                      height: 180.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(usersListApi.response[index].profilePictureUrl,
                          )),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: Colors.redAccent,
                      ),
                    ),
                    // searchKeyword == null || searchKeyword.isEmpty
                    //     ?
//                    Column(
//                      children: <Widget>[
//                    usersListApi.response[index].firstName != null ? Text(
//                      usersListApi.response[index].firstName,
//                      maxLines: 1,
//                      style: TextStyle(
//                        fontSize: 18.0,
//                        fontWeight: FontWeight.bold,
//                      ),
//                    ):
//                    Text(
//                      "abc",
//                      maxLines: 1,
//                      style: TextStyle(
//
//                        fontSize: 18.0,
//                        fontWeight: FontWeight.bold,
//                      ),
//                    ),
                        usersListApi.response[index].userName != null ? Text(
                          usersListApi.response[index].userName,
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
//                      ],
//                    ),
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
//                    usersListApi.response[index].isRequested !=  true  ? FlatButton(
//                        color: Colors.red,
//                        child: Text('Follow',
//                          style: TextStyle(
//                              color: Colors.white,
//                              fontWeight: FontWeight.bold
//                          ),
//                        ), onPressed:() {
//                      setState(() {
//                        _isLoading = true;
//                      });
//                     addingperson(usersListApi.response[index].userId.toString());
//                    }):
//                    usersListApi.response[index].isRequested ==  true && usersListApi.response[index].isFriend ==  true?
//                    FlatButton(
//                        color: Colors.red,
//                        child: Text('Unfollow',
//                          style: TextStyle(
//                              color: Colors.white,
//                              fontWeight: FontWeight.bold
//                          ),
//                        ), onPressed:() {
//                      unfollowperson(usersListApi.response[index].userId.toString());
//                    }) :
//                    usersListApi.response[index].isRequested ==  true && usersListApi.response[index].isFriend !=  true?
//                    FlatButton(
//                        color: Colors.red,
//                        child: Text('Requested',
//                          style: TextStyle(
//                              color: Colors.white,
//                              fontWeight: FontWeight.bold
//                          ),
//                        ), onPressed:() {
//                      // setState(() {
//                      //   _isLoading = true;
//                      // });
//                      // addingperson(usersListApi.response[index].userId.toString());
//                    }):
//                        FlatButton(),
                  ],),
              ),
//              onTap: (){},
            );
          }):
      GridView.builder(
          itemCount: _searchUsersListApi.response.length,
          shrinkWrap: true,

          primary: true,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 25.0,
          ),
          itemBuilder: (context, index) {
            return Container(
              height: 400,
              width: 120,
//              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              // leading:  CircleAvatar(
              //     radius: 80,
              //
              //     foregroundColor: Theme.of(context).primaryColor,
              //     backgroundColor: Colors.grey,
              //
              //     backgroundImage: NetworkImage(usersListApi.response[index].profilePictureUrl,
              //     ),
              //   ),

              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Userprofile(uid :_searchUsersListApi.response[index].userId.toString())));
                },
                child: Column (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: < Widget > [

//                    Container(
////                      height: 400,
//                      child: ClipRRect(
//                        borderRadius: BorderRadius.circular(8.0),
//                        child: Image.network(usersListApi.response[index].profilePictureUrl,
//                          height: 170,
//                          width: 150,
//                          //    placeholder: AssetImage('assets/images/placeholder.png'),
//                          fit: BoxFit.fill,
//                        ),
//                      ),
//                    ),
                    Container(
                      width: 170.0,
                      height: 180.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(_searchUsersListApi.response[index].profilePictureUrl,
                        )),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: Colors.redAccent,
                      ),
                    ),
                    // searchKeyword == null || searchKeyword.isEmpty
                    //     ?
//                    Column(
//                      children: <Widget>[
//                    usersListApi.response[index].firstName != null ? Text(
//                      usersListApi.response[index].firstName,
//                      maxLines: 1,
//                      style: TextStyle(
//                        fontSize: 18.0,
//                        fontWeight: FontWeight.bold,
//                      ),
//                    ):
//                    Text(
//                      "abc",
//                      maxLines: 1,
//                      style: TextStyle(
//
//                        fontSize: 18.0,
//                        fontWeight: FontWeight.bold,
//                      ),
//                    ),
                    _searchUsersListApi.response[index].userName != null ? Text(
                      _searchUsersListApi.response[index].userName,
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
//                      ],
//                    ),
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
//                    usersListApi.response[index].isRequested !=  true  ? FlatButton(
//                        color: Colors.red,
//                        child: Text('Follow',
//                          style: TextStyle(
//                              color: Colors.white,
//                              fontWeight: FontWeight.bold
//                          ),
//                        ), onPressed:() {
//                      setState(() {
//                        _isLoading = true;
//                      });
//                     addingperson(usersListApi.response[index].userId.toString());
//                    }):
//                    usersListApi.response[index].isRequested ==  true && usersListApi.response[index].isFriend ==  true?
//                    FlatButton(
//                        color: Colors.red,
//                        child: Text('Unfollow',
//                          style: TextStyle(
//                              color: Colors.white,
//                              fontWeight: FontWeight.bold
//                          ),
//                        ), onPressed:() {
//                      unfollowperson(usersListApi.response[index].userId.toString());
//                    }) :
//                    usersListApi.response[index].isRequested ==  true && usersListApi.response[index].isFriend !=  true?
//                    FlatButton(
//                        color: Colors.red,
//                        child: Text('Requested',
//                          style: TextStyle(
//                              color: Colors.white,
//                              fontWeight: FontWeight.bold
//                          ),
//                        ), onPressed:() {
//                      // setState(() {
//                      //   _isLoading = true;
//                      // });
//                      // addingperson(usersListApi.response[index].userId.toString());
//                    }):
//                        FlatButton(),
                  ],),
              ),
//              onTap: (){},
            );
          })
//      ListView.builder(
//          itemCount: _searchUsersListApi.response.length,
//          itemBuilder: (context, index) {
//            return ListTile(
//              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
//              // leading: SizedBox(
//              //   width: 110.0,
//              //   height: 150.0,
//              //   child: CircleAvatar(
//              //     radius: 110,
//              //     foregroundColor: Theme.of(context).primaryColor,
//              //     backgroundColor: Colors.grey,
//              //     backgroundImage: NetworkImage( _searchUsersListApi.response[index].profilePictureUrl),
//              //   ),
//              // ),
//              title: Row (
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: < Widget > [
//                  ClipOval(
//                    child: Image.network(_searchUsersListApi.response[index].profilePictureUrl,
//                      height: 100,
//                      width: 100,
//                      //    placeholder: AssetImage('assets/images/placeholder.png'),
//                      fit: BoxFit.fill,
//                    ),
//                  ),
//                  // searchKeyword == null || searchKeyword.isEmpty
//                  //     ?
//                  _searchUsersListApi.response[index].firstName != null ? Text(
//                    _searchUsersListApi.response[index].firstName,
//                    maxLines: 1,
//                    style: TextStyle(
//                      fontSize: 18.0,
//                      fontWeight: FontWeight.bold,
//                    ),
//                  ):
//                  Text(
//                    "abc",
//                    maxLines: 1,
//                    style: TextStyle(
//                      fontSize: 18.0,
//                      fontWeight: FontWeight.bold,
//                    ),
//                  ),
//                  // : TextHelpers.getHighlightedText(
//                  // usersListApi.response[index].firstName,
//                  // searchKeyword,
//                  // TextStyle(
//                  //   fontSize: 18.0,
//                  //   fontWeight: FontWeight.bold,
//                  //   color: Colors.black,
//                  // ),
//                  // TextStyle(
//                  //   fontSize: 18.0,
//                  //   fontWeight: FontWeight.bold,
//                  //   color: Colors.blue,
//                  // )),
//                  FlatButton(
//                      color: Colors.red,
//                      child: Text('Follow',
//                        style: TextStyle(
//                            color: Colors.white,
//                            fontWeight: FontWeight.bold
//                        ),
//                      ), onPressed:() {
//                    setState(() {
//                      _isLoading = true;
//                    });
//                    addingperson(usersListApi.response[index].userId.toString());
//                  }),
//                ],),
//              onTap: (){},
//            );
//          })

    );
  }


// @override
// Widget build(BuildContext context) {
// return WillPopScope(
// onWillPop: () async {
// if(_searhBarOpen) {
// setState(() {
// _searhBarOpen = false;
// _isSearching = false;
// _searchBarController?.text = "";
// });
// return false;
// }
// else {
// return true;
// }
// },
// child:
// AppBar(
// backgroundColor: _isSearching
// ? Colors.white
// : null,
// leading: _isSearching
// ? IconButton(
// icon: Icon(Icons.arrow_back),
// color: const Color(0xff075e54),
// onPressed: () {
// setState(() {
// _searhBarOpen = false;
// _isSearching = false;
// _searchBarController?.text = "";
// });
// },
// )
// : null,
// title: _isSearching
// ? _searchBar
// : Text(
// 'Flash',
// ),
// actions: _isSearching
// ? null
// : _actionButtons,
// ),
// );
// }
}
