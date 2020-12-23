import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rollinhead/Displaystory.dart';
import 'package:rollinhead/Model/Storylistinguser/UserStoryApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_view/story_view.dart';
import 'package:story_view/widgets/story_view.dart';

void main() => runApp(Strories());

class Strories extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Story',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Home());
  }
}

class Home extends StatelessWidget {
  final StoryController controller = StoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delicious Ghanaian Meals"),
      ),
      body: Container(
        margin: EdgeInsets.all(
          8,
        ),
        child: ListView(
          children: <Widget>[
            Container(
              height: 300,
              child: StoryView(
                controller: controller,
                storyItems: [
                  StoryItem.text(
                    title:
                    "Hello world!\nHave a look at some great Ghanaian delicacies. I'm sorry if your mouth waters. \n\nTap!",
                    backgroundColor: Colors.orange,
                    roundedTop: true,
                  ),
                  // StoryItem.inlineImage(
                  //   NetworkImage(
                  //       "https://image.ibb.co/gCZFbx/Banku-and-tilapia.jpg"),
                  //   caption: Text(
                  //     "Banku & Tilapia. The food to keep you charged whole day.\n#1 Local food.",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       backgroundColor: Colors.black54,
                  //       fontSize: 17,
                  //     ),
                  //   ),
                  // ),
                  StoryItem.inlineImage(
                    url:
                    "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
                    controller: controller,
                    caption: Text(
                      "Omotuo & Nkatekwan; You will love this meal if taken as supper.",
                      style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.black54,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  StoryItem.inlineImage(
                    url:
                    "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
                    controller: controller,
                    caption: Text(
                      "Hektas, sektas and skatad",
                      style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.black54,
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
                onStoryShow: (s) {
                  print("Showing a story");
                },
                onComplete: () {
                  print("Completed a cycle");
                },
                progressPosition: ProgressPosition.bottom,
                repeat: false,
                inline: true,
              ),
            ),
            Material(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MoreStories()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(8))),
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "View more stories",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoreStories extends StatefulWidget {
  String id;
  MoreStories({this.id});
  @override
  _MoreStoriesState createState() => _MoreStoriesState(id);
}

class _MoreStoriesState extends State<MoreStories> {
  String id;
  _MoreStoriesState(this.id);
  final storyController = StoryController();
  bool _isLoading=false;
  int x,y=0;
  UserStoryApi Storyapi;
  Future<List<dynamic>> fetchGetStory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =prefs.getString('user_Id');
    int cusId = int.parse(userId);

    final response = await http.get(
        'http://rolinhead.dolphinfiresafety.com/registration/getUserStory/$id'
    );
    Storyapi= new UserStoryApi.fromJsonMap(json.decode(response.body.toString()));

    if(response.statusCode == 200) {


      x = Storyapi.userStories.length;
      print(x);
      for (int i = 0; i < x; i++) {
        setState(() {
          if(Storyapi.userStories[i].imagePath!="") {
            stories.add(
              StoryItem.pageImage(
                url:
                Storyapi.userStories[i].imagePath,
                  controller: storyController,
              ),
            );
          }
          else if(Storyapi.userStories[i].videoPath!=""){
            stories.add(
            StoryItem.pageVideo( Storyapi.userStories[i].videoPath, controller: storyController)
            );
          }
        });
      }
      print(stories[0]);
      print(response.body);
      setState(() {
        _isLoading = false;
      });
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
  List<StoryItem> stories = new List();
  void initState() {
      _isLoading=true;
      fetchGetStory();
      super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("More"),
      // ),
      body:_isLoading
          ? Center(child: CircularProgressIndicator())
          : StoryView(
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => displaystory()));
          },
          onComplete: () {
            print("Completed a cycle");
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => displaystory()));

          },
          progressPosition: ProgressPosition.top,

          repeat: false,
          controller: storyController,
        ),


    );
  }
  Widget _show(BuildContext context) {

  }
}
