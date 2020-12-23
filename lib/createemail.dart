import 'package:flutter/material.dart';
import 'package:rollinhead/namepass.dart';

void main() {
  runApp(Createmail());
}

class Createmail extends StatefulWidget {
  @override
  _CreatemailState createState() => _CreatemailState();
}

class _CreatemailState extends State<Createmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: Padding(
          padding: const EdgeInsets.only(top:128.0,),
          child: Column(
            children: <Widget>[
              Text("ENTER CONFIRMATION CODE",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),),
              Padding(
                padding: const EdgeInsets.only(top:18.0,left: 40.0,right: 40.0,),
                child: Text("Enter 6 digit code we sent to your Registration Email Address.",
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black26,
                  ),),
              ),
              FlatButton(
                child: Text("Request a New One"),
              ),
              Padding(
                padding: const EdgeInsets.only(left:48.0,right: 48.0,),
                child: TextField(
                  autocorrect: true,
                  decoration: InputDecoration(
                    hintText: 'Code',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.black12,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.black26, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.black26),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 48.0,left: 48.0,top: 20.0,),
                child: FlatButton(
                  child: Text("Next",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.deepOrange,
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
    );
  }
}
