import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:rollinhead/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Model/SearchProfile/SerachProfileApi.dart';

class TagUserPosts extends StatefulWidget {
  String location,message;
  File images;
  TagUserPosts({this.location,this.message,this.images});
  @override
  _TagUserPostsState createState() => _TagUserPostsState(location,message,images);
}

class _TagUserPostsState extends State<TagUserPosts> {
  String location,message;
  File images;
  _TagUserPostsState(this.location,this.message,this.images);

  Future uploadImageMedia(File fileImage,String Msg,Loc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final mimeTypeData =
    lookupMimeType(fileImage.path, headerBytes: [0xFF, 0xD8]).split('/');
    final imageUploadRequest =
    http.MultipartRequest('POST', Uri.parse("http://rolinhead.dolphinfiresafety.com/registration/createPost"));
    final file = await http.MultipartFile.fromPath('imagefile', fileImage.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    final vfile = await http.MultipartFile.fromPath('videofile', fileImage.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
//  prefs.setString("imgpath", pathImages);
    imageUploadRequest.fields['userId']= prefs.getString('user_Id') ;
    imageUploadRequest.fields['content']= Msg;
    imageUploadRequest.fields['location']= Loc;
    imageUploadRequest.fields['mentionUserIds']= memberIds;

    imageUploadRequest.files.add(file);
    imageUploadRequest.files.add(vfile);
    try {
      _isLoading = false;

      final streamedResponse = await imageUploadRequest.send();

      streamedResponse.stream.transform(utf8.decoder).listen((value) {
        Fluttertoast.showToast(
            msg:"Successfully post",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        //     builder: (BuildContext context) => Homepage()), (
        //     Route<dynamic> route) => false);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Homepage()),
                (Route<dynamic> route) => false);
        print(value);
        return Future.value(value);
      });
    } catch (e) {
      print(e);
    }
  }

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
  @override
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
          'Tag People',
        ),
        actions: _isSearching
            ? null
            : _actionButtons,

      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
                child: Text('Post',
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
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) => Homepage()));
                    setState(() {
                      _isLoading = true;
                    });
                    uploadImageMedia(images,message,location);
                  }
                  else{
                    setState(() {
                      _isLoading = true;
                    });
                    uploadImageMedia(images,message,location);
                    Fluttertoast.showToast(
                        msg: "You hadn't tag anyone",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 2
                    );
                    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Homepage()),
                    //         (Route<dynamic> route) => false);
                  }
                }
            ),
          ),
        ],
      ),
      body:  _isLoading ? Center(child: CircularProgressIndicator()) :
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
    }),
    );
  }
}
