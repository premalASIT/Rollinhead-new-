import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';
import 'package:rollinhead/feedspage.dart';
import 'package:rollinhead/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MaterialApp(home: UploadPost(),debugShowCheckedModeBanner: false,));

class UploadPost extends StatefulWidget {
  @override
  _UploadPostState createState() => new _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {
  String fileName;
  List<Filter> filters = presetFiltersList;
  File imageFile;
  bool _isLoading = false;
  _cropImage(filePath) async {
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,

    );
    if (croppedImage != null) {

      setState(() {
        imageFile = croppedImage;
      });
    }
  }

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
    // prefs.setString("imgpath", pathImages);
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

        print(value);
        return Future.value(value);
      });
    } catch (e) {
      print(e);
    }
  }

  Future getImage(context) async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    _cropImage(imageFile.path);
    fileName = basename(imageFile.path);
    var image = imageLib.decodeImage(imageFile.readAsBytesSync());
    image = imageLib.copyResize(image, width: 600);

    Map imagefile = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new PhotoFilterSelector(
          title: Text("Post"),
          image: image,
          filters: presetFiltersList,
          filename: fileName,
          loader: Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      setState(() {
        imageFile = imagefile['image_filtered'];

      });
      uploadImageMedia(imageFile,"msg.text","loc.text");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (BuildContext context) => Homepage()), (
          Route<dynamic> route) => false);
      print(imageFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Photo Post'),
      ),
      body: Center(
        child: new Container(
          child: imageFile == null
              ? Center(
            child: new Text('No image selected.'),
          )
              : Image.file(imageFile),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => getImage(context),
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}