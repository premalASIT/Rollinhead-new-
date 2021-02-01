import 'package:flutter/material.dart';
import 'package:rollinhead/TreeConceptR/DisplayTreeNodeStory.dart';

class TreeConcept extends StatefulWidget {
  final String userImageUrl;
  final String userStoryName;
  final String nodeCount;
  final String userTreeId;
  TreeConcept({this.userImageUrl,this.userStoryName,this.nodeCount,this.userTreeId});
  @override
  _TreeConceptState createState() => _TreeConceptState(userImageUrl,userStoryName,nodeCount,userTreeId);
}

class _TreeConceptState extends State<TreeConcept> {
   String userImageUrl;
   String userStoryName;
   String nodeCount;
   String userTreeId;
   _TreeConceptState(this.userImageUrl,this.userStoryName,this.nodeCount,this.userTreeId);

   separateStringName(int number){
     final tagName = userStoryName;
     final split = tagName.split(',');
     final Map<int, String> values = {
       for (int i = 0; i < split.length; i++)
         i: split[i]
     };
     print(values);  // {0: grubs, 1:  sheep}

     return values[number];
     // final value1 = values[0];
     // final value2 = values[1];
     // final value3 = values[2];
     //
     // print(value1);  // grubs
     // print(value2);  //  sheep
     // print(value3);
   }

   @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Tree Post',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),),
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            child: Icon(Icons.arrow_back, color:Colors.black, size: 24),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assests/images/tree.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                nodeCount=="1" || nodeCount=="2" || nodeCount=="3" || nodeCount=="4" || nodeCount=="5"?Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => DisplayTreeNodeStory(id: userTreeId,nodeNumber: "1",)));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(userImageUrl,
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(separateStringName(0),
                      style:
                      TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
                    ),
                  ],
                ):Container(),
                nodeCount=="2" || nodeCount=="3" || nodeCount=="4" || nodeCount=="5"?Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => DisplayTreeNodeStory(id: userTreeId,nodeNumber: "2",)));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(userImageUrl,
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(separateStringName(1),
                      style:
                      TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
                    ),
                  ],
                ):Container(),
              ],
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                 nodeCount=="3" || nodeCount=="4" || nodeCount=="5"?Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => DisplayTreeNodeStory(id: userTreeId,nodeNumber: "3",)));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(userImageUrl,
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(separateStringName(2),
                      style:
                      TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
                    ),
                  ],
                ):Container(),
                nodeCount=="4" || nodeCount=="5"?Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => DisplayTreeNodeStory(id: userTreeId,nodeNumber: "4",)));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(userImageUrl,
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(separateStringName(3),
                      style:
                      TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
                    ),
                  ],
                ):Container(),
              ],
            ),
            SizedBox(height: 80,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                nodeCount=="5"?Column(
                  children: [
                    Center(
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => DisplayTreeNodeStory(id: userTreeId,nodeNumber: "5",)));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(userImageUrl,
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(separateStringName(4),
                      style:
                      TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
                    ),
                  ],
                ):Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}