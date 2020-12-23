import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rollinhead/Model/accountDeleting/FinalDelete.dart';
import 'package:rollinhead/begin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAccount extends StatefulWidget {
  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final FormKey = new GlobalKey<FormState>();
  bool _isLoading = false;
  FinalDelete delete;
  TextEditingController pass = new TextEditingController();
  Deletes(String passw) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String user =sharedPreferences.getString('user_Id');
    Map data = {

      'UserId': user,
      'Password': passw,
    };
    var response = await http.post("http://rolinhead.dolphinfiresafety.com/registration/DeleteAccount", body: data);
    delete = new FinalDelete.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (delete.status.code==200) {
        setState(() {
          _isLoading = false;
        });

        print(response.body);
        print("done2");
        print("done");
        Fluttertoast.showToast(
            msg: delete.status.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 10
        );
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (BuildContext context) => Begin()), (
            Route<dynamic> route) => false);
      }
      else{
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: delete.status.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
        print(response.body);
      }
    }else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Account'),
      ),
      body: Form(
        key: FormKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:48.0,right: 48.0,top: 30.0,bottom: 10.0,),
              child: TextFormField(
                autocorrect: true,
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(

                  hintText: 'PASSWORD',
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
                child: Text("Delete",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.deepOrange,
                  ),),
                onPressed: (){
                  final form = FormKey.currentState;
                  if (form.validate()) {
                    setState(() {
                      _isLoading = true;
                    });

                      Deletes(pass.text);

                  }
                  // loginpass(user.text,pass.text);
                  // Sendotp(user.text);
//                Navigator.of(context).push(MaterialPageRoute(
//                    builder: (BuildContext context) => Profilepic()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

