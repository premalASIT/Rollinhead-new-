import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:rollinhead/Model/PostCreates/CreatePostApi.dart';
import 'package:rollinhead/feedspage.dart';
import 'package:rollinhead/homepage.dart';
import 'package:rollinhead/image_editor.dart';
import 'package:shared_preferences/shared_preferences.dart';



class TreeCreatePost extends StatefulWidget {
  final String nodeName;
  final int selectedNode;
  TreeCreatePost({this.nodeName,this.selectedNode});
  @override
  _TreeCreatePostState createState() => _TreeCreatePostState(nodeName,selectedNode);
}

class _TreeCreatePostState extends State<TreeCreatePost> {
  String nodeName;
  int selectedNode;
  _TreeCreatePostState(this.nodeName,this.selectedNode);
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
  String _platformMessage = 'No Error';
  List images;
  int maxImageNo = 10;
  bool selectSingleImage = false;
  // final String path = await getApplicationDocumentsDirectory().path;


  @override
  void initState() {

    super.initState();
  }
  // void dispose() {
  //   imagefile.clear();
  //   super.dispose();
  // }
  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
      flag=1;
    });
  }

  // initMultiPickUp() async {
  //   setState(() {
  //     images = null;
  //     _platformMessage = 'No Error';
  //   });
  //   List resultList;
  //   String error;
  //   try {
  //     resultList = await FlutterMultipleImagePicker.pickMultiImages(
  //         maxImageNo, selectSingleImage);
  //   } on PlatformException catch (e) {
  //     error = e.message;
  //   }
  //
  //   if (!mounted) return;
  //
  //   setState(() {
  //     images = resultList;
  //     if (error == null) _platformMessage = 'No Error Dectected';
  //   });
  // }

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

  // Future<void> captureCameraImage(ImageSource imageSource) async {
  //   try {
  //     final imageFile = await ImagePicker.pickImage(source: imageSource);
  //     setState(() {
  //       _imageFile =  File(imageFile.path);
  //
  //     });
  //
  //     _cropImage(imageFile.path);
  //
  //   } catch (e) {
  //     print("Ex ");
  //     print(e);
  //   }
  // }
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
        title: Text('Tree Post'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(nodeName,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 22,
                ),),
            ),
            _imageFile!=null ?
            Padding(
              padding: const EdgeInsets.only(left:0.0),
              child: Image.file(_imageFile,
              height: 350,
                width: double.infinity,
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
                  // maxLength: 15,

                  autofocus: false,
                  controller: loc,
                  //style: TextStyle(fontSize: 15.0, color: Color(0xFFbdc6cf)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Name',

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
              height: 50,
              margin: new EdgeInsets.fromLTRB(26, 20, 20, 20),
              padding: new EdgeInsets.fromLTRB(8, 8, 8, 8),

            ),
            FlatButton(
                textColor: Colors.red,
                //color: Colors.red,
                child: Text(nodeName=="Node 5" || selectedNode==1?"Submit"
                    :selectedNode==2?nodeName=="Node 2"?"Submit":"Next"
                    :selectedNode==3?nodeName=="Node 3"?"Submit":"Next"
                    :selectedNode==4?nodeName=="Node 4"?"Submit":"Next"
                    :"Next",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                  ),),
                onPressed: () async {
                  if(selectedNode==1){
                    if(nodeName=="Node 1"){
                      Fluttertoast.showToast(
                          msg: "Success",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2
                      );
                    }
                  }else if(selectedNode==2){
                    if(nodeName=="Node 1"){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => TreeCreatePost(nodeName:"Node 2",selectedNode: 2,)));
                    }else if(nodeName=="Node 2"){
                      Fluttertoast.showToast(
                          msg: "Success",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2
                      );
                    }
                  }else if(selectedNode==3){
                    if(nodeName=="Node 1"){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => TreeCreatePost(nodeName:"Node 2",selectedNode: 3,)));
                    }else if(nodeName=="Node 2"){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => TreeCreatePost(nodeName:"Node 3",selectedNode: 3,)));
                    }else if(nodeName=="Node 3"){
                      Fluttertoast.showToast(
                          msg: "Success",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2
                      );
                    }
                  }else if(selectedNode==4){
                    if(nodeName=="Node 1"){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => TreeCreatePost(nodeName:"Node 2",selectedNode: 4,)));
                    }else if(nodeName=="Node 2"){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => TreeCreatePost(nodeName:"Node 3",selectedNode: 4,)));
                    }else if(nodeName=="Node 3"){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => TreeCreatePost(nodeName:"Node 4",selectedNode: 4,)));
                    }else if(nodeName=="Node 4"){
                      Fluttertoast.showToast(
                          msg: "Success",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2
                      );
                    }
                  }else if(selectedNode==5){
                    if(nodeName=="Node 1"){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => TreeCreatePost(nodeName:"Node 2",selectedNode: 5,)));
                    }else if(nodeName=="Node 2"){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => TreeCreatePost(nodeName:"Node 3",selectedNode: 5,)));
                    }else if(nodeName=="Node 3"){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => TreeCreatePost(nodeName:"Node 4",selectedNode: 5,)));
                    }else if(nodeName=="Node 4"){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => TreeCreatePost(nodeName:"Node 5",selectedNode: 5,)));
                    }else if(nodeName=="Node 5"){
                      Fluttertoast.showToast(
                          msg: "Success",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2
                      );
                    }
                  }

                  //   setState(() {
                  //     _isLoading = true;
                  //   });
                  //
                  //   if (_imageFile != null) {
                  //    uploadImageMedia(_imageFile,msg.text,loc.text);
                  // }
                  //   else if(_video!=null){
                  //     setState(() {
                  //       _isLoading = true;
                  //     });
                  //     uploadVideoMedia(_video,msg.text,loc.text);
                  //   }
                  //   else{
                  //     Fluttertoast.showToast(
                  //         msg:"Pick the image or video",
                  //         toastLength: Toast.LENGTH_LONG,
                  //         gravity: ToastGravity.BOTTOM,
                  //         timeInSecForIosWeb: 2
                  //     );
                  //   }
                }
            ),
            FlatButton(
              textColor: Colors.red,
              //color: Colors.red,
              child: Text("Pick Image",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 22,
                ),),
              onPressed:_getImage,
            ),
            // SizedBox(height: 180,),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: <Widget>[
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         FlatButton(
            //           textColor: Colors.red,
            //           //color: Colors.red,
            //           child: Text("Pick Image",
            //             style: TextStyle(
            //               color: Colors.red,
            //               fontSize: 22,
            //             ),),
            //           onPressed: _getImage,
            //           // captureImage(ImageSource.gallery),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
