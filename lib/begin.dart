import 'package:flutter/material.dart';
import 'package:rollinhead/startpage.dart';

void main() {
  runApp(Begin());
}

class Begin extends StatefulWidget {
  @override
  _BeginState createState() => _BeginState();
}

class _BeginState extends State<Begin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 750,
          width: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assests/images/first.png",
              ),
            ),
          ),
        child: Column(
          children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 528.0),
            child: ClipRect(

              child: SizedBox(
                height: 50,
                width: 170,
                child: new  RaisedButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Startpage()));
                  },

                child: Text("lets go"),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  ),

              ),
            ),
          ),
          ],
        ),




        ),
      ),

    );
  }
}
