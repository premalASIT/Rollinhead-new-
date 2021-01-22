import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rollinhead/ChatScreen.dart';
import 'package:rollinhead/Displaystory.dart';
import 'package:rollinhead/Model/FeedHome/UserFeedApi.dart';
import 'package:rollinhead/Model/GetProfiles/UserProfileApi.dart';
import 'package:rollinhead/Model/dislikepost/DisLikesPost.dart';
import 'package:rollinhead/Model/likepost/LikepostsApi.dart';
import 'package:rollinhead/Model/postasstory/StoryAsPostApi.dart';
import 'package:rollinhead/Postcreaate.dart';
import 'package:rollinhead/UploadingStory.dart';
import 'package:rollinhead/UserProfile.dart';
import 'package:rollinhead/chewie_list_item.dart';
import 'package:rollinhead/commentpage.dart';
import 'package:rollinhead/diarypageD1.dart';
import 'package:rollinhead/listchats.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

import 'Model/swipedetector.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  bool _isLoading = false;
  UserFeedApi viewprofile;
  LikepostsApi liked;
  DisLikesPost dislikesapi;
  StoryAsPostApi story;
  UserProfileApi profile;
  Likes(String pid) async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String userId =sharedPreferences.getString('user_Id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString('user_Id');

    Map data = {
      'UserId': userid,
      'PostId': pid,
    };
    var response = await http.post(
        "http://rolinhead.dolphinfiresafety.com/registration/likePost",
        body: data);
    liked = new LikepostsApi.fromJsonMap(json.decode(response.body.toString()));
    if (response.statusCode == 200) {
      if (liked.status.code == 200) {
        setState(() {
          _isLoading = false;
        });
        //   sharedPreferences.setInt("user_Id",verifyotp.response.userId);
        print(response.body);
        print("done2");
        print("done");
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (BuildContext context) => Homepage()));
        Fluttertoast.showToast(
            msg: liked.status.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2);
      } else {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: liked.status.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2);
        print(response.body);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  DisLikes(String pid) async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String userId =sharedPreferences.getString('user_Id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString('user_Id');

    Map data = {
      'UserId': userid,
      'PostId': pid,
    };
    var response = await http.post(
        "http://rolinhead.dolphinfiresafety.com/registration/dislikePost",
        body: data);
    dislikesapi =
    new DisLikesPost.fromJsonMap(json.decode(response.body.toString()));
    if (response.statusCode == 200) {
      if (dislikesapi.status.code == 200) {
        setState(() {
          _isLoading = false;
        });
        //   sharedPreferences.setInt("user_Id",verifyotp.response.userId);
        print(response.body);
        print("done2");
        print("done");
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (BuildContext context) => Homepage()));
        Fluttertoast.showToast(
            msg: dislikesapi.status.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2);
      } else {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: dislikesapi.status.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2);
        print(response.body);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  Future<List<dynamic>> fetchGetpost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_Id');
    int cusId = int.parse(userId);
    Map data = {
      'userId': userId,
      // 'userId': userId,
      'start': "0",
      'limit': '100'
    };
    final response = await http.post(
        'http://rolinhead.dolphinfiresafety.com/registration/userHomePosts',
        body: data);
    viewprofile =
    new UserFeedApi.fromJsonMap(json.decode(response.body.toString()));

    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      //fetchUsersList();
      print(response.body);
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  Pshare(String id) async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String userId =sharedPreferences.getString('user_Id');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString('user_Id');

    Map data = {
      'UserId': userid,
      'PostId': id,
    };
    var response = await http.post(
        "http://rolinhead.dolphinfiresafety.com/registration/sharePostAsStory",
        body: data);
    story =
    new StoryAsPostApi.fromJsonMap(json.decode(response.body.toString()));
    if (response.statusCode == 200) {
      if (story.status.code == 200) {
        setState(() {
          _isLoading = false;
        });
        //   sharedPreferences.setInt("user_Id",verifyotp.response.userId);
        print(response.body);
        print("done2");
        print("done");
        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: story.status.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2);
      } else {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: story.status.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2);
        print(response.body);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  Future<List<dynamic>> fetchUsersList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString('user_Id');
    final response = await http.get(
      'http://rolinhead.dolphinfiresafety.com/registration/getUserProfile?userId=$userid & friendId=$userid',
    );
    profile =
    new UserProfileApi.fromJsonMap(json.decode(response.body.toString()));

    if (response.statusCode == 200) {
      if (response != null) {
        setState(() {
          _isLoading = false;
        });

        print(response.body);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  Widget post(String pid) {
    return Container(
        height: 130.0, // Change as per your requirement
        width: 150.0, // Change as per your requirement
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text("Are you sure you want to share as story ?"),
            SizedBox(
              height: 26,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  height: 50,
                  color: Colors.red,
                  child: Text("Post",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      )),
                  elevation: 10.0,
                  minWidth: MediaQuery.of(context).size.width / 4,
                  onPressed: () {
                    Pshare(pid);
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                ),
                MaterialButton(
                  height: 50,
                  color: Colors.red,
                  child: Text("Cancel",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      )),
                  elevation: 10.0,
                  minWidth: MediaQuery.of(context).size.width / 4,
                  onPressed: () {
                    // CreateG(detail.text);
                    Navigator.of(context).pop();
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
  Widget gettag(int inx) {
    return Container(
        height: 170.0, // Change as per your requirement
        width: 160.0, // Change as per your requirement
        child:
        ListView.builder(
            itemCount: viewprofile.response[inx].mentionUserIds.length,
            itemBuilder: (context, index) {
              return ListTile(
                title:
                viewprofile.response[inx].mentionUserIds[index].userName != null ?
                Text(viewprofile.response[inx].mentionUserIds[index].userName):
                Text(viewprofile.response[inx].mentionUserIds[index].firstName),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Userprofile(uid :viewprofile.response[index].userId.toString())));
                },
              );
            }
        )

    );
  }
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    fetchGetpost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: new Image.asset('assests/images/d.png',
                height: 400,
                width: 400,
              ),
              tooltip: 'Diary',
              onPressed: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Diarypaged1())),
              },
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Image.asset(
                  "assests/images/rhead.png",
                  height: 180,
                  width: 180,
                ),
              ),
            ),
            IconButton(
              icon: new Image.asset(
                'assests/images/S.png',
                height: 350,
                width: 350,
              ),
              tooltip: 'Diary',
              onPressed: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => displaystory())),
//                    builder: (BuildContext context) => ImageEditorPro())),
                // builder: (BuildContext context) => ChatsLists())),
              },
            ),
          ],
        ),
        //   leading:  new IconButton(
        //     icon: new Image.asset('assests/images/d.png'),
        //     tooltip: 'Diary',
        //     onPressed: () => {
        //     Navigator.of(context).push(MaterialPageRoute(
        //     builder: (BuildContext context) => Diarypaged1())),
        //   },
        // ),
        //   actions: [
        //
        //     // GestureDetector(
        //     //     onTap:() {
        //     //           Navigator.of(context).push(MaterialPageRoute(
        //     //               builder: (BuildContext context) => ChatsLists()));
        //     //     },
        //     //     child: Image.asset('assests/images/S.png')),
        //     IconButton(
        //       icon: new Image.asset('assests/images/S.png',),
        //       tooltip: 'Diary',
        //       onPressed: () => {
        //         Navigator.of(context).push(MaterialPageRoute(
        //             builder: (BuildContext context) => ImageEditorPro())),
        //             // builder: (BuildContext context) => ChatsLists())),
        //       },
        //     ),
        //   ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : viewprofile.response.length > 0
          ? SwipeDetector(

        child: ListView.builder(
          itemCount: viewprofile.response.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 14),
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Userprofile(uid :viewprofile.response[index].userId.toString())));
                    },
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(160),
                          child: viewprofile.response[index]
                              .userProfilePicture !=
                              null
                              ? Image.network(
                            viewprofile
                                .response[index].userProfilePicture,
                            height: 45,
                            width: 45,
                          )
                              : Image.asset(
                            "assests/images/1.jpg",
                            height: 45,
                            width: 45,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            viewprofile.response[index].userName != null
                                ? Text(
                              viewprofile.response[index].userName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                                : Text(
                              "UserName",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            viewprofile.response[index].location != ""
                                ? Text(
                              viewprofile.response[index].location,

                              style: TextStyle(
                                fontSize: 14.5,
                                color: Colors.black54,
                              ),
                            )
                                : Text(
                              "Location",
                              style: TextStyle(
                                fontSize: 14.5,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width:117),
                        FlatButton.icon(onPressed: null, icon: Icon(Icons.info,color: Colors.red, size: 35,  ),
                            label:  Text("",style: TextStyle(fontSize: 0),)),
                      ],
                    ),
                  ),
                ),
                viewprofile.response[index].imagePath != ""
                    ? Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Image.network(
                    viewprofile.response[index].imagePath,
                    height: 380,
                    width: 380,
                  ),
                )
                    : viewprofile.response[index].videoPath != ""
                    ? Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ChewieListItem(
                    videoPlayerController:
                    VideoPlayerController.network(
                      viewprofile.response[index].videoPath,
                      // 'https://rolinhead.dolphinfiresafety.com/assets/userPostFiles/1028202084714post136.mp4',
                    ),
                    looping: false,
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Image.asset(
                    "assests/images/1.jpg",
                    height: 380,
                    width: 380,
                  ),
                ),
                viewprofile.response[index].personalityType == "Extrovert" ?
                Column(
                  children: <Widget>[
//                            Text(viewprofile.response[index].content,
//                            style: TextStyle(
//                              fontSize: 19,
//                            ),),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          splashColor: Colors.orange,
                          onTap: () {
                            setState(() {
                              if (viewprofile.response[index].isLikedByMe ==
                                  false) {
                                Likes(
                                    viewprofile.response[index].userPostId);
                              } else if (viewprofile
                                  .response[index].isLikedByMe ==
                                  true) {
                                DisLikes(
                                    viewprofile.response[index].userPostId);
                              }
                            });
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, top: 8.0),
                                child: Image.asset(
                                  "assests/images/star.png",
                                  height: 50,
                                  width: 50,
                                ),
                              ),

                              Text(
                                  viewprofile.response[index].likes
                                      .toString()),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CommentsPage(
                                        pid: viewprofile
                                            .response[index].userPostId)));
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, top: 8.0),
                                child: Image.asset(
                                  "assests/images/circle.png",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              Text(viewprofile.response[index].comments
                                  .toString()),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Post as Story'),
                                    content: post(viewprofile
                                        .response[index].userPostId),
                                  );
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, top: 8.0),
                            child: Image.asset("assests/images/play.png",
                                height: 50, width: 50),
                          ),
                        ),
                      ],
                    ),
                  ],
                ):
                Column(
                  children: <Widget>[


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          splashColor: Colors.orange,
                          onTap: () {
                            setState(() {
                              if (viewprofile.response[index].isLikedByMe ==
                                  false) {
                                Likes(
                                    viewprofile.response[index].userPostId);
                              } else if (viewprofile
                                  .response[index].isLikedByMe ==
                                  true) {
                                DisLikes(
                                    viewprofile.response[index].userPostId);
                              }
                            });
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, top: 8.0),
                                child: Image.asset(
                                  "assests/images/star.png",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              // Text(viewprofile.response[index].likes
                              //     .toString()),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
                // FlatButton.icon(onPressed: null, icon: Icon(Icons.star,color: Colors.amber,),
                //     label: Text("",style: TextStyle(fontSize: 0),)),
                Column(
                  children: <Widget>[
                    Text(viewprofile.response[index].content,
                      style: TextStyle(
                        fontSize: 19,
                      ),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        viewprofile.response[index].personalityType == "Extrovert"  ? InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => CommentsPage(
                                    pid: viewprofile.response[index].userPostId)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'View all Comments',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ): Container(),
                        viewprofile.response[index].mentionUserIds.length > 0 ?
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Mentions'),
                                    content: gettag(index),
                                  );
                                }
                            );
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (BuildContext context) =>
                            //         Userprofile(uid :viewprofile.response[index].userId.toString())));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Mentions',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ): Container(),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        viewprofile.response[index].postTime,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
//                              Padding(
//                                padding: const EdgeInsets.only(
//                                  top: 0.0,
//                                ),
//                                child: FlatButton(
//                                  child: Text(
//                                    "Continue",
//                                    style: TextStyle(
//                                      fontSize: 15.0,
//                                      color: Colors.deepOrange,
//                                    ),
//                                  ),
//                                  onPressed: () {
//                                    // Sendotp(user.text);
//                                    Navigator.of(context).push(
//                                        MaterialPageRoute(
//                                            builder: (BuildContext context) =>
//                                                displaystory()));
//                                  },
//                                ),
//                              ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(11.0),
                //   child: RaisedButton(
                //     color: Colors.red,
                //     onPressed:  () {
                //
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (BuildContext context) => CreatePosts()));
                //     },
                //
                //     child: Text("POST",
                //       style: TextStyle(
                //         fontSize: 20,
                //         color: Colors.white,
                //       ),),
                //     shape: new RoundedRectangleBorder(
                //       borderRadius: new BorderRadius.circular(15.0),
                //     ),
                //   ),
                // ),
              ],
            );
          },
        ),
        onSwipeLeft: () {
          print("Swipe Left");
        },
        onSwipeRight: () {
          print("Swipe Right");
        },
      )
          : Center(
        child: Text('No Post Available'),
      ),
    );
  }
}