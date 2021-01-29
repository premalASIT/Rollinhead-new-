import 'package:flutter/material.dart';
import 'package:rollinhead/Model/DisplayPollUserStroy/DisplayUserPollStoryApi.dart';
import 'package:rollinhead/Model/DisplayTreeUserList/TreeUserListApi.dart';
import 'package:rollinhead/PollConceptP/CreatePollPost.dart';
import 'package:rollinhead/PollConceptP/DisplayPollListOfUserStory.dart';
import 'package:rollinhead/treeconcept.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_view/story_view.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DisplayPollUserStory extends StatefulWidget {
  @override
  _DisplayPollUserStoryState createState() => _DisplayPollUserStoryState();
}

class _DisplayPollUserStoryState extends State<DisplayPollUserStory> {
  final storyController = StoryController();
  bool _isLoading=true;
  DisplayUserPollStoryApi story;


  Future<List<dynamic>> fetchGetStory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =prefs.getString('user_Id');
    int cusId = int.parse(userId);

    final response = await http.get(
        'https://rolinhead.dolphinfiresafety.com/registration/getAllUserPoll/$cusId'
    );
    story= new DisplayUserPollStoryApi.fromJsonMap(json.decode(response.body.toString()));

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
        title: Text('Poll Story'),
        // leading: BackButton(
        //   onPressed: (){
        //     Navigator.of(context).push(MaterialPageRoute(
        //         builder: (BuildContext context) => Homepage()));
        //   },
        // ),
        actions: <Widget>[
          IconButton(
            icon: new Image.asset('assests/images/p.png',
              height: 400,
              width: 400,
            ),
            tooltip: 'My Poll',
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String userId =prefs.getString('user_Id');
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => DisplayPollListOfUserStory(pollUserId: userId,isMe: "Yes",)));
            }
          ),
          IconButton(
            icon:Icon(Icons.add),
            tooltip: 'Poll',
            onPressed: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => CreatePollPostPage())),
//                    builder: (BuildContext context) => ImageEditorPro())),
              // builder: (BuildContext context) => ChatsLists())),
            },
          ),

        ],
      ),
      body:_isLoading
          ? Center(child: CircularProgressIndicator())
          : story.userPolls.length > 0 ?GridView.builder(
        padding: EdgeInsets.only(top: 15,
        left: 5,right: 5,bottom: 5),
        itemCount: story.userPolls.length,
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
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => TreeConcept(userImageUrl:story.treeUsers[index].userProfilePicture ,
              //     userStoryName: story.treeUsers[index].NodeName,nodeCount:story.treeUsers[index].NodeCount,userTreeId: story.treeUsers[index].UserTreeId,)));
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => DisplayPollListOfUserStory(pollUserId: story.userPolls[index].UserId,isMe: "No",)));
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
                            child: new Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: new BoxDecoration(
                                color: const Color(0xff7c94b6),
                                image: new DecorationImage(
                                  image: new NetworkImage(story.userPolls[index].userProfilePicture),
                                  fit: BoxFit.fill,
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
                            story.userPolls[index].userName != null ?
                            story.userPolls[index].userName :
                            "Name",
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
        child:Text("No Post Available",
          style:
          TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
        ),
      )
    );
  }
}
