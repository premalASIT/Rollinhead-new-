import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rollinhead/ChatScreen.dart';
import 'package:rollinhead/Model/UserListChats/ChatingUsers.dart';
import 'package:rollinhead/groupchatscreen.dart';
import 'package:rollinhead/groupcreate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class ChatsLists extends StatefulWidget {
  @override
  _ChatsListsState createState() => _ChatsListsState();
}

class _ChatsListsState extends State<ChatsLists> {
  bool _isLoading = false;
  ChatingUsers chats;
  Timer timerApi;
  Future<List<dynamic>> fetchGetchat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =prefs.getString('user_Id');
    print("pl[pl[pl[p" + userId);
    final response = await http.get(
        'http://rolinhead.dolphinfiresafety.com/registration/GetUserChatList/$userId'
    );
    chats= new ChatingUsers.fromJsonMap(json.decode(response.body.toString()));

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
  void initState() {
    _isLoading=true;

      fetchGetchat();
      timerApi = Timer.periodic(Duration(seconds: 1), (Timer t) => fetchGetchat());

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('People'),
        ),
      body: _isLoading ? Center(child: CircularProgressIndicator()) :  SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Create Group',style: TextStyle(color: Colors.black),),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>CreateGroup()));
                    }
                ),
              ),
              chats.chat_list.length  > 0 ?  ListView.builder(
                  itemCount: chats.chat_list.length,
                  // itemCount: chats.chat_list.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return  chats.chat_list[index].userDetail.length > 0 ? ListTile(

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
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (BuildContext context) => Userprofile(uid :usersListApi.response[index].userId.toString())));
                          if(chats.chat_list[index].title == "") {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MyChatScreen(uid: chats.chat_list[index]
                                        .userDetail[0].userId)));
                          }
                          else{
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MyGroupScreen(uid: chats.chat_list[index]
                                        .ID)));
                          }

                        },
                        child: Row (
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: < Widget > [
                            chats.chat_list[index].userDetail[0].userProfilePicture != null ?
                            ClipOval(
                              child: Image.network(
                                chats.chat_list[index].userDetail[0].userProfilePicture,
                                height: 60,
                                width: 60,
                                //    placeholder: AssetImage('assets/images/placeholder.png'),
                                fit: BoxFit.fill,
                              ),
                            ):
                            ClipOval(
                              child: Image.asset(
                               "assests/images/avtar.png",
                                height: 60,
                                width: 60,
                                //    placeholder: AssetImage('assets/images/placeholder.png'),
                                fit: BoxFit.fill,
                              ),
                            ),

                            // searchKeyword == null || searchKeyword.isEmpty
                            //     ?

                            Column(
                              children: <Widget>[
                                chats.chat_list[index].title == "" ?
                                Text(chats.chat_list[index].userDetail[0].userName.toString(),
                                  // usersListApi.response[index].firstName,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ) :
                                Text(
                                  chats.chat_list[index].title,
                                  maxLines: 1,
                                  style: TextStyle(

                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                chats.chat_list[index].userDetail[0].firstName != "" ?
                                Text(chats.chat_list[index].userDetail[0].firstName.toString(),
                                  // usersListApi.response[index].userName,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )

                                    :
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

                            Image.asset("assests/images/play.png",height: 45,),

                          ],),
                      ),

                    ):
                    Container();
                  }):
              Text('Start Chatting'),
            ],
          ),
        ),
      ),
    );
  }
}
