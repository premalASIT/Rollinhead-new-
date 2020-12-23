import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rollinhead/Model/GroupInfoApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupInfo extends StatefulWidget {
  String uid;
  GroupInfo({this.uid});
  @override
  _GroupInfoState createState() => _GroupInfoState(uid);
}

class _GroupInfoState extends State<GroupInfo> {
  String uid;
  _GroupInfoState(this.uid);
  bool _isLoading=true;
  GroupInfoApi ginfo;
  Future<List<dynamic>> fetchGetinfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =prefs.getString('user_Id');
    int cusId = int.parse(userId);

    final response = await http.get(
        'http://rolinhead.dolphinfiresafety.com/registration/getGroupInformation/$uid'
    );
    ginfo= new GroupInfoApi.fromJsonMap(json.decode(response.body.toString()));

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

    fetchGetinfo();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(ginfo.groupInformation.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Total Member',
                style: TextStyle(
                  fontSize: 20,
                ),
                ),
              ),

              ListView.builder(
               itemCount: ginfo.users.length,
              // itemCount: chats.chat_list.length,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                 return Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [
                      ginfo.groupInformation.group_icon != "" ?
                       ClipOval(
                         child: Image.network( ginfo.groupInformation.group_icon,
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

                       Text(
                         ginfo.users[index].firstName != null ? ginfo.users[index].firstName : "Unknown" ,

                         style: TextStyle(color: Colors.black,fontSize: 22),
                         textAlign: TextAlign.center,
                       ),
                     ],
                   ),
                 );
              }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
