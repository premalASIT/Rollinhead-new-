import 'package:flutter/material.dart';
import 'package:rollinhead/Model/DisplayTreeUserList/TreeUserListApi.dart';
import 'package:rollinhead/TreeConceptR/SelectNodeOption.dart';
import 'package:rollinhead/UploadingStory.dart';
import 'package:rollinhead/homepage.dart';
import 'package:rollinhead/listchats.dart';
import 'package:rollinhead/stories.dart';
import 'package:rollinhead/treeconcept.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_view/story_view.dart';
import 'package:rollinhead/Model/storyuploaderlist/StoryuploadersApi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DisplayTreeUserStory extends StatefulWidget {
  @override
  _DisplayTreeUserStoryState createState() => _DisplayTreeUserStoryState();
}

class _DisplayTreeUserStoryState extends State<DisplayTreeUserStory> {
  final storyController = StoryController();
  bool _isLoading=true;
  TreeUserListApi story;


  Future<List<dynamic>> fetchGetStory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =prefs.getString('user_Id');
    int cusId = int.parse(userId);

    final response = await http.get(
        'http://rolinhead.dolphinfiresafety.com/registration/showTreeList/$cusId'
    );
    story= new TreeUserListApi.fromJsonMap(json.decode(response.body.toString()));

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
        title: Text('Tree Story'),
        // leading: BackButton(
        //   onPressed: (){
        //     Navigator.of(context).push(MaterialPageRoute(
        //         builder: (BuildContext context) => Homepage()));
        //   },
        // ),
        actions: <Widget>[
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
//           IconButton(
//             icon: new Image.asset(
//               'assests/images/m.png',
//               height: 400,
//               width: 400,
//             ),
//             tooltip: 'Diary',
//             onPressed: () => {
//               // Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (BuildContext context) => TreeConcept())),
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) => ChatsLists())),
// //                    builder: (BuildContext context) => ImageEditorPro())),
//               // builder: (BuildContext context) => ChatsLists())),
//             },
//           ),
          IconButton(
            icon:Icon(Icons.add),
            tooltip: 'Tree',
            onPressed: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SelectNodeOption())),
//                    builder: (BuildContext context) => ImageEditorPro())),
              // builder: (BuildContext context) => ChatsLists())),
            },
          ),

        ],
      ),
      body:_isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
        padding: EdgeInsets.only(top: 15,
        left: 5,right: 5,bottom: 5),
        itemCount: story.treeUsers.length,
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
                  builder: (BuildContext context) => TreeConcept(userImageUrl:story.treeUsers[index].userProfilePicture ,
                  userStoryName: story.treeUsers[index].NodeName,nodeCount:story.treeUsers[index].NodeCount,userTreeId: story.treeUsers[index].UserTreeId,)));
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => MoreStories(id: story.response[index].userId)));
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
                                  image: new NetworkImage(story.treeUsers[index].userProfilePicture),
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
                            story.treeUsers[index].userName != null ?
                            story.treeUsers[index].userName :
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
      ),
    );
  }
}
