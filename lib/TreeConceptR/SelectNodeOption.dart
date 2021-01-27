//import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:rollinhead/Model/PostCreates/CreatePostApi.dart';
import 'package:rollinhead/Model/SelectedNodeTree/SelectedNodeTreeApi.dart';
import 'package:rollinhead/TreeConceptR/TreeCreaatePost.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SelectNodeOption extends StatefulWidget {
  final String nodeName;
  final int nodeNumber;
  SelectNodeOption({this.nodeName,this.nodeNumber});
  @override
  _SelectNodeOptionState createState() => _SelectNodeOptionState(nodeName,nodeNumber);
}

class _SelectNodeOptionState extends State<SelectNodeOption> {
  String nodeName;
  int nodeNumber;
  _SelectNodeOptionState(this.nodeName,this.nodeNumber);
  File _imageFile;
  String fileName;
  List<Filter> filters = presetFiltersList;
  File _video;
  File localImage;
  int flag=3;
  TextEditingController msg = new TextEditingController();
  TextEditingController loc = new TextEditingController();
  bool  _isLoading = false;
  String pathImages;
  Map imagefile;
  SelectedNodeTreeApi selectedNodeTreeApi;

  // final String path = await getApplicationDocumentsDirectory().path;

  generateTreeId(String nodeName,int selectedNode,int nodeNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString('user_Id');

    Map data = {
      'UserId': userid,
      'nodeCount': '$selectedNode',
    };
    var response = await http.post(
        "http://rolinhead.dolphinfiresafety.com/registration/createBlankUserTree",
        body: data);
    selectedNodeTreeApi = new SelectedNodeTreeApi.fromJsonMap(json.decode(response.body.toString()));
    if (response.statusCode == 200) {
      if (selectedNodeTreeApi.status.code == 200) {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: selectedNodeTreeApi.status.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => TreeCreatePost(nodeName:nodeName,selectedNode: selectedNode,userTreeId: selectedNodeTreeApi.userTreeId,nodeNumber:nodeNumber,)));

        print(response.body);
      } else {
        print("else");
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: selectedNodeTreeApi.status.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2);
        print(response.body);
      }
    } else {
      print("ELSE @");
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: selectedNodeTreeApi.status.message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);
      print(response.body);
    }
  }

  @override
  void initState() {

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tree Post'),
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator())
          : ListView(
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Select Node",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: RaisedButton(
                  color: Colors.red,
                  onPressed: (){
                    setState(() {
                      _isLoading = true;
                    });
                    generateTreeId("Node 1",1,1);
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) => TreeCreatePost(nodeName:"Node 1",selectedNode: 1,)));
                  },
                  child: Text("1 Node",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: RaisedButton(
                  color: Colors.red,
                  onPressed: (){
                    setState(() {
                      _isLoading = true;
                    });
                    generateTreeId("Node 1",2,1);
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) => TreeCreatePost(nodeName:"Node 1",selectedNode: 2,)));
                  },
                  child: Text("2 Node",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: RaisedButton(
                  color: Colors.red,
                  onPressed: (){
                    setState(() {
                      _isLoading = true;
                    });
                    generateTreeId("Node 1",3,1);
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) => TreeCreatePost(nodeName:"Node 1",selectedNode: 3,)));
                  },
                  child: Text("3 Node",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: RaisedButton(
                  color: Colors.red,
                  onPressed: (){
                    setState(() {
                      _isLoading = true;
                    });
                    generateTreeId("Node 1",4,1);

                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) => TreeCreatePost(nodeName:"Node 1",selectedNode: 4,)));
                  },
                  child: Text("4 Node",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: RaisedButton(
                  color: Colors.red,
                  onPressed: (){
                    setState(() {
                      _isLoading = true;
                    });
                    generateTreeId("Node 1",5,1);

                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) => TreeCreatePost(nodeName:"Node 1",selectedNode: 5,)));
                  },
                  child: Text("5 Node",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ],

          ),
    );
  }
}
