import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:rollinhead/homepage.dart';
import 'package:rollinhead/taguserposts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostData extends StatefulWidget {
  final File img;
  PostData({this.img});
  @override
  _PostDataState createState() => _PostDataState(img);
}

class _PostDataState extends State<PostData> {
  File img;
  _PostDataState(this.img);
  TextEditingController msg = new TextEditingController();
  TextEditingController loc = new TextEditingController();
  TextEditingController tag = new TextEditingController();
  bool _isLoading = false;

  Future uploadImageMedia(File fileImage,String Msg,Loc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final mimeTypeData =
    lookupMimeType(fileImage.path, headerBytes: [0xFF, 0xD8]).split('/');
    final imageUploadRequest =
    http.MultipartRequest('POST', Uri.parse("http://rolinhead.dolphinfiresafety.com/registration/createPost"));
    final file = await http.MultipartFile.fromPath('imagefile', fileImage.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    final vfile = await http.MultipartFile.fromPath('videofile', fileImage.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
//  prefs.setString("imgpath", pathImages);
    imageUploadRequest.fields['userId']= prefs.getString('user_Id') ;
    imageUploadRequest.fields['content']= Msg;
    imageUploadRequest.fields['location']= Loc;

    imageUploadRequest.files.add(file);
    imageUploadRequest.files.add(vfile);
    try {
      _isLoading = false;

      final streamedResponse = await imageUploadRequest.send();

      streamedResponse.stream.transform(utf8.decoder).listen((value) {
        Fluttertoast.showToast(
            msg:"Successfully post",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        //     builder: (BuildContext context) => Homepage()), (
        //     Route<dynamic> route) => false);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>TagUserPosts() ));
        print(value);
        return Future.value(value);
      });
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
        children: <Widget>[
          SizedBox(height:20,),
         Image.file(img,
           fit: BoxFit.fill,

           ),

          Container(

            child: Theme(
              data: Theme.of(context).copyWith(splashColor: Colors.transparent),
              child: TextFormField(
                validator: (value){
                  if(value.isEmpty){
                    return "* Required";
                  }
                  return null;
                },
                // maxLength: 200,
                 maxLines: 10,
                autofocus: false,
                controller: msg,
                //style: TextStyle(fontSize: 15.0, color: Color(0xFFbdc6cf)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Content',
                  contentPadding:
                  const EdgeInsets.only(left: 16.0, bottom: 12.0, top: 20.0),


                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),

                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                ),
              ),
            ),

            decoration: new BoxDecoration (
                borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
                color: Colors.white   ),
            width: 350,
            height: 150,
            margin: new EdgeInsets.fromLTRB(26, 20, 20, 20),
            padding: new EdgeInsets.fromLTRB(8, 8, 8, 8),

          ),

          Container(
            child: Theme(
              data: Theme.of(context).copyWith(splashColor: Colors.transparent),
              child: TextFormField(
                validator: (value){
                  if(value.isEmpty){
                    return "* Required";
                  }
                  return null;
                },
                // maxLength: 15,

                autofocus: false,
                controller: loc,
                //style: TextStyle(fontSize: 15.0, color: Color(0xFFbdc6cf)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Location',
                  contentPadding:
                  const EdgeInsets.only(left: 16.0, bottom: 12.0, top: 20.0),


                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),

                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                ),
              ),
            ),

            decoration: new BoxDecoration (
                borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
                color: Colors.white   ),
            width: 350,
            height: 80,
            margin: new EdgeInsets.fromLTRB(26, 20, 20, 20),
            padding: new EdgeInsets.fromLTRB(8, 8, 8, 8),

          ),

          // Container(
          //   child: Theme(
          //     data: Theme.of(context).copyWith(splashColor: Colors.transparent),
          //     child: TextFormField(
          //       validator: (value){
          //         if(value.isEmpty){
          //           return "* Required";
          //         }
          //         return null;
          //       },
          //       // maxLength: 15,
          //
          //       autofocus: false,
          //       controller: tag,
          //       //style: TextStyle(fontSize: 15.0, color: Color(0xFFbdc6cf)),
          //       decoration: InputDecoration(
          //         filled: true,
          //         fillColor: Colors.white,
          //         hintText: 'Tag People',
          //         contentPadding:
          //         const EdgeInsets.only(left: 16.0, bottom: 12.0, top: 20.0),
          //
          //
          //         focusedBorder: OutlineInputBorder(
          //           borderSide: BorderSide(color: Colors.white),
          //           borderRadius: BorderRadius.circular(25.7),
          //         ),
          //
          //         enabledBorder: UnderlineInputBorder(
          //           borderSide: BorderSide(color: Colors.white),
          //           borderRadius: BorderRadius.circular(25.7),
          //         ),
          //       ),
          //     ),
          //   ),
          //
          //   decoration: new BoxDecoration (
          //       borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
          //       color: Colors.white   ),
          //   width: 350,
          //   height: 80,
          //   margin: new EdgeInsets.fromLTRB(26, 20, 20, 20),
          //   padding: new EdgeInsets.fromLTRB(8, 8, 8, 8),
          //
          // ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 90,
                  height: 45,
                  child: RaisedButton(
                    color: Colors.red,
                    onPressed: (){
                      setState(() {
                        _isLoading = true;
                      });
                      // uploadImageMedia(img,msg.text,loc.text);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => TagUserPosts(location: loc.text,message: msg.text, images: img,)
                      ));
                    },
                    child: Text(" Post",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
          // FlatButton(
          //   textColor: Colors.red,
          // //color: Colors.red,
          //   child: Text(" Post",
          //     style: TextStyle(
          //     color: Colors.red,
          //     fontSize: 22,
          //   ),),
          //   onPressed: (){
          //     setState(() {
          //       _isLoading = true;
          //     });
          //     // uploadImageMedia(img,msg.text,loc.text);
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (BuildContext context) => TagUserPosts(location: loc.text,message: msg.text, images: img,)
          //     ));
          //   },
          // ),
        ],
      ),
    );
  }
}
