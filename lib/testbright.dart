import 'dart:async';
import 'dart:convert';
import 'dart:io';
//import 'dart:js';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter_image_editor/flutter_image_editor.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';

import 'package:rollinhead/homepage.dart';
import 'package:rollinhead/postdata.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
void main() async {
 // WidgetEditableImage.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
//    SharedPreferences prefs = await SharedPreferences.getInstance();
// //   String ImgPath = '/data/user/0/com.example.rollinhead/cache/image_picker2287579110485585909.jpg';
// //   String ImgPath = prefs.getString('imgpath');
// //   String ImgPath = prefs.getString('imgpath');
//   // print('sessoion' + ImgPath);
//   ByteData bytes = await rootBundle.load('assests/images/1.jpg');
// //  ByteData bytes1 = await rootBundle.load(ImgPath);
//   final buffer = bytes.buffer;
//   var image = buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
//
//   runApp(WidgetEditableImage(imagem: image));

}
File fileimg;
class WidgetEditableImage extends StatefulWidget {
  final Uint8List imagem;
//  String message,location;
  WidgetEditableImage({
    Key key,
    @required this.imagem,

  }) : super(key: key);

  @override
  _WidgetEditableImage createState() => _WidgetEditableImage();
}

class _WidgetEditableImage extends State<WidgetEditableImage> {
  StreamController<Uint8List> _pictureStream;
  double _contrast;
  double _brightness;
  ByteData pictureByteData;
  Uint8List picture;
  double bright;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _pictureStream = new StreamController<Uint8List>();
    _brightness = 0;
    _contrast = 1;

    pictureByteData = ByteData.view(widget.imagem.buffer);
    picture = pictureByteData.buffer.asUint8List(
        pictureByteData.offsetInBytes, pictureByteData.lengthInBytes);
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
  void upload(File f){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => PostData(img : fileimg)));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
//        appBar: AppBar(
//          leading: BackButton(),
//          backgroundColor: Colors.white,
//          actions: <Widget>[
//            IconButton(
//              icon: Icon(Icons.cancel),
//              onPressed: () {
//
//              },
//            ),
//          ],
//        ),
          body: containerEditableImage(_pictureStream, picture, _contrast,
              _brightness, setBrightness, setContrast, updatePicutre, uploadImageMedia,upload)),
    );
  }

  void updatePicutre(double contrast, double brightness) async {
    var retorno = await PictureEditor.editImage(picture, contrast, brightness);
    _pictureStream.add(retorno);
  }

  void setBrightness(double valor) {
    setState(() {
      _brightness = valor;
    });
  }

  void setContrast(double valor) {
    setState(() {
      _contrast = valor;
    });
  }
}


Widget rotateImage(Uint8List picture, StreamController picutreStream) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Text("If you want to rotate the image, use this on scaffold body"),
      Container(
          height: 350,
          width: 320,
          child: StreamBuilder(
            stream: picutreStream.stream,
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                return Image.memory(
                  snapshot.data,
                  gaplessPlayback: true,
                  fit: BoxFit.contain,
                );
              } else {
                return Image.memory(
                  picture,
                  gaplessPlayback: true,
                  fit: BoxFit.contain,
                );
              }
            },
          ),
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0)),
      RaisedButton(

        onPressed: () async {
          var retorno = await PictureEditor.rotateImage(picture, 90);
          picutreStream.add(retorno);
        },
      )
    ],
  );
}

Widget containerEditableImage(
    StreamController picutreStream,
    Uint8List picture,
    double contrast,
    double brightness,
    Function setBrightness,
    Function setContrast,

    Function updatePicutre,
    Function uploadImageMedia,
    Function upload,

    ) {
  return Container(
    padding: EdgeInsets.only(top: 40),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: MaterialButton(
            height: 30,
            minWidth : 150,
            color: Colors.red,
            textColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical:10.0,horizontal: 2.0),
            //elevation: 20.0,
            //minWidth: MediaQuery.of(context).size.width/1.2,
            onPressed: (){
            },
            child: Text("Brightness",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0),
            ),
          ),
        ),
        Container(
            height: 400,
            width: 390,
            child: StreamBuilder(
              stream: picutreStream.stream,
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  return Image.memory(
                    snapshot.data,
                    gaplessPlayback: true,
                    fit: BoxFit.fitHeight,
                  );
                } else {
                  return Image.memory(
                    picture,
                    gaplessPlayback: true,
                    fit: BoxFit.contain,
                  );
                }
              },
            ),
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text("Contrast",),
                Container(
                  width: 350,
                  child: Slider(

                    label: 'Contrast',
                    min: 0,
                    max: 10,
                    activeColor: Colors.black,
                    inactiveColor: Colors.black54,
                    value: contrast,
                    onChanged: (valor) {
                      setContrast(valor);
                      updatePicutre(contrast, brightness);
                    },
                  ),
                ),
             SizedBox(height: 40,),
                Column(
                  children: <Widget>[
                    Text("Brightness",),
                    Container(
                      width: 350,
                      child: Slider(
                        label: 'Brightness',

                        min: 0,
                        max: 10,
                        activeColor: Colors.black,
                        inactiveColor: Colors.black54,
                        value: brightness,

                        onChanged: (valor) {

                            //bright = valor;
                          setBrightness(valor);
                          updatePicutre(contrast, brightness);
                        },
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
        SizedBox(height: 70,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MaterialButton(
              height: 30,
              minWidth : 150,
              color: Colors.black38,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical:10.0,horizontal: 2.0),
              //elevation: 20.0,
              //minWidth: MediaQuery.of(context).size.width/1.2,
              onPressed: () async {
                String  i = picutreStream.toString();
                String  j = picture.toString();

                print(i);
                print(j);
                final tempDir = await getTemporaryDirectory();
                fileimg = await new File('${tempDir.path}/image.jpg').create();
                fileimg.writeAsBytesSync(picture);
//                Image im = Image.memory(picture);
//
//                var bytes = await rootBundle.load('');
//                String tempPath = (await getTemporaryDirectory()).path;
//                File file = File('$tempPath/profile.png');
//                await file.writeAsBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
                upload(fileimg);
              // uploadImageMedia(fileimg,"msg.text","loc.text");
              },
              child: Text("Done",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15.0),
              ),
            ),
//            MaterialButton(
//              height: 30,
//              minWidth : 150,
//              color: Colors.black38,
//              textColor: Colors.white,
//              padding: EdgeInsets.symmetric(vertical:10.0,horizontal: 2.0),
//              //elevation: 20.0,
//              //minWidth: MediaQuery.of(context).size.width/1.2,
//              onPressed: (){
//              },
//              child: Text("Discard",
//                style: TextStyle(
//                  fontSize: 20.0,
//                  color: Colors.white,
//                ),
//              ),
//              shape: new RoundedRectangleBorder(
//                borderRadius: new BorderRadius.circular(15.0),
//              ),
//            ),
          ],
        )
      ],
    ),
  );
}