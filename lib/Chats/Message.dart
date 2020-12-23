import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rollinhead/Model/Getchatlist/ChatMessagesList.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Message extends StatefulWidget {
  Message({this.msg, this.direction, this.dateTime});

  final String msg;
  final String direction;
  final String dateTime;

  @override
  _MessageState createState() => _MessageState(msg,direction,dateTime);
}

class _MessageState extends State<Message> {
  _MessageState(msg,direction,dateTime);
  bool _isLoading=false;
  ChatMessagesList chatmsg;
  Future<List<dynamic>> fetchGetchat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =prefs.getString('user_Id');
    int cusId = int.parse(userId);
    // print(uid);
    Map data = {
      'UserId': userId,
      'ChatUserId': '12',

    };
    final response = await http.post(
        'http://rolinhead.dolphinfiresafety.com/registration/StartChatWithUser',body:data
    );
    chatmsg= new ChatMessagesList.fromJsonMap(json.decode(response.body.toString()));

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

    _isLoading=false;

    fetchGetchat();

  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: chatmsg.chat_messages[0].isSendByMe == true
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
                            bottomRight: Radius.circular(0.0),
                            bottomLeft: Radius.circular(0.0),
                          ),
                        ),
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                         widget.msg,
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
                      widget.dateTime,
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
          ))
          : new Row(
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
                      widget.msg,
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
                  widget.dateTime,
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
    );
  }
}