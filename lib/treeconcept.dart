import 'package:flutter/material.dart';

class TreeConcept extends StatefulWidget {
  @override
  _TreeConceptState createState() => _TreeConceptState();
}

class _TreeConceptState extends State<TreeConcept> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

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
            SizedBox(height: 80,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(550),
                  child: Image.asset("assests/images/avtar.png",
                  height: 100,
                  width: 100,
                  ),
                  ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(550),
                  child: Image.asset("assests/images/avtar.png",
                    height: 100,
                    width: 100,
                  ),
                ),
              ],
            ),
            SizedBox(height: 90,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(550),
                  child: Image.asset("assests/images/avtar.png",
                    height: 100,
                    width: 100,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(550),
                  child: Image.asset("assests/images/avtar.png",
                    height: 100,
                    width: 100,
                  ),
                ),
              ],
            ),
            SizedBox(height: 170,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(550),
                  child: Image.asset("assests/images/avtar.png",
                    height: 100,
                    width: 100,
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
// ClipRRect(
// borderRadius: BorderRadius.circular(550),
// child: Image.asset("assests/images/avtar.png",
// height: 80,
// width: 80,
// ),
// ),