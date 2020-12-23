import 'package:flutter/material.dart';

class DiaryPageD3 extends StatefulWidget {
  @override
  _DiaryPageD3State createState() => _DiaryPageD3State();
}

class _DiaryPageD3State extends State<DiaryPageD3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left:8.0),
          child: ClipRRect(

            borderRadius: BorderRadius.circular(160),
            child: Image.asset("assests/images/1.jpg",
              height: 35,
              width: 35,
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

    );
  }
}
