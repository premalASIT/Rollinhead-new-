import 'package:flutter/material.dart';

import 'package:rollinhead/Model/PublicDiary/PublicDiaryApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Publicstory extends StatefulWidget {
  @override
  _PublicstoryState createState() => _PublicstoryState();
}

class _PublicstoryState extends State<Publicstory> {
  static int page = 0;
  ScrollController _sc = new ScrollController();
  var finaldate = "";
  bool _isLoading = false;
  int flag = 0;
  String listdata = "";
  int max = 3;
  List users = new List();

  @override
  void initState() {
    // this._getMoreData(max);
     super.initState();
    // _sc.addListener(() {
    //   print("pixel" + _sc.position.pixels.toString());
    //   print("position"+_sc.position.maxScrollExtent.toString());
    //   if(finaldate != ""){
    //   if (_sc.position.pixels ==
    //       _sc.position.maxScrollExtent) {
    //     print('inside');
    //     print('000----000----000');
    //      max += 2;
    //      print('111----000----111');
    //      _getMoreData(max);
    //      _buildList();
    //      print('222----000----222');
    //    }
    //   }
    // });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

 // var myFormat = DateFormat('d-MM-yyyy');
  void callDatePicker() async {
    var order = await getDate();
    setState(() {
      flag = 1;

      finaldate = "${order.day}-${order.month}-${order.year}";

      print(finaldate);
      _isLoading = true;
    });
    fetchdiary();
  }
  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2030),

      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }
  PublicDiaryApi pdiary;


  // @override
  // void initState() {
  //   pagination();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        // leading: Padding(
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
        body:_isLoading
            ? Center(child: CircularProgressIndicator())
            :
        // Column(
        //   children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: MaterialButton(
            //     height: 40,
            //     color: Colors.red,
            //     textColor: Colors.white,
            //     padding: EdgeInsets.symmetric(vertical:10.0,horizontal: 2.0),
            //     elevation: 10.0,
            //     minWidth: MediaQuery.of(context).size.width/1.7,
            //     onPressed: callDatePicker,
            //     child: Text("Select Date",
            //
            //       style: TextStyle(
            //         fontSize: 20.0,
            //         color: Colors.white,
            //       ),
            //     ),
            //     shape: new RoundedRectangleBorder(
            //       borderRadius: new BorderRadius.circular(30.0),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //
            //     padding: EdgeInsets.symmetric(horizontal: 30.0),
            //     child: finaldate == null
            //         ? Text(
            //       "Use below button for select Date ",
            //       style: TextStyle(
            //         fontSize: 15.0,
            //       ),
            //     )
            //         : Text(
            //       "$finaldate",
            //       textScaleFactor: 1.5,
            //     ),
            //   ),
            //
          Container(child : flag==1 ?
          pdiary.response.length > 0 ?
          ListView.builder(
            itemCount: pdiary.response.length, // Add one more item for progress indicator
            padding: EdgeInsets.symmetric(vertical: 8.0),
            itemBuilder: (BuildContext context, int index) {
              // if (index == users.length) {
              //   return _buildProgressIndicator();
              // }
              // else

              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child:pdiary.response[index].imagePath != ""?  Image.network(
                      pdiary.response[index].imagePath,
                      height: 300.0,
                      width: 350.0,

                    ):
                    Image.asset("assests/images/rhead.png",
                      height: 300,
                      width: 350,
                    ),
                  ),

                  Text(pdiary.response[index].content,
                    style: TextStyle(
                      fontSize: 18,
                    ),),
                  Divider(),
                ],

              );


            },

          ):Text('No data available')
          // ListView.builder(
          // itemCount: max+1, // Add one more item for progress indicator
          //   padding: EdgeInsets.symmetric(vertical: 8.0),
          //   itemBuilder: (BuildContext context, int index) {
          //     if (index == max) {
          //
          //       // _increment();
          //       return _buildProgressIndicator();
          //     } else {
          //       return Column(
          //         children: [
          //           ClipRRect(
          //             borderRadius: BorderRadius.circular(8.0),
          //             child: Image.network(
          //               users[index].imagePath,
          //               height: 300.0,
          //               width: 350.0,
          //             ),
          //           ),
          //
          //           Text(users[index].content,
          //             style: TextStyle(
          //               fontSize: 18,
          //             ),),
          //           Divider(),
          //         ],
          //
          //       );
          //     }
          //   },
          //   controller: _sc,
          // )
         :
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        alignment: Alignment.topCenter,
        child: MaterialButton(
          height: 40,
          color: Colors.red,
          textColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical:10.0,horizontal: 2.0),
          elevation: 10.0,
          minWidth: MediaQuery.of(context).size.width/1.7,
          onPressed: callDatePicker,
          child: Text("Select Date",

            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),
      ),
    ),
          ),


      //     ],
      //
      // ),
      resizeToAvoidBottomPadding: false,
        // _isLoading ? Center(child: CircularProgressIndicator()) :
    //     SingleChildScrollView(
    //       child: Column(
    //         children: [
    //
    //           Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: MaterialButton(
    //               height: 40,
    //               color: Colors.red,
    //               textColor: Colors.white,
    //               padding: EdgeInsets.symmetric(vertical:10.0,horizontal: 2.0),
    //               elevation: 10.0,
    //               minWidth: MediaQuery.of(context).size.width/1.7,
    //               onPressed: callDatePicker,
    //               child: Text("Select Date",
    //                 style: TextStyle(
    //                   fontSize: 20.0,
    //                   color: Colors.white,
    //                 ),
    //               ),
    //               shape: new RoundedRectangleBorder(
    //                 borderRadius: new BorderRadius.circular(30.0),
    //               ),
    //             ),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Container(
    //
    //               padding: EdgeInsets.symmetric(horizontal: 30.0),
    //               child: finaldate == null
    //                   ? Text(
    //                 "Use below button for select Date ",
    //                 style: TextStyle(
    //                   fontSize: 15.0,
    //                 ),
    //               )
    //                   : Text(
    //                 "$finaldate",
    //                 textScaleFactor: 1.5,
    //               ),
    //             ),
    //           ),
    //      flag!=0 ?   ListView.builder(
    //
    //       shrinkWrap: true,
    //       primary: false,
    //       itemCount:pdiary.response.length,
    //       itemBuilder: (BuildContext context, int index) {
    //
    //         print(index);
    //
    //   //  _n[index] = int.parse(mycartListApi.cart[index].Quantity);
    //   //print(_n);
    //      return Column(
    //             children: [
    //               ClipRRect(
    //                 borderRadius: BorderRadius.circular(8.0),
    //                 child: Image.network(
    //                   pdiary.response[index].imagePath,
    //                   height: 300.0,
    //                   width: 350.0,
    //                 ),
    //               ),
    //
    //               Text(pdiary.response[index].content,
    //               style: TextStyle(
    //                 fontSize: 18,
    //               ),),
    //               Divider(),
    //             ],
    //
    //   );
    // }
    //      ):
    //          Container(),
    //         ],
    //       ),
    //     ),
    );
  }
//  Widget _buildList() {
//
//  }

   Future fetchdiary() async  {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String userId =prefs.getString('user_Id');
   int cusId = int.parse(userId);
   int count = max;
   Map data = {
     'start': "0",
     'date': finaldate.toString(),
     'limit': "100"
   };
   final response = await http.post(
       'http://rolinhead.dolphinfiresafety.com/registration/getAllPublicDiary',body: data
   );
   pdiary= new PublicDiaryApi.fromJsonMap(json.decode(response.body.toString()));
   // await new Future.delayed(const Duration(seconds: 2));
   if(response.statusCode == 200) {
     if (pdiary.status.code==200) {
       setState(() {
         _isLoading = false;

       });

       print(response.body);
     }
     else{
       setState(() {
         _isLoading = false;
       });
       print(response.body);
     }
   }else {
     setState(() {
       _isLoading = false;
     });
     print(response.body);
   }
 }


}
