import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rollinhead/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CreatePollPostPage extends StatefulWidget {
  @override
  _CreatePollPostPageState createState() => _CreatePollPostPageState();
}

class _CreatePollPostPageState extends State<CreatePollPostPage> {
  bool  _isLoading = false;
  TextEditingController pollName = new TextEditingController();
  TextEditingController pollQuestion = new TextEditingController();
  final formKey = new GlobalKey<FormState>();

  generatePoll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =prefs.getString('user_Id');
    Map data = {
      'UserId': userId,
      'pollname': pollName.text,
      'pollquestion': pollQuestion.text,
    };
    var response = await http.post(
        "http://rolinhead.dolphinfiresafety.com/registration/createNewPoll",
        body: data);
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "Poll created successfully",
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
        title: Text('Create Poll',
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
      body:_isLoading
          ? Center(child: CircularProgressIndicator())
          :  ListView(
        shrinkWrap: true,
        children: [
          Container(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
                      controller: pollName,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Poll Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Poll Name',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
                      controller: pollQuestion,
                      maxLines: 5,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Poll Question';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Poll Question',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: SizedBox(
                    width: 100,
                    height: 45,
                    child: RaisedButton(
                      color: Colors.red,
                      onPressed: (){
                        final form = formKey.currentState;
                        if (form.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          generatePoll();
                        }
                      },
                      child: Text("Post",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // FlatButton(
          //     textColor: Colors.red,
          //     //color: Colors.red,
          //     child: Text("Post",
          //       style: TextStyle(
          //         color: Colors.red,
          //         fontSize: 22,
          //       ),),
          //     onPressed: ()  {
          //       final form = formKey.currentState;
          //       if (form.validate()) {
          //         setState(() {
          //           _isLoading = true;
          //         });
          //         generatePoll();
          //       }
          //     }
          // ),
        ],
      ),
    );
  }
}
