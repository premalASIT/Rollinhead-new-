import 'package:flutter/material.dart';
import 'package:rollinhead/DisplayTreeUserstory.dart';
import 'package:rollinhead/PollConceptP/CreatePollPost.dart';
import 'package:rollinhead/PollConceptP/DisplayPollUserStory.dart';
import 'package:rollinhead/TreeConceptR/SelectNodeOption.dart';
import 'package:rollinhead/UploadingStory.dart';
import 'package:rollinhead/homepage.dart';
import 'package:rollinhead/listchats.dart';
import 'package:rollinhead/stories.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_view/story_view.dart';
import 'package:rollinhead/Model/storyuploaderlist/StoryuploadersApi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class displaystory extends StatefulWidget {
  @override
  _displaystoryState createState() => _displaystoryState();
}

class _displaystoryState extends State<displaystory> {
  final storyController = StoryController();
  bool _isLoading=true;
  StoryuploadersApi story;
  Future<List<dynamic>> fetchGetStory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =prefs.getString('user_Id');
    int cusId = int.parse(userId);

    final response = await http.get(
        'http://rolinhead.dolphinfiresafety.com/registration/getStoryList/$userId'
    );
    story= new StoryuploadersApi.fromJsonMap(json.decode(response.body.toString()));

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
  void initState() {
    _isLoading=true;
    fetchGetStory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Story',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            child: Icon(Icons.arrow_back, color:Colors.black, size: 24),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // leading: BackButton(
        //   onPressed: (){
        //     Navigator.of(context).push(MaterialPageRoute(
        //         builder: (BuildContext context) => Homepage()));
        //   },
        // ),
        actions: <Widget>[
          IconButton(
            icon: new Image.asset('assests/images/p.png',
              height: 50,
              width: 50,
            ),
            tooltip: 'Poll',
            onPressed: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => DisplayPollUserStory())),
            },
          ),
          IconButton(
            icon: new Image.asset('assests/images/t_tree.png',
              height: 400,
              width: 400,
            ),
            tooltip: 'Tree',
            onPressed: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => DisplayTreeUserStory())),
            },
          ),
//           IconButton(
//             icon: new Image.asset(
//               'assests/images/t_tree.png',
//               height: 400,
//               width: 400,
//             ),
//             tooltip: 'Diary',
//             onPressed: () => {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) => SelectNodeOption())),
//               // Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (BuildContext context) => TreeConcept())),
//               // Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (BuildContext context) => ChatsLists())),
// //                    builder: (BuildContext context) => ImageEditorPro())),
//               // builder: (BuildContext context) => ChatsLists())),
//             },
//           ),
          IconButton(
            icon: new Image.asset(
              'assests/images/m.png',
              height: 400,
              width: 400,
            ),
            tooltip: 'Diary',
            onPressed: () => {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => TreeConcept())),
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ChatsLists())),
//                    builder: (BuildContext context) => ImageEditorPro())),
              // builder: (BuildContext context) => ChatsLists())),
            },
          ),
          IconButton(
            icon:Icon(Icons.add,color: Colors.black,),
            tooltip: 'Diary',
            onPressed: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ImageEditorPro())),
//                    builder: (BuildContext context) => ImageEditorPro())),
              // builder: (BuildContext context) => ChatsLists())),
            },
          ),

        ],
      ),
      body:_isLoading
          ? Center(child: CircularProgressIndicator())
          :story.response.length > 0 ? GridView.builder(
        padding: EdgeInsets.only(top: 15,
        left: 5,right: 5,bottom: 5),
        itemCount: story.response.length,
        shrinkWrap: true,
        primary: false,
        physics: ScrollPhysics(),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 5.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return  InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MoreStories(id: story.response[index].userId)));
            },
            child: Container(
              height: 150,
              width: 130,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            width: 150,
                            height: 150,
                            // decoration: BoxDecoration(
                            //     color: isSelected?
                            //     Colors.black26 :
                            //     Colors.transparent,
                            //     borderRadius: BorderRadius.circular(16),
                            //     border: Border.all(
                            //       color: Colors.white,
                            //       width: 1,
                            //     ),
                            //     boxShadow: isSelected
                            //         ?[
                            //       BoxShadow(
                            //           color: Color(0x14000000),
                            //           blurRadius: 10
                            //       )
                            //     ]: null
                            // ),
                            child: new Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: new BoxDecoration(
                                color: const Color(0xff7c94b6),
                                image: new DecorationImage(
                                  image: new NetworkImage(story.response[index].userProfilePicture),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: new BorderRadius.all(new Radius.circular(80.0)),
                                border: new Border.all(
                                  color: Colors.red,
                                  width: 5.0,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 5,),
                          Text(
                            story.response[index].firstName != null ?
                            story.response[index].firstName :
                            "Name"
                            ,
                            style:
                            TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ],
                      ),

                    ],
                  )

            ),
          );
      }
      ):
      Center(
        child:Text("No Story Available",
          style:
          TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
        ),
      )
    );
  }
}
