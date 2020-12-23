import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),

      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: (){
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => FeedPage()));
            },

            title:Text("App Updates",
              style: TextStyle(
                fontSize: 19.0,
              ),),
          ),
          ListTile(
            onTap: (){
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => FeedPage()));
            },

            title:Text("Data Policy",
              style: TextStyle(
                fontSize: 19.0,
              ),),
          ),
          ListTile(
            onTap: (){
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => FeedPage()));
            },

            title:Text("terms of Use",
              style: TextStyle(
                fontSize: 19.0,
              ),),
          ),
        ],
      ),
    );
  }
}
