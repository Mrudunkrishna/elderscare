import 'package:elderscareapp/admin/healthtips/addhlthbelow.dart';
import 'package:elderscareapp/admin/healthtips/hlthtipsabove.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class addhere extends StatefulWidget {
  const addhere({super.key});

  @override
  State<addhere> createState() => _addhealthState();
}

class _addhealthState extends State<addhere> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: Text("Add Health tips Here"),
      ),
      body: Column(
        children: [

          SizedBox(height: 70,),

          Lottie.asset(
            "assets/images/healthh.json",
            height: 70,
            width: 150,
            fit: BoxFit.cover,),


          SizedBox(height: 115,),
          Center(
            child: Container(
              height: 150,
              width: 380,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(20), // Adjust the radius value as needed
              ),
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Text("Add health tip for people above 75",style: TextStyle(fontSize: 25,fontFamily: 'Schyler'),),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => addhealth(),));
                    },
                    child: const Text('Add',style: TextStyle(color: Colors.white
                        ,fontFamily: 'Schyler',fontSize: 25),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent[100],side: BorderSide(color: Colors.green)
                    ),
                  ),
                ],
              ),
            ),
          ),





          SizedBox(height: 25,),
          Center(
            child: Container(
              height: 150,
              width: 380,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(20), // Adjust the radius value as needed
              ),
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Text("Add health tip for people below 75",style: TextStyle(fontSize: 25,fontFamily: 'Schyler'),),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => belowadd(),));
                    },
                    child: const Text('Add',style: TextStyle(color: Colors.white
                        ,fontFamily: 'Schyler',fontSize: 25),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent[100],side: BorderSide(color: Colors.green)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
