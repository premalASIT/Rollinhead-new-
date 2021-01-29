
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:rollinhead/Model/ProfilePic/PictureProfileApi.dart';
import 'package:rollinhead/Model/UpdateProfile/UpdateProfileApi.dart';
import 'package:rollinhead/Model/ViewProfile/ViewprofileApi.dart';
import 'package:rollinhead/Widgets/Emailvalidate.dart';
import 'package:http/http.dart' as http;
import 'package:rollinhead/homepage.dart';
import 'package:rollinhead/namepass.dart';
import 'dart:io';
import 'dart:async';

import 'package:rollinhead/personality.dart';
import 'package:rollinhead/post.dart';
import 'package:rollinhead/profilepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(Editprofile());
}
class Editprofile extends StatefulWidget {
  @override
  _EditprofileState createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  TextEditingController name = new TextEditingController();
  TextEditingController username = new TextEditingController();
  TextEditingController website = new TextEditingController();
  TextEditingController bio = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController gender = new TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  File _imageFile ;
  bool _isLoading = false;
  UpdateProfileApi updprofile;
  ViewprofileApi viewprofile;
  int selectedRadio = 3;

  profile(String name,username,website,bio,email,phone,gender) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =prefs.getString('user_Id');
    Map data = {
      'userId': userId,
      'name': name,
      'username': username,
      'website' : website,
      'bio': bio,
      'email':email,
      'phone': phone,
      'gender' : gender,
      'isPublic': selectedRadio.toString()
    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/saveUserProfile", body: data);
    updprofile = new UpdateProfileApi.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (updprofile.status.code==200) {
        setState(() {
          _isLoading = false;
        });
        print(response.body);
        print("done2");
        print("done");
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Homepage()),
                (Route<dynamic> route) => false);
        Fluttertoast.showToast(
            msg: updprofile.status.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
      }
      else{
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: updprofile.status.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
        print(response.body);
      }
    }else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  Future<List<dynamic>> fetchGetprofile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =prefs.getString('user_Id');
    int cusId = int.parse(userId);
    Map data = {
      'userId': userId,
    };
    final response = await http.post(
        'http://rolinhead.dolphinfiresafety.com/registration/userProfile',body:data
    );
    viewprofile= new ViewprofileApi.fromJsonMap(json.decode(response.body.toString()));

    if(response.statusCode == 200 && viewprofile.status.code==200) {

      setState(() {
        _isLoading = false;
      });
      name.text = viewprofile.response.name;
      username.text =viewprofile.response.userName;
      website.text =viewprofile.response.website;
      bio.text = viewprofile.response.bio;
      email.text = viewprofile.response.userEmail;
      phone.text = viewprofile.response.userMobile;
      gender.text = viewprofile.response.userGender;
      selectedRadio = int.parse(viewprofile.response.isPublic);
      setSelectedRadio(selectedRadio);
      print(response.body);

    }else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }

  }

  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final imageFile = await ImagePicker.pickImage(source: imageSource);
      setState(() {
        _imageFile =  File(imageFile.path);
        uploadImageMedia(_imageFile);
      });
    } catch (e) {
      print("Ex ");
      print(e);
    }
  }

  PictureProfileApi changepro;
  Future uploadImageMedia(File fileImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final mimeTypeData =
    lookupMimeType(fileImage.path, headerBytes: [0xFF, 0xD8]).split('/');
    final imageUploadRequest =
    http.MultipartRequest('POST', Uri.parse("http://rolinhead.dolphinfiresafety.com/registration/profilePictureUpload"));

    final file = await http.MultipartFile.fromPath('ProfileImage', fileImage.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    imageUploadRequest.fields['UserId']= prefs.getString('user_Id') ;

    imageUploadRequest.files.add(file);
    try {
      _isLoading = true;

      final streamedResponse = await imageUploadRequest.send();

      streamedResponse.stream.transform(utf8.decoder).listen((value) {
        Fluttertoast.showToast(
            msg: "Profile Picture Updated Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
        fetchGetprofile();
        print(value);
        return Future.value(value);
      });
    } catch (e) {
      print(e);
    }
  }

  setSelectedRadio(int val) {
    setState(() {
      if(val==0) {
        selectedRadio = val;

      }
      else if(val==1) {
        selectedRadio = val;
      }
    });
  }
  void initState() {
    _isLoading=true;
    fetchGetprofile();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? Center(child: CircularProgressIndicator()) :SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(Icons.close, size: 40,
                          color: Colors.black87,),
                        onPressed: (){
                          if (formKey.currentState.validate()) {
                            setState(() {
                              _isLoading= true;
                            });
                          // Navigator.of(context).pop();
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Homepage()),
                                    (Route<dynamic> route) => false);
                        }
                        else{
                          Fluttertoast.showToast(
                              msg: "Please enter username",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2
                          );
                        }
                        },
                      ),
                    ),
                  ),

                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.check, size: 40,
                          color: Colors.black87,),
                        onPressed: (){
                          if(selectedRadio==3){
                            Fluttertoast.showToast(
                                msg: "Please Select the account type",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2
                            );
                          }
                          else{
                            if (formKey.currentState.validate()) {
                              setState(() {
                                _isLoading= true;
                              });
                              profile(name.text,username.text,website.text,bio.text,email.text,phone.text,gender.text);
                              print("Submit");
                            }}
                        },

                      ),
                    ),
                  ),
                ],
              ),
              Text("Edit Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(160),

                child: _imageFile == null
                    ?  Image.network(viewprofile.response.userProfilePicture,
                  height: 160,
                  width:160,
                  fit: BoxFit.fill,)
                    :Image.file(_imageFile,
                  height: 160,
                  width: 160,
                  fit: BoxFit.fill,
                ),

              ),
              FlatButton(
                textColor: Colors.red,
                //color: Colors.red,
                child: Text("Change Profile Photo",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                  ),),
                onPressed: ()=> captureImage(ImageSource.gallery),
              ),
              Padding(
                padding: const EdgeInsets.only(left:14.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Name",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:14.0),
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:14.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Username",

                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),)),
              ),
              Padding(
                padding: const EdgeInsets.only(left:14.0),
                child: TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                    // hintText: viewprofile.response.userName != null ? viewprofile.response.userName : "Username",
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please enter username';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:14.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Website",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),)),
              ),
              Padding(
                padding: const EdgeInsets.only(left:14.0),
                child: TextFormField(
                  controller: website,
                  decoration: InputDecoration(
                    // hintText: viewprofile.response.website!=null ? viewprofile.response.website : "Website" ,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left:14.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Bio",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),)),
              ),
              Padding(
                padding: const EdgeInsets.only(left:14.0),
                child: TextField(
                  controller: bio,
                  decoration: InputDecoration(
                    // hintText: viewprofile.response.bio != null ? viewprofile.response.bio : "Bio",
                  ),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Radio(
                        value: 0,
                        groupValue: selectedRadio,
                        activeColor: Colors.black,
                        onChanged: (val) {
                          print("Radio $val");
                          setSelectedRadio(val);
                          setState(() {
                            selectedRadio = 1;

                          });
                        },
                      ),
                      Text("Private",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Radio(
                        value: 1,
                        groupValue: selectedRadio,
                        activeColor: Colors.black,
                        onChanged: (val) {
                          print("Radio $val");
                          setSelectedRadio(val);
                          setState(() {
                            selectedRadio = 2;
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
                padding: const EdgeInsets.all(12.0),
                child: Text("Personal Information",
                  style: TextStyle(

                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:14.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("E-mail Address",

                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),)),
              ),
              Padding(
                padding: const EdgeInsets.only(left:14.0),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    // hintText: viewprofile.response.userEmail != null ? viewprofile.response.userEmail : "Email",
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please enter Email Address';
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:14.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Phone Number",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),)),
              ),
              Padding(
                padding: const EdgeInsets.only(left:14.0),
                child: TextFormField(
                  controller: phone,
                  decoration: InputDecoration(
                    // hintText: viewprofile.response.userMobile !=null ? viewprofile.response.userMobile : "Mobile",
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please enter Phone Number';
                    }
                    else if (value.length!=10)
                    {
                      return 'Please enter valid Phone number';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:14.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Gender",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),)),
              ),
              Padding(
                padding: const EdgeInsets.only(left:14.0),
                child: TextFormField(
                  controller: gender,
                  decoration: InputDecoration(
                    // hintText: viewprofile.response.userGender != null ? viewprofile.response.userGender : "Gender" ,
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please enter Gender';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
