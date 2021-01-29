import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rollinhead/DisplayPollListOfUser/DisplayPollListOfUserApi.dart';
import 'package:rollinhead/Model/CheckUserPollAnswerOrNot/CheckUserPollAnswerApi.dart';
import 'package:rollinhead/Model/DisplayPollUserStroy/DisplayUserPollStoryApi.dart';
import 'package:rollinhead/Model/DisplayTreeUserList/TreeUserListApi.dart';
import 'package:rollinhead/PollConceptP/CreatePollPost.dart';
import 'package:rollinhead/PollConceptP/DisplayQuestions&AnswerPoll.dart';
import 'package:rollinhead/PollConceptP/DisplayResultOfQuestions&AnswerPoll.dart';
import 'package:rollinhead/treeconcept.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_view/story_view.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DisplayPollListOfUserStory extends StatefulWidget {
  final String pollUserId;
  final String isMe;
  DisplayPollListOfUserStory({this.pollUserId,this.isMe});

  @override
  _DisplayPollListOfUserStoryState createState() => _DisplayPollListOfUserStoryState(pollUserId,isMe);
}

class _DisplayPollListOfUserStoryState extends State<DisplayPollListOfUserStory> {
  String pollUserId;
  String isMe;
  _DisplayPollListOfUserStoryState(this.pollUserId,this.isMe);
  final storyController = StoryController();
  bool _isLoading=true;
  DisplayPollListOfUserApi story;
  CheckUserPollAnswerApi checkUserPollAnswerApi;


  Future<List<dynamic>> fetchCheckAnswerUser(String pollName,pollQuestion,pollId,pollUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     String userId =prefs.getString('user_Id');

    final response = await http.get(
        'https://rolinhead.dolphinfiresafety.com/registration/CheckAlreadyAnswer/$userId/$pollId'
    );
    checkUserPollAnswerApi= new CheckUserPollAnswerApi.fromJsonMap(json.decode(response.body.toString()));

    if(response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      if(checkUserPollAnswerApi.IsAnswered){
        Fluttertoast.showToast(
            msg: "You have already answered this poll",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
      }else{
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => DisplayQuestionsAnswerPoll(pollName: pollName,pollQuestion: pollQuestion,
              pollId: pollId,pollUserId: pollUserId,)));
      }

      print(response.body);

    }else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }

  }

  Future<List<dynamic>> fetchGetStory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String userId =prefs.getString('user_Id');

    final response = await http.get(
        'http://rolinhead.dolphinfiresafety.com/registration/GetAllUserPollsList/$pollUserId'
    );
    story= new DisplayPollListOfUserApi.fromJsonMap(json.decode(response.body.toString()));

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
        title: Text('Poll List'),
        // leading: BackButton(
        //   onPressed: (){
        //     Navigator.of(context).push(MaterialPageRoute(
        //         builder: (BuildContext context) => Homepage()));
        //   },
        // ),
        actions: <Widget>[
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
             if(isMe=="Yes"){
               Navigator.of(context).push(MaterialPageRoute(
                   builder: (BuildContext context) => DisplayResultOfQuestionsAnswerPoll(pollName:  story.userPolls[index].PollName,pollQuestion: story.userPolls[index].Question,
                   pollId:story.userPolls[index].PollId,pollUserId: story.userPolls[index].userId,)));
             }else{

               setState(() {
                 _isLoading=true;
               });
               fetchCheckAnswerUser(story.userPolls[index].PollName,story.userPolls[index].Question,story.userPolls[index].PollId,story.userPolls[index].userId);
             }

              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => DisplayQuestionsAnswerPoll(pollName:  story.userPolls[index].PollName,pollQuestion: story.userPolls[index].Question,
              //     pollId:story.userPolls[index].PollId,pollUserId: story.userPolls[index].userId,)));
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
                            story.userPolls[index].PollName != null ?
                            story.userPolls[index].PollName :
                            "PollName",
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
