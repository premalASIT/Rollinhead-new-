import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rollinhead/Model/SearchProfile/SerachProfileApi.dart';
import 'package:rollinhead/Model/Groupcreation/groupcreationAPI.dart';
import 'package:rollinhead/UserProfile.dart';
import 'package:rollinhead/listchats.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  String searchKeyword;
  bool _isLoading = false;
  bool _isSearching;
  SerachProfileApi usersListApi;
  GroupcreationAPI gcreate;
  SerachProfileApi _searchUsersListApi;
  TextField _searchBar;
  TextEditingController _searchBarController;
  List<Widget> _actionButtons;
  String _searchKeyword = '';
  bool _searhBarOpen = false;
  var isSelected = false;
  List<bool> _selected = List.generate(50, (i) => false);
  String memberIds = "";
  var memberId=[];
  TextEditingController detail = new TextEditingController();
  var mycolor=Colors.red;
  String filter;
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
  CreateG(String name) async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String userId =sharedPreferences.getString('user_Id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');

    Map data = {
      'UserId': userid,
      'ChatUserIds' : memberIds,
      'title' : name
    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/CreateGroup", body: data);
    gcreate = new GroupcreationAPI.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (gcreate.status.code==200) {
        setState(() {
          _isLoading = false;
        });
        //   sharedPreferences.setInt("user_Id",verifyotp.response.userId);
        print(response.body);
        print("done2");
        print("done");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ChatsLists()));
        Fluttertoast.showToast(
            msg: gcreate.status.message,
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
            msg: gcreate.status.message,
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
  void toggleSelection() {
    setState(() {
      if (isSelected) {
        // border=new BoxDecoration(border: new Border.all(color: Colors.white));
        mycolor = Colors.white;
        isSelected = false;
      } else {
        // border=new BoxDecoration(border: new Border.all(color: Colors.grey));
        mycolor = Colors.grey[300];
        isSelected = true;
      }
    });
  }
  Widget getname() {
    return Container(
        height: 170.0, // Change as per your requirement
        width: 150.0, // Change as per your requirement
        child: ListView(
          children: [
            Text("Group Name"),

            TextFormField(

              controller: detail,
              validator: (value){
                if(value.isEmpty){
                  return "* required";
                }
                return null;
              },
            ),
            SizedBox(height: 17,),
            MaterialButton(
              height: 50,
              color: Colors.red,
              child: Text("Create",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  )),
              elevation: 10.0,
              minWidth: MediaQuery.of(context).size.width/1.2,
              onPressed:(){
                setState(() {
                  _isLoading = true;
                });
                  CreateG(detail.text);
              },
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
            ),
          ],
        )

    );
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
        // backgroundColor: _isSearching
        //     ? Colors.white
        //     : null,
        // leading: _isSearching
        //     ? IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   color: const Color(0xFFE07E1B),
        //   onPressed: () {
        //     setState(() {
        //       _searhBarOpen = false;
        //       _isSearching = false;
        //       _searchBarController?.text = "";
        //       _searchKeyword ="";
        //       fetchUsersList();
        //     });
        //   },
        // )
        //     : null,
        // title: _isSearching
        //     ? _searchBar
        //     : Text(
        //   'Create Group',
        // ),
        // actions: _isSearching
        //     ? null
        //     : _actionButtons,
        title: Text('Create Group'),
      ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                child: Text('Create',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                ),
                  color: Colors.red,
                  height: 40,
                  minWidth: 200,
                  onPressed: (){
                  if(memberIds != "") {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Group Name'),
                            content: getname(),
                          );
                        }
                    );
                  }
                  else{
                    Fluttertoast.showToast(
                        msg: "Group Should have at least one member",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 2
                    );
                  }
                  }
              ),
            ),
          ],
        ),
        body:_isLoading ? Center(child: CircularProgressIndicator()) :
        _searchBarController.text.isEmpty?
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView.builder(

              itemCount: usersListApi.response.length,
              itemBuilder: (context, index) {
                return  ListTile(


                    // onLongPress: toggleSelection,
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

                  onTap: () {
                    setState((){
                      _selected[index] = !_selected[index];
                      if(_selected[index]){
                        //// Add in Array
                        memberId.add(usersListApi.response[index].userId.toString());
                        memberIds = memberId.reduce((value, element) => value + ',' + element);
                        print(memberIds);
                      } else {
                        //// Remove From Array
                        memberId.remove(usersListApi.response[index].userId.toString());
                        //    memberIds = memberId.reduce((value, element) => value + ',' + element);
                      }
                    });
                  },
                      title: Row (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: < Widget > [

                          ClipOval(
                            child: Image.network(usersListApi.response[index].profilePictureUrl,
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
                              usersListApi.response[index].firstName != null ? Text(
                                usersListApi.response[index].firstName,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: _selected[index] ? Color(0xFFE07E1B) : Colors.black,
                                ),
                              ):
                              Text(
                                "abc",
                                maxLines: 1,
                                style: TextStyle(
                                  color: _selected[index] ? Color(0xFFE07E1B) : Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              usersListApi.response[index].userName != null ? Text(
                                usersListApi.response[index].userName,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: _selected[index] ? Color(0xFFE07E1B) : Colors.black,
                                ),
                              ):
                              Text(
                                "UserName",
                                maxLines: 1,
                                style: TextStyle(
                                  color: _selected[index] ? Color(0xFFE07E1B) : Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

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
                          SizedBox(width: 7,),
                        ],),


                  );
              }),
        ):
        ListView.builder(
            itemCount: _searchUsersListApi.response.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                // leading: SizedBox(
                //   width: 110.0,
                //   height: 150.0,
                //   child: CircleAvatar(
                //     radius: 110,
                //     foregroundColor: Theme.of(context).primaryColor,
                //     backgroundColor: Colors.grey,
                //     backgroundImage: NetworkImage( _searchUsersListApi.response[index].profilePictureUrl),
                //   ),
                // ),
                title: Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: < Widget > [
                    ClipOval(
                      child: Image.network(_searchUsersListApi.response[index].profilePictureUrl,
                        height: 100,
                        width: 100,
                        //    placeholder: AssetImage('assets/images/placeholder.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    // searchKeyword == null || searchKeyword.isEmpty
                    //     ?
                    _searchUsersListApi.response[index].firstName != null ? Text(
                      _searchUsersListApi.response[index].firstName,
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

                  ],),
                onTap: (){},
              );
            })
    );
  }
}
