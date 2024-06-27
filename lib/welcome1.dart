import 'package:flutter/material.dart';
import 'package:elderscareapp/startpage.dart';
import 'package:elderscareapp/welcome2.dart';

class welcome extends StatefulWidget {
  const welcome({Key? key});

  @override
  State<welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        // Access MediaQuery here
        final mediaQuery = MediaQuery.of(context);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: mediaQuery.size.width,
                        height: mediaQuery.size.height,
                        color: Colors.yellow,
                        child: Image.asset(
                          "assets/images/w1.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 550,
                        child: Container(
                          width: 450,
                          height: 310,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 45,),
                              Text(
                                "Personalised Home care",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                ),
                              ),
                              Text(
                                "Services",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Column(
                                  children: [
                                    SizedBox(width: 30,),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => welcometwo(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "NEXT",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => start(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "skip",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 175),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 30,
                                            height: 5,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                          Container(
                                            width: 30,
                                            height: 5,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                          Container(
                                            width: 30,
                                            height: 5,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          SizedBox(width: 150,),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
