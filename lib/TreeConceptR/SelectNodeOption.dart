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
import 'package:rollinhead/TreeConceptR/TreeCreaatePost.dart';



class SelectNodeOption extends StatefulWidget {
  final String nodeName;
  SelectNodeOption({this.nodeName});
  @override
  _SelectNodeOptionState createState() => _SelectNodeOptionState(nodeName);
}

class _SelectNodeOptionState extends State<SelectNodeOption> {
  String nodeName;
  _SelectNodeOptionState(this.nodeName);
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
  // final String path = await getApplicationDocumentsDirectory().path;


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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => TreeCreatePost(nodeName:"Node 1",selectedNode: 1,)));
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => TreeCreatePost(nodeName:"Node 1",selectedNode: 2,)));
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => TreeCreatePost(nodeName:"Node 1",selectedNode: 3,)));
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => TreeCreatePost(nodeName:"Node 1",selectedNode: 4,)));
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => TreeCreatePost(nodeName:"Node 1",selectedNode: 5,)));
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
