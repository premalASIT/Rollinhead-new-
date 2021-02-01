import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rollinhead/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DisplayQuestionsAnswerPoll extends StatefulWidget {
  final String pollName;
  final String pollQuestion;
  final String pollId;
  final String pollUserId;
  DisplayQuestionsAnswerPoll({this.pollName,this.pollQuestion,this.pollId,this.pollUserId});
  @override
  _DisplayQuestionsAnswerPollState createState() => _DisplayQuestionsAnswerPollState(pollName,pollQuestion,pollId,pollUserId);
}

class _DisplayQuestionsAnswerPollState extends State<DisplayQuestionsAnswerPoll> {
  String pollName;
  String pollQuestion;
  String pollId;
  String pollUserId;
  _DisplayQuestionsAnswerPollState(this.pollName,this.pollQuestion,this.pollId,this.pollUserId);
  bool _isLoading=false;

  giveAnswer(String answer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =prefs.getString('user_Id');

    Map data = {
      'userId': userId,
      'pollId': pollId,
      'answer': answer,
    };
    var response = await http.post(
        "http://rolinhead.dolphinfiresafety.com/registration/submitPollAnswer",
        body: data);
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "Successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2
      );
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Homepage()),
              (Route<dynamic> route) => false);
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
        title: Text(pollName,
        overflow: TextOverflow.ellipsis,
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
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator()) :ListView(
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text("Question",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(pollQuestion,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Container(
              margin: EdgeInsets.all(0),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(0),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: OutlineButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });
                  giveAnswer("Y");
                },
                color: Colors.green,
                padding: EdgeInsets.all(5.0),
                child: Text("Yes",),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Container(
              margin: EdgeInsets.all(0),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(0),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: OutlineButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });
                  giveAnswer("N");
                },
                color: Colors.green,
                padding: EdgeInsets.all(5.0),
                child: Text("No",),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
