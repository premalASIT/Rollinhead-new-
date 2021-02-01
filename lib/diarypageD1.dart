import 'package:flutter/material.dart';
import 'package:rollinhead/SeeFriendStory.dart';
import 'package:rollinhead/SeePublicStory.dart';
import 'package:rollinhead/diarypageD2.dart';

class Diarypaged1 extends StatefulWidget {
  @override
  _Diarypaged1State createState() => _Diarypaged1State();
}

class _Diarypaged1State extends State<Diarypaged1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading:     Padding(
        //   padding: const EdgeInsets.only(left:8.0),
        //   child: ClipRRect(
        //
        //     borderRadius: BorderRadius.circular(160),
        //     child: Image.asset("assests/images/1.jpg",
        //       height: 35,
        //       width: 35,
        //     ),
        //   ),
        // ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right:38.0),
            child: Image.asset("assests/images/dairy.png",
              height: 95,
              width: 95,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => DiaryPageD2()));
                      },
                      child: Image.asset("assests/images/add-creativitty.png",
                      height: 250,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => FriendStory()));
                      },
                      child: Image.asset("assests/images/youknow.png",
                      height:250,
                    ),),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Publicstory()));
                },
                child: Image.asset('assests/images/youwant.png',
                height: 250,
                  width: 380,
                ),
              ),
              SizedBox(height: 80,),
             Image.asset("assests/images/becreative.png",
                  ),

            ],
          ),
        ),
      ),
    );
  }
}
