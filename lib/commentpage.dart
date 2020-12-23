import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rollinhead/Model/commentlisting/ListComments.dart';
import 'package:rollinhead/feedspage.dart';
import 'package:rollinhead/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Model/Commentpost/CommentsPostApi.dart';
import 'Model/GetProfiles/UserProfileApi.dart';

class CommentsPage extends StatefulWidget {
  String pid;
  CommentsPage({this.pid});
  @override
  _CommentsPageState createState() => _CommentsPageState(pid);
}

class _CommentsPageState extends State<CommentsPage> {
  String pid;
  _CommentsPageState(this.pid);
  TextEditingController _commentController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool   _isLoading = false;
  CommentsPostApi commentonpost;
  Timer timerApi;
  UserProfileApi profile;
  ListComments listcom;
  Future<List<dynamic>> fetchUsersList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');
    final response = await http.get(
      'http://rolinhead.dolphinfiresafety.com/registration/getUserProfile?userId=$userid & friendId=$userid',
    );
    profile= new UserProfileApi.fromJsonMap(json.decode(response.body.toString()));

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
  Future<List<dynamic>> fetchGetcomment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =prefs.getString('user_Id');
    int cusId = int.parse(userId);

    final response = await http.get(
        'http://rolinhead.dolphinfiresafety.com/registration/getCommentsOfPost/$pid'
    );
    listcom= new ListComments.fromJsonMap(json.decode(response.body.toString()));

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
  void dispose() {
    super.dispose();
    _commentController?.dispose();
  }
  Comments(String com) async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String userId =sharedPreferences.getString('user_Id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid =prefs.getString('user_Id');

    Map data = {
      'UserId': userid,
      'PostId' : pid,
      'Comment' : com
    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/commentPost", body: data);
    commentonpost = new CommentsPostApi.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (commentonpost.status.code==200) {
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
            msg: commentonpost.status.message,
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
            msg: commentonpost.status.message,
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
  void initState(){
    super.initState();
    _isLoading=true;
    fetchUsersList();
    fetchGetcomment();
    timerApi = Timer.periodic(Duration(seconds: 1), (Timer t) => fetchGetcomment());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.blue,
        title: Text('Comments'),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //
      //   items: [
      //   ],
      // ),
      body: _isLoading ? Center(child: CircularProgressIndicator()) :

            // commentsListWidget(),
     ListView(
              children: [
                listcom.comments.length>0 ?    ListView.builder(
                  // primary: true,
                  shrinkWrap: true,
                  itemCount:listcom.comments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(listcom.comments[index].userProfilePicture),
                                    radius: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(listcom.comments[index].userName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(listcom.comments[index].comment),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 20.0,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          );

                  }
                ): Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text('No Comments available',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  )),
                ),
                commentInputWidget(),
              ],
            )





    );
  }

  Widget commentInputWidget() {
    return Container(
      height: 55.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child:
      profile.response.personalityType != "Introvert" ?
      Row(

        children: <Widget>[
          // Container(
          //   width: 40.0,
          //   height: 40.0,
          //   margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          //   padding: const EdgeInsets.symmetric(vertical: 4.0),
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(40.0),
          //       image:
          //       DecorationImage(image: NetworkImage(widget.user.photoUrl))),
          // ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextFormField(
                validator: (String input) {
                  if (input.isEmpty) {
                    return "Please enter comment";
                  }
                  return null;
                },
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: "Add a comment...",
                ),
//                onFieldSubmitted: (value) {
//                  _commentController.text = value;
//                },
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: Text('Post', style: TextStyle(color: Colors.blue)),
            ),
            onTap: () {
//              if (_formKey.currentState.validate()) {
//                setState(() {
//                  _isLoading = true;
//                });
                  Comments(_commentController.text);
//              }
            },
          )
        ],
      ) :
          Container(),
    );
  }

  // postComment() {
  //   var _comment = Comment(
  //       comment: _commentController.text,
  //       timeStamp: FieldValue.serverTimestamp(),
  //       ownerName: widget.user.displayName,
  //       ownerPhotoUrl: widget.user.photoUrl,
  //       ownerUid: widget.user.uid);
  //   widget.documentReference
  //       .collection("comments")
  //       .document()
  //       .setData(_comment.toMap(_comment)).whenComplete(() {
  //     _commentController.text = "";
  //   });
  // }
  //
  // Widget commentsListWidget() {
  //   print("Document Ref : ${widget.documentReference.path}");
  //   return Flexible(
  //     child: StreamBuilder(
  //       stream: widget.documentReference
  //           .collection("comments")
  //           .orderBy('timestamp', descending: false)
  //           .snapshots(),
  //       builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //         if (!snapshot.hasData) {
  //           return Center(child: CircularProgressIndicator());
  //         } else {
  //           return ListView.builder(
  //             itemCount: snapshot.data.documents.length,
  //             itemBuilder: ((context, index) =>
  //                 commentItem(snapshot.data.documents[index])),
  //           );
  //         }
  //       }),
  //     ),
  //   );
  // }
  //
  // Widget commentItem(DocumentSnapshot snapshot) {
  //   //   var time;
  //   //   List<String> dateAndTime;
  //   //   print('${snapshot.data['timestamp'].toString()}');
  //   //   if (snapshot.data['timestamp'].toString() != null) {
  //   //       Timestamp timestamp =snapshot.data['timestamp'];
  //   //  // print('${timestamp.seconds}');
  //   //  // print('${timestamp.toDate()}');
  //   //    time =timestamp.toDate().toString();
  //   //    dateAndTime = time.split(" ");
  //   //   }
  //
  //
  //   return Padding(
  //     padding: const EdgeInsets.all(12.0),
  //     child: Row(
  //       children: <Widget>[
  //         Padding(
  //           padding: const EdgeInsets.only(left: 8.0),
  //           child: CircleAvatar(
  //             backgroundImage: NetworkImage(snapshot.data['ownerPhotoUrl']),
  //             radius: 20,
  //           ),
  //         ),
  //         SizedBox(
  //           width: 15.0,
  //         ),
  //         Row(
  //           children: <Widget>[
  //             Text(snapshot.data['ownerName'],
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                 )),
  //             Padding(
  //               padding: const EdgeInsets.only(left: 8.0),
  //               child: Text(snapshot.data['comment']),
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }
}
