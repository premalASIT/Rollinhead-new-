import 'package:flutter/material.dart';
import 'package:rollinhead/createacc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rollinhead/namepass.dart';
void main() {
  runApp(Startpage());
}
class Startpage extends StatefulWidget {
  @override
  _StartpageState createState() => _StartpageState();
}

class _StartpageState extends State<Startpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(

          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:308.0),
                child: new Image.asset("assests/images/rhead.png",
                width: 280,
                ),
//                child: Text("Rollinhead",
//                style: GoogleFonts.pacifico(textStyle:
//                  TextStyle(
//                  fontSize: 42.0,
//                  color: Colors.red,
//                ),
//                ),
//
//                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:35.0),
                child: ClipRect(

                  child: SizedBox(
                    height: 50,
                    width: 270,

                    child: new  RaisedButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => CreateAcc1()));
                      },

                      child: Text("Create New Account",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
//                        backgroundColor: Colors.black12,
                      ),),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                    ),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(01.0),
                child: FlatButton(

                  child: Text("Log In",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black45,
                  ),),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Namepass()));
                  },
                ),
              ),
            ],
          ),

        ),
      ),
        persistentFooterButtons: <Widget>[
       Padding(
      padding: const EdgeInsets.only(right:0140.0),

        child: Text("Love from India",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.bold,
        ),),

    ),
    ],
    );
  }
}
