import 'package:flutter/material.dart';
import 'package:rollinhead/diarypage.dart';

class DiaryPageD2 extends StatefulWidget {
  @override
  _DiaryPageD2State createState() => _DiaryPageD2State();
}

class _DiaryPageD2State extends State<DiaryPageD2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        leading: Padding(
          padding: const EdgeInsets.only(left:8.0,top: 4,bottom: 4),
          child: ClipRRect(

            borderRadius: BorderRadius.circular(40),
            child: Image.asset("assests/images/1.jpg",
              height: 80,
              width: 80,
              fit: BoxFit.fill,
            ),
          ),
        ),
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
      body: Container(
        color: Colors.yellow,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:36),
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Diarypage()));
                  },
                  child: Image.asset("assests/images/everyday.png",
                  height: 200,
                    width: 200,
                  ),
                ),
              ),

              IconButton(icon: Icon(Icons.keyboard_backspace),iconSize: 50,
              onPressed: (){
                Navigator.pop(context,true);
              },
              ),
            ],
          )
        ),
      ),
    );
  }
}
