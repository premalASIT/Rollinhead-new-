import 'package:flutter/material.dart';
import 'package:rollinhead/FriendRequest.dart';
import 'package:rollinhead/Postcreaate.dart';
import 'package:rollinhead/diarypage.dart';
import 'package:rollinhead/discoverfeed.dart';
import 'package:rollinhead/editprofile.dart';
import 'package:rollinhead/feedspage.dart';
import 'package:rollinhead/listchats.dart';
import 'package:rollinhead/post.dart';
import 'package:rollinhead/profileinfo.dart';
import 'package:rollinhead/profilepage.dart';
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  int _index = 0;
  final List<Widget> _children =[
    // Newhome(),
    // Cartpage(),
    // Profilepage(),
        // More(),
         FeedPage(),
    Friendrequest(),
         // Post(),
        // Editprofile(),
        CreatePosts(),
        Discoverfeed(),
        Profilepage(),
    ];

  @override

    Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
      // backgroundColor:Color(0xff9f75bd),
      iconSize: 30.0,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      currentIndex: _index,

    onTap: (int index) => setState(() => _index = index),
    items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.black,size: 40,), title: Text('',style: TextStyle(fontSize: 0),)),
        BottomNavigationBarItem(icon: Icon(Icons.star_border,color: Colors.black,size: 40,), title: Text('',style: TextStyle(fontSize: 0),)),
        BottomNavigationBarItem(icon: Icon(Icons.change_history,color: Colors.black,size: 40,), title: Text('',style: TextStyle(fontSize: 0),)),
        BottomNavigationBarItem(icon: Icon(Icons.search,color: Colors.black,size: 40,), title: Text('',style: TextStyle(fontSize: 0),)),
        BottomNavigationBarItem(icon: Icon(Icons.person,color: Colors.black,size: 40,), title: Text('',style: TextStyle(fontSize: 0),)),
    ],
    ),
body: _children[_index],
    );
  }
}
