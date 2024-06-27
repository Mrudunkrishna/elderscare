import 'package:elderscareapp/registr/loginregstr.dart';
import 'package:elderscareapp/signup/signinsmll.dart';
import 'package:flutter/material.dart';

class start extends StatefulWidget {
  const start({Key? key});

  @override
  State<start> createState() => _StartState();
}

class _StartState extends State<start> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        final mediaQuery = MediaQuery.of(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: mediaQuery.size.height * 0.05),
                Image.asset(
                  "assets/images/2.png",
                  height: mediaQuery.size.height * 0.5,
                  width: mediaQuery.size.width * 0.6,
                ),
                SizedBox(height: mediaQuery.size.height * 0.05),
                Center(
                  child: Text(
                    "Welcome to Elder's Care",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Schyler',
                    ),
                  ),
                ),
                SizedBox(height: mediaQuery.size.height * 0.05),
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: mediaQuery.size.width * 0.6,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => loginreg(),
                              ),
                            );
                          },
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Schyler',
                              fontSize: 20,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.blueAccent[100],
                            side: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                      SizedBox(height: mediaQuery.size.height * 0.03),
                      Container(
                        width: mediaQuery.size.width * 0.6,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => signinsmll(),
                              ),
                            );
                          },
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Schyler',
                              fontSize: 20,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.blueAccent[100],
                            side: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
