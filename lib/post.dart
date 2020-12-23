import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rollinhead/editprofile.dart';
import 'package:rollinhead/profilepage.dart';
void main() {
  runApp(Post());
}

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child:Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.arrow_back,
                        size: 40,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(

                      alignment: Alignment.centerRight,
                      child: Text(
                        "Post",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 28,
                        ),

                      ),
                    ),
                  ),

                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assests/images/1.jpg",
                  fit: BoxFit.fill,
                  height: 400,
                  width: 300,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Caption",
//                textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLines: 3,
                  minLines: 1,
                  keyboardType: TextInputType.multiline,

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: ClipRect(

                  child: SizedBox(
                    height: 50,
                    width: 170,
                    child: new  RaisedButton(
                      color: Colors.black12,
                      onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => Profilepage()));
                      },

                      child: Text("Tag",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                    ),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRect(
                  child: SizedBox(
                    height: 50,
                    width: 190,
                    child: new  RaisedButton(
                      color: Colors.black12,
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Editprofile()));
                      },
                      child: Text("Add Your Place",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                    ),

                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
