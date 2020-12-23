import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:rollinhead/Chats/Message.dart';
import 'package:rollinhead/groupinfoset.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Model/Getchatlist/ChatMessagesList.dart';
import 'Model/groupmesaagelist/GroupMEssageListApi.dart';
import 'Model/SendMessageUser/sendMessages.dart';

class MyGroupScreen extends StatefulWidget {
  String uid;
  MyGroupScreen({Key key, this.title, this.uid}) : super(key: key);
  final String title;

  @override
  _MyChatState createState() => new _MyChatState(uid);
}

class _MyChatState extends State<MyGroupScreen> {
  String uid;
  _MyChatState(this.uid);
  final List<Message> _messages = <Message>[];
  GroupMEssageListApi chatmsg;
  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  final _textController = TextEditingController();
  bool  _isLoading=false;
  Timer timerApi;
  SendMessages sendmsg;
  SendMess(String a) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =prefs.getString('user_Id');
    int cusId = int.parse(userId);
    Map data = {
      'UserId': userId,
      'ChatId': chatmsg.chat_detail[0].ID,
      'Message' : a,
    };
    final response = await http.post(
        'http://rolinhead.dolphinfiresafety.com/registration/SendMessage',body:data
    );
    sendmsg= new SendMessages.fromJsonMap(json.decode(response.body.toString()));

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
  Future<List<dynamic>> fetchGetchat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =prefs.getString('user_Id');
    int cusId = int.parse(userId);
    print(uid);
    Map data = {
      'UserId': userId,
      'ChatId': uid,

    };
    final response = await http.post(
        'http://rolinhead.dolphinfiresafety.com/registration/GetGroupMessages',body:data
    );
    chatmsg= new GroupMEssageListApi.fromJsonMap(json.decode(response.body.toString()));

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
    super.initState();
    _isLoading=true;

    fetchGetchat();
    timerApi = Timer.periodic(Duration(seconds: 1), (Timer t) => fetchGetchat());
  }
  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(time);

    return new Scaffold(
        appBar:  chatmsg.chat_detail.length > 0 ?  AppBar(
          backgroundColor: Colors.red,
          title:    Row(
            children: [
              chatmsg.chat_detail[0].group_icon == "" ?
              ClipOval(
                child: Image.network(chatmsg.chat_detail[0].group_icon,
                  height: 40,
                  width: 40,
                  //    placeholder: AssetImage('assets/images/placeholder.png'),
                  fit: BoxFit.fill,
                ),
              ):
              ClipOval(
                child: Image.asset("assests/images/avtar.png",
                  height: 40,
                  width: 40,
                  //    placeholder: AssetImage('assets/images/placeholder.png'),
                  fit: BoxFit.fill,
                ),
              ),   
              SizedBox(width: 15,),
              Text(
                chatmsg.chat_detail[0].title,
                style: TextStyle(color: Colors.white,fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ],
          ),

          actions: [
            IconButton(
              icon: new Image.asset('assests/images/d.png',),
              tooltip: 'Diary',
              onPressed: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => GroupInfo(uid : chatmsg.chat_detail[0].ID))),
                // builder: (BuildContext context) => ChatsLists())),
              },
            ),
          ],
        ):
            AppBar(
              title: Text('Group'),
            ),
        body:_isLoading ? Center(child: CircularProgressIndicator()) :  new Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: new Container(
              child: new Column(
                children: <Widget>[
                  //Chat list
                  new Flexible(
                    child: chatmsg.chat_messages.length > 0 ? new ListView.builder(
                        padding: new EdgeInsets.all(8.0),
                        reverse: true,
                        itemCount: chatmsg.chat_messages.length,
                        itemBuilder: (_, int index)
                        {
                          return new Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            child: chatmsg.chat_messages[index].isSendByMe == false
                                ? new Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    new Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Stack(
                                          children: <Widget>[
                                            //for left corner

                                            new Image.asset(
                                              'assets/images/in.png',
                                              fit: BoxFit.scaleDown,
                                              width: 30.0,
                                              height: 30.0,
                                            ),

                                            new Container(
                                              margin: EdgeInsets.only(left: 6.0),
                                              decoration: new BoxDecoration(
                                                color: Color(0xffd6d6d6),
                                                border: new Border.all(
                                                    color: Color(0xffd6d6d6),
                                                    width: .25,
                                                    style: BorderStyle.solid),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(5.0),
                                                  topLeft: Radius.circular(5.0),
                                                  bottomRight: Radius.circular (0.0),
                                                  bottomLeft: Radius.circular(0.0),
                                                ),
                                              ),
                                              alignment: Alignment.bottomLeft,
                                              padding: const EdgeInsets.all(8.0),
                                              child: new Text(
                                                chatmsg.chat_messages[index].message,
                                                style: new TextStyle(
                                                  fontFamily: 'Gamja Flower',
                                                  fontSize: 20.0,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                              width: 180.0,
                                            ),
                                          ],
                                        ),

                                        //date time
                                        new Container(
                                          margin: EdgeInsets.only(left: 6.0),
                                          decoration: new BoxDecoration(
                                            color: Color(0xffd6d6d6),
                                            border: new Border.all(
                                                color: Color(0xffd6d6d6),
                                                width: .25,
                                                style: BorderStyle.solid),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(0.0),
                                              topLeft: Radius.circular(0.0),
                                              bottomRight: Radius.circular(5.0),
                                              bottomLeft: Radius.circular(5.0),
                                            ),
                                          ),
                                          alignment: Alignment.bottomLeft,
                                          padding: const EdgeInsets.only(
                                              top: 0.0, bottom: 8.0, left: 8.0, right: 8.0),
                                          child: new Text(
                                            chatmsg.chat_messages[index].timestamp,
                                            style: new TextStyle(
                                              fontSize: 8.0,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                          width: 180.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                            )
                                : chatmsg.chat_messages[index].isSendByMe == true ?Container(
                              child: new
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  new Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      new Stack(
                                        alignment: Alignment.topRight,
                                        children: <Widget>[
                                          //for right corner
                                          new Image.asset(
                                            'assets/images/out.png',
                                            fit: BoxFit.scaleDown,
                                            width: 30.0,
                                            height: 30.0,
                                          ),

                                          new Container(
                                            margin: EdgeInsets.only(right: 6.0),
                                            decoration: new BoxDecoration(
                                              color: Color(0xffef5350),
                                              border: new Border.all(
                                                  color: Color(0xffef5350),
                                                  width: .25,
                                                  style: BorderStyle.solid),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5.0),
                                                topLeft: Radius.circular(5.0),
                                                bottomRight: Radius.circular(0.0),
                                                bottomLeft: Radius.circular(0.0),
                                              ),
                                            ),
                                            alignment: Alignment.bottomRight,
                                            padding: const EdgeInsets.all(8.0),
                                            child: new Text(
                                              chatmsg.chat_messages[index].message,
                                              style: new TextStyle(
                                                fontFamily: 'Gamja Flower',
                                                fontSize: 20.0,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                            width: 180.0,
                                          ),
                                        ],
                                      ),

                                      //date time
                                      new Container(
                                        margin: EdgeInsets.only(right: 6.0),
                                        decoration: new BoxDecoration(
                                          color: Color(0xffef5350),
                                          border: new Border.all(
                                              color: Color(0xffef5350),
                                              width: .25,
                                              style: BorderStyle.solid),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(0.0),
                                            topLeft: Radius.circular(0.0),
                                            bottomRight: Radius.circular(5.0),
                                            bottomLeft: Radius.circular(5.0),
                                          ),
                                        ),
                                        alignment: Alignment.bottomRight,
                                        padding: const EdgeInsets.only(
                                            top: 0.0, bottom: 8.0, left: 8.0, right: 8.0),
                                        child: new Text(
                                          chatmsg.chat_messages[index].timestamp,
                                          style: new TextStyle(
                                            fontSize: 8.0,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                        width: 180.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ):Container(),
                          );
                        }
                    ):
                    Text('Start Chatting'),
                  ),
                  new Divider(height: 1.0),
                  new Container(
                      decoration:
                      new BoxDecoration(color: Theme.of(context).cardColor),
                      child: new IconTheme(
                          data: new IconThemeData(
                              color: Theme.of(context).accentColor),
                          child: new Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: new Row(
                              children: <Widget>[
                                //left send button

                                // new Container(
                                //   width: 48.0,
                                //   height: 48.0,
                                //   child: new IconButton(
                                //       icon: Image.asset(
                                //           "assests/images/send_in.png"),
                                //       onPressed: () => _sendMsg(
                                //           _textController.text,
                                //           'left',
                                //           formattedDate)),
                                // ),
                                SizedBox(width: 30,),
                                //Enter Text message here
                                new Flexible(
                                  child: new TextField(
                                    controller: _textController,
                                    decoration: new InputDecoration.collapsed(
                                        hintText: "Enter message"),
                                  ),
                                ),

                                //right send button

                                new Container(
                                  margin:
                                  new EdgeInsets.symmetric(horizontal: 2.0),
                                  width: 48.0,
                                  height: 48.0,
                                  child: new IconButton(
                                      icon: Image.asset(
                                          "assests/images/send_out.png"),
                                      onPressed: () {
                                        if (_textController.text.length == 0) {
                                          Fluttertoast.showToast(
                                              msg: "Please Enter Message",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.blue);
                                        }
                                        else{
                                          SendMess(_textController.text);
                                          _textController.clear();
                                        }
                                        // fetchGetchat();
                                        // _sendMsg(
                                        //     _textController.text,
                                        //     'right',
                                        //     formattedDate);
                                      }
                                  ),
                                ),
                              ],
                            ),
                          ))),
                ],
              ),
            )));
  }

  void _sendMsg(String msg, String messageDirection, String date) {
    if (msg.length == 0) {
      Fluttertoast.showToast(
          msg: "Please Enter Message",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue);
    } else {
      _textController.clear();
      Message message = new Message(
        msg: msg,
        direction: messageDirection,
        dateTime: date,
      );
      SendMess(msg);
      setState(() {
        _messages.insert(0, message);
      });
    }
  }


  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    // Clean up the controller when the Widget is disposed
    _textController.dispose();
    super.dispose();
  }
}