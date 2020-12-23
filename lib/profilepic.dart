import 'package:flutter/material.dart';
import 'package:rollinhead/bio.dart';
void main() {
  runApp(Profilepic());
}


class Profilepic extends StatefulWidget {
  @override
  _ProfilepicState createState() => _ProfilepicState();
}

class _ProfilepicState extends State<Profilepic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:78.0,bottom: 30.0,),
              child: new Icon(Icons.add_a_photo,
                size: 150.0,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text("Add a Profile Photo",
              style: TextStyle(
                fontSize: 27.0,
                fontWeight: FontWeight.bold,
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,left: 65.0,right: 65.0,),
              child: Text("Add a Profile Picture so everyone can know it's you",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black26,
                ),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: ClipRect(
                child: SizedBox(
                  height: 50,
                  width: 270,

                  child: new  RaisedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => Bio()));
                    },

                    child: Text("Add a Photo",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
//                        backgroundColor: Colors.black12,
                      ),),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                    ),
                  ),

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 48.0,left: 48.0,top:12.0,),
              child: FlatButton(
                child: Text("Skip",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.deepOrange,
                  ),),
                onPressed: (){ Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Bio()));},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
