import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rollinhead/chewie_list_item.dart';
import 'package:rollinhead/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class DeleteCreatedPostPage extends StatefulWidget {
  final String userPostId;
  final String imagePath;
  final String videoPath;
  DeleteCreatedPostPage({this.userPostId,this.imagePath,this.videoPath});

  @override
  _DeleteCreatedPostPageState createState() => _DeleteCreatedPostPageState(userPostId,imagePath,videoPath);
}

class _DeleteCreatedPostPageState extends State<DeleteCreatedPostPage> {
  bool  _isLoading = false;
   String userPostId;
   String imagePath;
   String videoPath;
   _DeleteCreatedPostPageState(this.userPostId,this.imagePath,this.videoPath);

   deletePost() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String userId =prefs.getString('user_Id');

     var response = await http.get(
         "http://rolinhead.dolphinfiresafety.com/registration/DeleteUserPost/$userPostId");
     if (response.statusCode == 200) {
       setState(() {
         _isLoading = false;
       });
       Fluttertoast.showToast(
           msg: "Post Delete successfully",
           toastLength: Toast.LENGTH_LONG,
           gravity: ToastGravity.BOTTOM,
           timeInSecForIosWeb: 2
       );
       print(response.body);
       Navigator.pop(context);
       // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Homepage()),
       //         (Route<dynamic> route) => false);
       // Fluttertoast.showToast(
       //     msg: "Tree node created successfully.",
       //     toastLength: Toast.LENGTH_LONG,
       //     gravity: ToastGravity.BOTTOM,
       //     timeInSecForIosWeb: 2);
       // Navigator.of(context).pop();
       // Navigator.of(context).push(MaterialPageRoute(
       //     builder: (BuildContext context) => TreeCreatePost(nodeName:nodeName,selectedNode: selectedNode,userTreeId: userTreeId,)));
     } else {
       print("ELSE @");
       setState(() {
         _isLoading = false;
       });
       Fluttertoast.showToast(
           msg: "Error",
           toastLength: Toast.LENGTH_LONG,
           gravity: ToastGravity.BOTTOM,
           timeInSecForIosWeb: 2);
       print(response.body);
     }
   }


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Delete Post',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),),
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            child: Icon(Icons.arrow_back, color:Colors.black, size: 24),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.delete,color: Colors.black,),
            tooltip: 'Delete',
            onPressed:(){
              setState(() {
                _isLoading=true;
              });
              deletePost();
            },
          ),

        ],
      ),
      body:  _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
        children: [
          imagePath != ""
              ? Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Image.network(
              imagePath,
              height: 380,
              width: 380,
            ),
          )
              : videoPath != ""
              ? Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: ChewieListItem(
              videoPlayerController:
              VideoPlayerController.network(
                videoPath,
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
        ],
      )
    );
  }
}
