import 'package:flutter/material.dart';


class Otherprofile extends StatefulWidget {
  @override
  _OtherprofileState createState() => _OtherprofileState();
}

class _OtherprofileState extends State<Otherprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile name"),
      ),
      body: SingleChildScrollView(
        child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                'assets/images/pic.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Profile Name"),
          ),
          Text("Caption",
          maxLines: 5,
          style: TextStyle(

          ) ),
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FlatButton(
                  child:Text("Following",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),

              ClipRRect(

                borderRadius: BorderRadius.circular(10),
                child: FlatButton(
                  child:Text("Message",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
         Row(
           children: <Widget>[
             Image.asset(
               'assets/images/pic.jpg',
               fit: BoxFit.cover,
             ),
             Image.asset(
               'assets/images/pic.jpg',
               fit: BoxFit.cover,
             ),
             Image.asset(
               'assets/images/pic.jpg',
               fit: BoxFit.cover,
             ),
           ],
         ),
          Row(
            children: <Widget>[
              Image.asset(
                'assets/images/pic.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/images/pic.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/images/pic.jpg',
                fit: BoxFit.cover,
              ),
            ],
          ),
        ],
        ),
      ),
    );
  }
}

