import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rollinhead/Model/DisplayTreeNodesStorys/TreeNodeDisplayImageApi.dart';
import 'package:rollinhead/treeconcept.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class DisplayTreeNodeStory extends StatefulWidget {
  final String id;
  final String nodeNumber;
  DisplayTreeNodeStory({this.id,this.nodeNumber});
  @override
  _DisplayTreeNodeStoryState createState() => _DisplayTreeNodeStoryState(id,nodeNumber);
}

class _DisplayTreeNodeStoryState extends State<DisplayTreeNodeStory> {
  String id;
  String nodeNumber;
  _DisplayTreeNodeStoryState(this.id,this.nodeNumber);
  final storyController = StoryController();
  bool _isLoading=false;
  int x,y=0;
  TreeNodeDisplayImageApi Storyapi;
  List<StoryItem> stories = new List();

  void initState() {
    _isLoading=true;
    fetchGetStory();
    super.initState();
  }

  Future<List<dynamic>> fetchGetStory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String userId =prefs.getString('user_Id');
    // int cusId = int.parse(userId);

    final response = await http.get(
        'http://rolinhead.dolphinfiresafety.com/registration/showUserTreeNodeImage/$id/$nodeNumber'
        //'http://rolinhead.dolphinfiresafety.com/registration/showUserTreeNodeImage/1/3'
    );
    Storyapi= new TreeNodeDisplayImageApi.fromJsonMap(json.decode(response.body.toString()));

    if(response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      // if(Storyapi.treeNodeCount.length<0){
      //   Fluttertoast.showToast(
      //       msg: "No Story There",
      //       toastLength: Toast.LENGTH_LONG,
      //       gravity: ToastGravity.BOTTOM,
      //       timeInSecForIosWeb: 2
      //   );
      //   Navigator.of(context).pop();
      // }else{
      //
      // }
      x = Storyapi.treeNodeCount.length;
      print(x);
      for (int i = 0; i < x; i++) {
        setState(() {
          if(Storyapi.treeNodeCount[i].Image!="") {
            stories.add(
              StoryItem.pageImage(
                url:
                Storyapi.treeNodeCount[i].Image,
                controller: storyController,
              ),
            );
          }
          // else if(Storyapi.treeNodeCount[i].videoPath!=""){
          //   stories.add(
          //       StoryItem.pageVideo( Storyapi.treeNodeCount[i].videoPath, controller: storyController)
          //   );
          // }
        });
      }
    //  print(stories[0]);
      print(response.body);

      // if(Storyapi.treeNodeCount.length<0){
      //   Fluttertoast.showToast(
      //       msg: "No Story There",
      //       toastLength: Toast.LENGTH_LONG,
      //       gravity: ToastGravity.BOTTOM,
      //       timeInSecForIosWeb: 2
      //   );
      //   Navigator.of(context).pop();
      // }
    }else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }

  }
  // void initState() {
  //   _isLoading=true;
  //   fetchGetStory();
  //   super.initState();
  // }
  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("More"),
      // ),
      body:_isLoading
          ? Center(child: CircularProgressIndicator())
          :stories.length>0? StoryView(
        storyItems: stories,
        //       storyItems: [
        //
        //         Storyapi.userStories[index].imagePath != ""  ?
        //   StoryItem.pageImage(
        //       url: Storyapi.userStories[index].imagePath,
        //       // caption: "Still sampling",
        //     imageFit: BoxFit.fitWidth,
        //       controller: storyController,
        //   ):
        //   StoryItem.pageImage(
        //       url: Storyapi.userStories[index].videoPath,
        //       // caption: "Working with gifs",
        //       controller: storyController),
        //         StoryItem.pageImage(
        //           url: Storyapi.userStories[1].imagePath,
        //           // caption: "Still sampling",
        //           imageFit: BoxFit.fitWidth,
        //           controller: storyController,
        //         )
        //   // StoryItem.inlineImage(
        //   //   imageFit: BoxFit.fitHeight,
        //   //     url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
        //   //     // caption: "Hello, from the other side",
        //   //     controller: storyController,
        //   // ),
        //   // StoryItem.pageImage(
        //   //   url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
        //   //   caption: "Hello, from the other side2",
        //   //   controller: storyController,
        //   // ),
        // ],
        onStoryShow: (s) {
          print("Showing a story");
        },
        onVerticalSwipeComplete: (down){
          print("d");
          Navigator.of(context).pop();
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (BuildContext context) => TreeConcept()));
        },
        onComplete: () {
          print("Completed a cycle");
          Navigator.of(context).pop();
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (BuildContext context) => displaystory()));

        },
        progressPosition: ProgressPosition.top,

        repeat: false,
        controller: storyController,
      ):
          Center(
            child:Text("No Story Found",
              style:
              TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
            ),
          )


    );
  }
  Widget _show(BuildContext context) {

  }
}
