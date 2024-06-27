import 'package:elderscareapp/startpage.dart';
import 'package:elderscareapp/welcome3.dart';
import 'package:flutter/material.dart';

class welcometwo extends StatefulWidget {
  const welcometwo({super.key});

  @override
  State<welcometwo> createState() => _doctorState();
}

class _doctorState extends State<welcometwo> {
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context)
    {
      // Access MediaQuery here
      final mediaQuery = MediaQuery.of(context);
      return MaterialApp(debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(children: [
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    color: Colors.yellow,
                    child: Image.asset(
                      "assets/images/w2.jpg", fit: BoxFit.cover,),
                  ),
                  Positioned(
                    top: 550,
                    child: Container(
                      width: 450, height: 310,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        // Adjust opacity as needed
                        // width: double.infinity,
                        // height: double.infinity,
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the radius to your preference
                      ),
                      child: Column(children: [
                        SizedBox(height: 45,),
                        Text("Order your medicine and",
                          style: TextStyle(color: Colors.black, fontSize: 30),),
                        Text("Grocery",
                          style: TextStyle(color: Colors.black, fontSize: 30),),

                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Column(children: [SizedBox(width: 30,),

                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => welcomethree(),
                                  ),
                                  );
                                },
                                child: Text("NEXT",
                                  style: TextStyle(color: Colors.white),),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10)),)),


                            SizedBox(height: 10,),
                            TextButton(onPressed: () {
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => start(),
                                ),
                              );
                            },
                                child: Text("skip", style: TextStyle(
                                    color: Colors.black, fontSize: 20),)),


                            SizedBox(height: 30,),
                            Padding(
                              padding: const EdgeInsets.only(left: 175),
                              child: Row(children: [
                                Container(width: 30, height: 5,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        10), // Adjust the radius to your preference
                                  ),
                                ), SizedBox(width: 5,),
                                Container(width: 30, height: 5,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(
                                        10), // Adjust the radius to your preference
                                  ),
                                ), SizedBox(width: 5,),
                                Container(width: 30, height: 5,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        10), // Adjust the radius to your preference
                                  ),
                                ), SizedBox(width: 150,),
                              ],),
                            )
                          ],),
                        ),

                      ],),
                    ),)
                ],)


              ],
            ),
          ),
        ),
      );
    }
      );
  }
}
