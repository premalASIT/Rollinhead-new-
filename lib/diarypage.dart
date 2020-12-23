import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:rollinhead/Model/UploadDiary/UploaddiaryApi.dart';
import 'package:rollinhead/feedspage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Diarypage extends StatefulWidget {
  @override
  _DiarypageState createState() => _DiarypageState();
}

class _DiarypageState extends State<Diarypage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController note = new TextEditingController();
  File _imageFile ;
  int selectedRadio = 3;
  String option;
  UploaddiaryApi upload;
  bool  _isLoading = false;
  Future diary(File fileImage,String detail,type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final mimeTypeData =
    lookupMimeType(fileImage.path, headerBytes: [0xFF, 0xD8]).split('/');
    final imageUploadRequest =
    http.MultipartRequest('POST', Uri.parse("http://rolinhead.dolphinfiresafety.com/registration/diaryUpload"));

    final file = await http.MultipartFile.fromPath('diaryfile', fileImage.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    imageUploadRequest.fields['userId']= prefs.getString('user_Id');
    imageUploadRequest.fields['content']= detail;
    imageUploadRequest.fields['isPublic']= type;
    imageUploadRequest.files.add(file);
    try {
      _isLoading = false;

      final streamedResponse = await imageUploadRequest.send();

      streamedResponse.stream.transform(utf8.decoder).listen((value) {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );

        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => FeedPage()
        ));
        print(value);
        return Future.value(value);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final imageFile = await ImagePicker.pickImage(source: imageSource);
      setState(() {
        _imageFile =  File(imageFile.path);
       // uploadImageMedia(_imageFile);
      });
    } catch (e) {
      print("Ex ");
      print(e);
    }
  }
  setSelectedRadio(int val) {
    setState(() {
      if(val==1) {
        selectedRadio = val;
        option ="0";
      }
      else if(val==2) {
        selectedRadio = val;
        option ="1";
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_isLoading ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child:
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 35,),
                  Text("Create Story",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  ),
                  SizedBox(height: 40,),

                 //   borderRadius: BorderRadius.circular(160),

                   _imageFile == null
                        ?  Image.asset( "assests/images/avtar.png",
                      height: 270,
                      width:350,
                      fit: BoxFit.fill,)
                        :Image.file(_imageFile,
                      height: 270,
                      width: 360,
                      fit: BoxFit.fill,
                    ),


                  FlatButton(
                    textColor: Colors.red,
                    //color: Colors.red,
                    child: Text("Upload Photo",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 22,
                      ),),
                    onPressed: ()=> captureImage(ImageSource.gallery),
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
                        maxLength: 500,
                        maxLines: 50,
                        autofocus: false,
                        controller: note,
                        style: TextStyle(fontSize: 15.0, color: Color(0xFFbdc6cf)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Note',
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
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: selectedRadio,
                            activeColor: Colors.black,
                            onChanged: (val) {
                              print("Radio $val");
                              setSelectedRadio(val);
                              setState(() {
                                selectedRadio = 1;
                                option ="0";
                              });
                            },
                          ),
                          Text("Private",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Radio(
                            value: 2,
                            groupValue: selectedRadio,
                            activeColor: Colors.black,
                            onChanged: (val) {
                              print("Radio $val");
                              setSelectedRadio(val);
                              setState(() {
                                selectedRadio = 2;
                                option ="1";
                              });
                            },

                          ),
                          Text("Public",
                            style: TextStyle(
                              fontSize: 15,

                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: MaterialButton(
                      height: 50,
                      minWidth: 150,
                      color: Colors.red,
                      onPressed: (){
                        setState(() {
                          _isLoading = true;
                        });
                                diary(_imageFile,note.text,option);
                      },
                      child: Text("Upload",
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
            )

      ),
    );
  }
}
