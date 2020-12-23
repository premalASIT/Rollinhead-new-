//import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:image/image.dart' as imageLib;
import 'package:path_provider/path_provider.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:photofilters/widgets/photo_filter.dart';
 //import 'package:path_provider/path_provider.dart';
import 'package:rollinhead/Model/PostCreates/CreatePostApi.dart';
import 'package:rollinhead/example.dart';
import 'package:rollinhead/feedspage.dart';
import 'package:rollinhead/homepage.dart';
import 'package:rollinhead/image_editor.dart';
import 'package:rollinhead/testbright.dart';
// import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CreatePosts extends StatefulWidget {
  @override
  _CreatePostsState createState() => _CreatePostsState();
}

class _CreatePostsState extends State<CreatePosts> {
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
  // void dispose() {
  //   imagefile.clear();
  //   super.dispose();
  // }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        captureImage(ImageSource.gallery);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      captureCameraImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  _cropImage(filePath) async {
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,

    );
    if (croppedImage != null) {
      setState(()  {
        _imageFile = croppedImage;

      });
      ByteData bytes = await rootBundle.load(croppedImage.path);
      print('[[[[[');
      final buffer = bytes.buffer;
      var image = buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      // uploadImageMedia(_imageFile, "msg.text", "loc.text");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (BuildContext context) => WidgetEditableImage(imagem: image)), (
          Route<dynamic> route) => false);
    }
  }

  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final imageFile = await ImagePicker.pickImage(source: imageSource);
      // final String path = await getApplicationDocumentsDirectory().path;
      //  File tmpFile = File(imageFile.path);
      // // tmpFile = await tmpFile.copy(tmpFile.path);
      print("PATH : " + imageFile.path);

      //  print("PATH : " + tmpFile.path);
      setState(() {
        _imageFile = File(imageFile.path);
        pathImages = imageFile.path;
      });
      Future.delayed(Duration(seconds: 0)).then(
            (value) => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => EditPhotoScreen(
              arguments: [_imageFile],
            ),
          ),
        ),
      );
      // _cropImage(_imageFile.path);

      // ByteData bytes = await rootBundle.load(_imageFile.path);
      // print('[[[[[');
      // final buffer = bytes.buffer;
      // var image = buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      // // uploadImageMedia(_imageFile, "msg.text", "loc.text");
      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      //     builder: (BuildContext context) => WidgetEditableImage(imagem: image)), (
      //     Route<dynamic> route) => false);

      // fileName = _imageFile.path.split('/').last;
      // var image1 = imageLib.decodeImage(_imageFile.readAsBytesSync());
      // image1 = imageLib.copyResize(image1, width: 600);

//
//
//        imagefile = await Navigator.push(
//         context,
//         new MaterialPageRoute(
//           builder: (context) =>
//           new PhotoFilterSelector(
//             title: Text("Post"),
//             image: image1,
//             filters: presetFiltersList,
//             filename: fileName,
//             loader: Center(child: CircularProgressIndicator()),
//             fit: BoxFit.contain,
//           ),
//         ),
//       );
//       String xy = imagefile['image_filtered'].toString();
//       if(xy.contains('Inkwell')){
//         print('find');
//         flag = 1;
//       }else{
//         print('not present');
//         flag = 2;
//       }
//       if (imagefile != null && imagefile.containsKey('image_filtered')) {
//         print('in the if of filter');
//         print(imagefile['image_filtered']);
//
//         if(imagefile.containsKey('image_filtered')) {
//           print('xx');
//           if(flag==1) {
//             setState(() async {
//               _imageFile = imagefile['image_filtered'];
//               ByteData bytes = await rootBundle.load(_imageFile.path);
//               print('[[[[[');
//               final buffer = bytes.buffer;
//               var image = buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
//               // uploadImageMedia(_imageFile, "msg.text", "loc.text");
//               Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
//                   builder: (BuildContext context) => WidgetEditableImage(imagem: image)), (
//                   Route<dynamic> route) => false);
//               // uploadImageMedia(_imageFile, "msg.text", "loc.text");
//               // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
//               //     builder: (BuildContext context) => Homepage()), (
//               //     Route<dynamic> route) => false);
//               // Step 3: Get directory where we can duplicate selected file.
// //          final String path = await getApplicationDocumentsDirectory().path;
// //
// //// Step 4: Copy the file to a application document directory.
// //           var fileName = basename(_imageFile.path);
// //          final File localImage = await _imageFile.copy('$path/$fileName');
//             });
//           }else{
//             print('else set state of _img file');
//           }
//         }
//         print('----');
//
//         print(imageFile.path);
//       }
//       else if(imagefile == null){
//         print('in the else of filter');
//         ByteData bytes = await rootBundle.load(_imageFile.path);
//         final buffer = bytes.buffer;
//         var image = buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
//         // uploadImageMedia(_imageFile, "msg.text", "loc.text");
//         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
//             builder: (BuildContext context) => WidgetEditableImage(imagem: image)), (
//             Route<dynamic> route) => false);
//       }
    } catch (e) {
      print("Ex ");
      print(e);

    }
  }

  Future<void> captureCameraImage(ImageSource imageSource) async {
    try {
      final imageFile = await ImagePicker.pickImage(source: imageSource);
      setState(() {
        _imageFile =  File(imageFile.path);

      });

      _cropImage(imageFile.path);

    } catch (e) {
      print("Ex ");
      print(e);
    }
  }
  CreatePostApi changepro;
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
    prefs.setString("imgpath", pathImages);
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
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (BuildContext context) => Homepage()), (
            Route<dynamic> route) => false);
        print(value);
        return Future.value(value);
      });
    } catch (e) {
      print(e);
    }
  }

  Future uploadVideoMedia(File fileVideo,String Msg,Loc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final mimeTypeData =
    lookupMimeType(fileVideo.path, headerBytes: [0xFF, 0xD8]).split('/');
    final imageUploadRequest =
    http.MultipartRequest('POST', Uri.parse("http://rolinhead.dolphinfiresafety.com/registration/createPost"));

    final vfile = await http.MultipartFile.fromPath('videofile', fileVideo.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    imageUploadRequest.fields['userId']= prefs.getString('user_Id') ;
    imageUploadRequest.fields['content']= Msg;
    imageUploadRequest.fields['location']= Loc;

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
        //     builder: (BuildContext context) => FeedPage()), (
        //     Route<dynamic> route) => false);
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
  Future _pickVideo() async {
    // Navigator.of(context).pop();
    // final video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    var video = await FilePicker.getFile(
        type: FileType.custom,
        allowedExtensions: ['mp4','avi'] );
//    videoPlayerController = VideoPlayerController.file(_video)..initialize().then(() {
    if(video!=null){
      setState(() {
        _video = video;
        // Navigator.push(context, MaterialPageRoute(builder: (context) =>
        //     EditVideoScreen(resource:_video.path,groupId: groupId,perView: _video,)));
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [


            _imageFile!=null ?
            Padding(
              padding: const EdgeInsets.only(left:0.0),
              child: Image.file(_imageFile,
              height: 350,
                width: 380,
                fit: BoxFit.fill,
              ),
            )

                : Container(),

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
                  // maxLines: 10,
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

            FlatButton(
              textColor: Colors.red,
              //color: Colors.red,
              child: Text(" Post",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 22,
                ),),
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });

                if (_imageFile != null) {

//  ByteData bytes1 = await rootBundle.load(ImgPath);
//                  final tempDir = await getTemporaryDirectory();
//                  final file = await new File('${tempDir.path}/imageexam.jpg').create();
////                  file.writeAsBytesSync(_imageFile);
//                  file.copySync(_imageFile.path);
//                  ByteData bytes = await rootBundle.load(_imageFile.path);
//                  final buffer = bytes.buffer;
//                  var image = buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
//                  // uploadImageMedia(_imageFile, "msg.text", "loc.text");
//                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
//                      builder: (BuildContext context) => WidgetEditableImage(imagem: image)), (
//                      Route<dynamic> route) => false);
                 uploadImageMedia(_imageFile,msg.text,loc.text);
              }
                else if(_video!=null){
                  setState(() {
                    _isLoading = true;
                  });
                  uploadVideoMedia(_video,msg.text,loc.text);
                }
                else{
                  Fluttertoast.showToast(
                      msg:"Pick the image or video",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2
                  );
                }
              }
            ),
            SizedBox(height: 180,),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                      textColor: Colors.red,
                      //color: Colors.red,
                      child: Text("Pick Image",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 22,
                        ),),
                      onPressed: ()=> _showPicker(context),
                      // captureImage(ImageSource.gallery),
                    ),
                    FlatButton(
                      textColor: Colors.red,
                      //color: Colors.red,
                      child: Text("Pick Video",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 22,
                        ),),
                      onPressed: ()=> _pickVideo(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
