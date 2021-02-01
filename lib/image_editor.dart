import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:extended_image/extended_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
// import 'package:flutter_image_editor/saveScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_editor/image_editor.dart' hide ImageSource;
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:photofilters/widgets/photo_filter.dart';
import 'package:image/image.dart' as imageLib;
import 'package:rollinhead/homepage.dart';
import 'package:rollinhead/postdata.dart';
class EditPhotoScreen extends StatefulWidget {
  final List arguments;
  EditPhotoScreen({this.arguments});
  @override
  _EditPhotoScreenState createState() => _EditPhotoScreenState();
}

class _EditPhotoScreenState extends State<EditPhotoScreen> {
  final GlobalKey<ExtendedImageEditorState> editorKey =
  GlobalKey<ExtendedImageEditorState>();
  bool  _isLoading = false;
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
  double sat = 1;
  double bright = 0;
  double con = 1;
  String fileName;
  List<Filter> filters = presetFiltersList;
  final defaultColorMatrix = const <double>[
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0
  ];
  List<double> calculateSaturationMatrix(double saturation) {
    final m = List<double>.from(defaultColorMatrix);
    final invSat = 1 - saturation;
    final R = 0.213 * invSat;
    final G = 0.715 * invSat;
    final B = 0.072 * invSat;

    m[0] = R + saturation;
    m[1] = G;
    m[2] = B;
    m[5] = R;
    m[6] = G + saturation;
    m[7] = B;
    m[10] = R;
    m[11] = G;
    m[12] = B + saturation;

    return m;
  }

  List<double> calculateContrastMatrix(double contrast) {
    final m = List<double>.from(defaultColorMatrix);
    m[0] = contrast;
    m[6] = contrast;
    m[12] = contrast;
    return m;
  }
  void upload(File f){

    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => PostData(img : f)));
  }
  File image;
  int  flag = 0;
  @override
  void initState() {
    super.initState();
    image = widget.arguments[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
          title: Text(
            "Edit Image",
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings_backup_restore),
              onPressed: () {
                setState(() {
                  sat = 1;
                  bright = 0;
                  con = 1;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () async {
                await crop();
              },
            ),
          ]),
      body: Container(
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: buildImage(),
            ),
            Expanded(
              child: SliderTheme(
                data: const SliderThemeData(
                  showValueIndicator: ShowValueIndicator.never,
                ),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Spacer(flex: 3),
                      _buildSat(),
                      Spacer(flex: 1),
                      _buildBrightness(),
                      Spacer(flex: 1),
                      _buildCon(),
                      Spacer(flex: 3),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildFunctions(),
    );
  }

  Widget buildImage() {
    return ColorFiltered(
      colorFilter: ColorFilter.matrix(calculateContrastMatrix(con)),
      child: ColorFiltered(
        colorFilter: ColorFilter.matrix(calculateSaturationMatrix(sat)),
        child: ExtendedImage(
          color: bright > 0
              ? Colors.white.withOpacity(bright)
              : Colors.black.withOpacity(-bright),
          colorBlendMode: bright > 0 ? BlendMode.lighten : BlendMode.darken,
          image: ExtendedFileImageProvider(image),
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          extendedImageEditorKey: editorKey,
          mode: ExtendedImageMode.editor,
          fit: BoxFit.contain,
          initEditorConfigHandler: (ExtendedImageState state) {
            return EditorConfig(
              maxScale: 8.0,
              cropRectPadding: const EdgeInsets.all(20.0),
              hitTestSize: 20.0,
            );
          },
        ),
      ),
    );
  }

  Widget _buildFunctions() {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.flip,
            color: Colors.black,
          ),
          title: Text(
            'Flip',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.rotate_left,
            color: Colors.black,
          ),
          title: Text(
            'Rotate left',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.rotate_right,
            color: Colors.black,
          ),
          title: Text(
            'Rotate right',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
      onTap: (int index) {
        switch (index) {
          case 0:
            flip();
            break;
          case 1:
            rotate(false);
            break;
          case 2:
            rotate(true);
            break;
        }
      },
      currentIndex: 0,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).primaryColor,
    );
  }

  Future<void> crop([bool test = false]) async {
    final ExtendedImageEditorState state = editorKey.currentState;
    final Rect rect = state.getCropRect();
    final EditActionDetails action = state.editAction;
    final double radian = action.rotateAngle;

    final bool flipHorizontal = action.flipY;
    final bool flipVertical = action.flipX;
    final Uint8List img = state.rawImageData;

    final ImageEditorOption option = ImageEditorOption();

    option.addOption(ClipOption.fromRect(rect));
    option.addOption(
        FlipOption(horizontal: flipHorizontal, vertical: flipVertical));
    if (action.hasRotateAngle) {
      option.addOption(RotateOption(radian.toInt()));
    }

    option.addOption(ColorOption.saturation(sat));
    option.addOption(ColorOption.brightness(bright + 1));
    option.addOption(ColorOption.contrast(con));

    option.outputFormat = const OutputFormat.jpeg(100);

    print(const JsonEncoder.withIndent('  ').convert(option.toJson()));

    final DateTime start = DateTime.now();
    final Uint8List result = await ImageEditor.editImage(
      image: img,
      imageEditorOption: option,
    );

    print('result.length = ${result.length}');

    final Duration diff = DateTime.now().difference(start);
    image.writeAsBytesSync(result);
    print('image_editor time : $diff');
    fileName = image.path.split('/').last;
      var image1 = imageLib.decodeImage(image.readAsBytesSync());
      image1 = imageLib.copyResize(image1, width: 600);

      Map imagefile = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) =>
          new PhotoFilterSelector(
            appBarColor: Colors.white,
            title: Text("Post"),
            image: image1,
            filters: presetFiltersList,
            filename: fileName,
            loader: Center(child: CircularProgressIndicator()),
            fit: BoxFit.contain,
          ),
        ),
      );
      print('FDONE');
    String xy = imagefile['image_filtered'].toString();
    if(xy.contains('Inkwell')){
      print('find');
      flag = 1;
    }else{
      print('not present');
      flag = 2;
    }
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      print('in the if of filter');
      print(imagefile['image_filtered']);

      if(imagefile.containsKey('image_filtered')) {
        print('xx');
        if(flag==1) {
          setState(()  {
            image = imagefile['image_filtered'];

          });
        }else{
          setState(()  {
            image = imagefile['image_filtered'];

          });
          print('else set state of _img file');
        }
      }
      print('----');

      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => PostData(img : image)));
      // upload(image);
      print(image.path);
    }
    else if(imagefile == null){

    }
    // Future.delayed(Duration(seconds: 0)).then(
    //       (value) => Navigator.pushReplacement(
    //     context,
    //     CupertinoPageRoute(
    //         builder: (context) => SaveImageScreen(
    //           arguments: [image],
    //         )),
    //   ),
    // );
  }

  void flip() {
    editorKey.currentState.flip();
  }

  void rotate(bool right) {
    editorKey.currentState.rotate(right: right);
  }

  Widget _buildSat() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        Column(
          children: <Widget>[
            Icon(
              Icons.brush,
              color: Theme.of(context).accentColor,
            ),
            Text(
              "Saturation",
              style: TextStyle(color: Theme.of(context).accentColor),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Slider(
            label: 'sat : ${sat.toStringAsFixed(2)}',
            onChanged: (double value) {
              setState(() {
                sat = value;
              });
            },
            divisions: 50,
            value: sat,
            min: 0,
            max: 2,
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.08),
          child: Text(sat.toStringAsFixed(2)),
        ),
      ],
    );
  }

  Widget _buildBrightness() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        Column(
          children: <Widget>[
            Icon(
              Icons.brightness_4,
              color: Theme.of(context).accentColor,
            ),
            Text(
              "Brightness",
              style: TextStyle(color: Theme.of(context).accentColor),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Slider(
            label: '${bright.toStringAsFixed(2)}',
            onChanged: (double value) {
              setState(() {
                bright = value;
              });
            },
            divisions: 50,
            value: bright,
            min: -1,
            max: 1,
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.08),
          child: Text(bright.toStringAsFixed(2)),
        ),
      ],
    );
  }

  Widget _buildCon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        Column(
          children: <Widget>[
            Icon(
              Icons.color_lens,
              color: Theme.of(context).accentColor,
            ),
            Text(
              "Contrast",
              style: TextStyle(color: Theme.of(context).accentColor),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Slider(
            label: 'con : ${con.toStringAsFixed(2)}',
            onChanged: (double value) {
              setState(() {
                con = value;
              });
            },
            divisions: 50,
            value: con,
            min: 0,
            max: 4,
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.08),
          child: Text(con.toStringAsFixed(2)),
        ),
      ],
    );
  }
}