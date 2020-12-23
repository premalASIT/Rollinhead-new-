import 'package:flutter/material.dart';
import 'package:rollinhead/changepassword.dart';
import 'package:rollinhead/deleteaccount.dart';

class AccountSetting extends StatefulWidget {
  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      body:
       ListView(
          children: <Widget>[
            ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ChangePassword()));
              },
              leading:Icon(
                Icons.lock,
                color: Colors.black,
                size: 40.0,
              ),
              title:Text("Password",
                style: TextStyle(
                  fontSize: 19.0,
                ),),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => DeleteAccount()));
              },
              leading:Icon(
                Icons.account_circle,
                color: Colors.black,
                size: 40.0,
              ),
              title:Text("Delete Account",
                style: TextStyle(
                  fontSize: 19.0,
                ),),
            ),
          ],
        ),

    );
  }
}
