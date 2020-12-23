import 'package:flutter/material.dart';
import 'package:rollinhead/blockedusers.dart';
import 'package:rollinhead/mutedusers.dart';

class PrivacySettings extends StatefulWidget {
  @override
  _PrivacySettingsState createState() => _PrivacySettingsState();
}

class _PrivacySettingsState extends State<PrivacySettings> {
  bool isSwitched =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy',
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
            Padding(
              padding: const EdgeInsets.only(top:14.0,left:24,right:48),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Private',
                      style: TextStyle(
                        fontSize: 22.0,
                      )
                  ),
                  Switch(
                    value: isSwitched,

                    onChanged: (value){
                      print(value);
                      setState(() {
                        isSwitched=value;
                        print(isSwitched);
                      });
                    },
                    activeTrackColor: Colors.red,
                    activeColor: Colors.red,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Center(
              child: Text('Connections',
                  style : TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  )
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => BlockedUser()));
              },

              title:Text("Blocked Accounts",
                style: TextStyle(
                  fontSize: 19.0,
                ),),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MutedAccounts()));
              },

              title:Text("Muted Account",
                style: TextStyle(
                  fontSize: 19.0,
                ),),
            ),
          ],
        ),

    );
  }
}
