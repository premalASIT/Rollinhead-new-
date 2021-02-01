import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rollinhead/DisplayPollAnswer/DisplayPollAnswerApi.dart';
import 'package:rollinhead/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DisplayResultOfQuestionsAnswerPoll extends StatefulWidget {
  final String pollName;
  final String pollQuestion;
  final String pollId;
  final String pollUserId;
  DisplayResultOfQuestionsAnswerPoll({this.pollName,this.pollQuestion,this.pollId,this.pollUserId});
  @override
  _DisplayResultOfQuestionsAnswerPollState createState() => _DisplayResultOfQuestionsAnswerPollState(pollName,pollQuestion,pollId,pollUserId);
}

class _DisplayResultOfQuestionsAnswerPollState extends State<DisplayResultOfQuestionsAnswerPoll> {
  String pollName;
  String pollQuestion;
  String pollId;
  String pollUserId;
  _DisplayResultOfQuestionsAnswerPollState(this.pollName,this.pollQuestion,this.pollId,this.pollUserId);
  bool _isLoading=false;
  DisplayPollAnswerApi displayPollAnswerApi;

  Future<List<dynamic>> fetchAnswer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String userId =prefs.getString('user_Id');

    final response = await http.get(
        'https://rolinhead.dolphinfiresafety.com/registration/GetMyPollResult/$pollId'
    );
    displayPollAnswerApi = new DisplayPollAnswerApi.fromJsonMap(json.decode(response.body.toString()));

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
    fetchAnswer();
    super.initState();
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
          ),),
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
                onPressed: () {},
                color: Colors.green,
                padding: EdgeInsets.all(5.0),
                child: Text("Yes: " + displayPollAnswerApi.answerDetail[0].YesAnswer,),
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
                onPressed: () {},
                color: Colors.green,
                padding: EdgeInsets.all(5.0),
                child: Text("No: "+ displayPollAnswerApi.answerDetail[0].NoAnswer,),
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
                onPressed: () {},
                color: Colors.green,
                padding: EdgeInsets.all(5.0),
                child: Text("Total Answer: "+ displayPollAnswerApi.answerDetail[0].TotalAnswers,),
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
