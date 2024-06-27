import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderscareapp/home/aboutus.dart';
import 'package:elderscareapp/home/chatuser.dart';
import 'package:elderscareapp/home/contactsupport/contactsupport.dart';
import 'package:elderscareapp/home/gethelp.dart';
import 'package:elderscareapp/home/grocery/grocerydetails.dart';
import 'package:elderscareapp/home/home2.dart';
import 'package:elderscareapp/home/home3.dart';
import 'package:elderscareapp/home/home4.dart';
import 'package:elderscareapp/home/medicines/medicinedetails.dart';
import 'package:elderscareapp/home/caretaker/viewcaretaker.dart';
import 'package:elderscareapp/home/notification.dart';
import 'package:elderscareapp/home/sharedpreference.dart';
import 'package:elderscareapp/signup/signinsmll.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  bool _showImages = false;
  bool showimages = false;
  User? _currentUser;
  Map<String, dynamic>? _userData;



  @override

  void initstate(){
    super.initState();
    _fetchUser();
  }



  void _fetchUser() async {
    _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(_currentUser!.uid)
          .get();
      setState(() {
        _userData = userDoc.data() as Map<String, dynamic>?;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        automaticallyImplyLeading: false, // Remove back button
        actions: [
          Row(children: [

            Padding(
              padding: const EdgeInsets.only(left: 20,right: 40),
              child: Text("Welcome to Elder's Care",style: TextStyle(fontSize: 20),),
            ),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreenuser(),));
            }, icon: Icon(Icons.chat)),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => GetHelpPage(),));
            }, icon: Icon(Icons.help_outline)),
          ],),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu,color: Colors.black,),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),





      drawer: Drawer(
        child: Container(color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(height: 250,
                child: DrawerHeader(
                    decoration: BoxDecoration(
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Image.asset("assets/images/logoofelders.png",width: 170,height: 160,),
                        ),
                      ],
                    )
                ),
              ),
              SizedBox(height: 35,),
              SizedBox(height: 40,
                child: ListTile(
                  onTap: () {
                    // Add functionality for Item 1
                  },
                  title: Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserNotificationViewPage(),));
                      }, icon: Lottie.asset("assets/images/mani.json")),
                      SizedBox(width: 5), // Add some spacing between the icon and text
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserNotificationViewPage(),));
                      }, child: Text("Notification",style: TextStyle(color: Colors.blue,fontSize: 18,fontFamily: "Schyler"),))
                    ],
                  ),
                ),
              ),Divider(thickness: 1,color: Colors.blue[100],
                indent: 20,endIndent: 35,),


              SizedBox(height: 40,
                child: ListTile(
                  onTap: () {
                    // Add functionality for Item 1
                  },
                  title: Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ImageUploadPage(),));
                      }, icon: Icon(CupertinoIcons.person_alt_circle,color: Colors.blue,size: 18,)),
                      SizedBox(width: 5), // Add some spacing between the icon and text
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ImageUploadPage(),));
                      }, child: Text("My Account",style: TextStyle(color: Colors.blue,fontSize: 18,fontFamily: "Schyler"),))
                    ],
                  ),
                ),
              ),Divider(thickness: 1,color: Colors.blue[100],
                indent: 20,endIndent: 35,),




              SizedBox(height: 40,
                child: ListTile(
                  onTap: () {
                    // Add functionality for Item 1
                  },
                  title: Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ContactSupportPage(),));
                      }, icon: Icon(Icons.phone_forwarded_outlined,color: Colors.blue,size: 18,)),
                      SizedBox(width: 5), // Add some spacing between the icon and text
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ContactSupportPage(),));
                      }, child: Text("Contact Us",style: TextStyle(color: Colors.blue,fontSize: 18,fontFamily: "Schyler"),))
                    ],
                  ),
                ),
              ),Divider(thickness: 1,color: Colors.blue[100],
                indent: 20,endIndent: 35,),


              SizedBox(height: 40,
                child: ListTile(
                  onTap: () {
                    // Add functionality for Item 1
                  },
                  title: Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => aboutus(),));
                      }, icon: Icon(CupertinoIcons.person_2_alt,color: Colors.blue,size: 18,)),
                      SizedBox(width: 5),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => aboutus(),));
                      }, child: Text("About Us",style: TextStyle(color: Colors.blue,fontSize: 18,fontFamily: "Schyler"),))
                    ],
                  ),
                ),
              ),Divider(thickness: 1,color: Colors.blue[100],
                indent: 20,endIndent: 35,),






              SizedBox(height: 40,
                child: ListTile(
                  onTap: () {
                    // Add functionality for Item 1
                  },
                  title: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.logout,color: Colors.blue,),
                        onPressed: () async {
                          await SharedPrefHelper.setLoginStatus(false);
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                      ),
                      SizedBox(width: 5), // Add some spacing between the icon and text
                      TextButton(
                        onPressed: () async {
                          await SharedPrefHelper.setLoginStatus(false);
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(color: Colors.blue, fontSize: 18, fontFamily: "Schyler"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),Divider(thickness: 1,color: Colors.blue[100],
                indent: 20,endIndent: 35,),

            ],
          ),
        ),
      ),








      body: SingleChildScrollView(
        child: Column(children: [

          SizedBox(height: 25,),
          // Center(
          //   child: Container(width: 380,
          //     child: TextField(
          //       decoration: InputDecoration(
          //         prefixIcon: Icon(Icons.search),
          //         hintText: "Search here",
          //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
          //         ),
          //         contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          //       ),),
          //   ),
          // ),
        

          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16/9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            items: [
              GestureDetector(onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => crseltouch(),));
              },
                child: Container(
                  width: 400, // Set width of the container
                  height: 200, // Set height of the container
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/cr1.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
        
              GestureDetector(onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => crsltwo(),));
              },
                child: Container(
                  width: 400, // Set width of the container
                  height: 200, // Set height of the container
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/cr2.jpeg"),
                      fit: BoxFit.cover, // This property ensures the image covers the whole container
                    ),
                  ),
                ),
              ),
        
              GestureDetector(onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => crseltouch(),));
              },
                child: Container(
                  width: 400, // Set width of the container
                  height: 200, // Set height of the container
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/cr3.jpeg"),
                      fit: BoxFit.cover, // This property ensures the image covers the whole container
                    ),
                  ),
                ),
              ),
        
              GestureDetector(onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => crsltwo(),));
              },
                child: Container(
                  width: 400, // Set width of the container
                  height: 200, // Set height of the container
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/cr4.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        
          SizedBox(height: 15,),
        
        
          Row(
            children: [
              SizedBox(width: 15),
              Text(
                "Services",
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  setState(() {
                    _showImages = !_showImages;
                  });
                },
                child: Text(
                  "See all",
                  style: TextStyle(fontSize: 15, color: Colors.blue[500]),
                ),
              )
            ],
          ),
        
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              SizedBox(width: 1,),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => grocdetails(),));
                  },
                  child: Image.asset("assets/images/grocerry.jpg",width: 180,height: 200,)),
              SizedBox(width: 25,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => meddetails(),));
                },
                  child: Image.asset("assets/images/medicines.jpg",width: 180,height: 200,)),
            ],),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text("Buy your Groceries now",style: TextStyle(fontSize: 18),),
              ),
              SizedBox(width: 40,),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text("Buy your Medicines",style: TextStyle(fontSize: 18),),
              )
            ],),
          ),
        
        
          SizedBox(height: 20),
          _showImages
              ? Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                                children: [
                    SizedBox(width: 15,),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => viewcare(),));
                        },
                        child: Image.asset("assets/images/doctor.jpg",width: 180,height: 200,)),
                    SizedBox(width: 25,),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => homee3(),));
                        },
                        child: Image.asset("assets/images/health reminder.jpg",width: 180,height: 200,))
                                ],
                              ),
                  ),
                  Row(children: [
                    SizedBox(width: 35,),
                    Column(
                      children: [
                        Text("Book Your",style: TextStyle(fontSize: 18),),
                        Text("care taker",style: TextStyle(fontSize: 18),),
                      ],
                    ),

                    SizedBox(width: 135,),
                    Text("Healthy Reminders",style: TextStyle(fontSize: 18),)
                  ],),
                ],
              )
              : SizedBox(),







          SizedBox(height: 10,),
          Row(
            children: [
              SizedBox(width: 15),
              Text(
                "Top Care Taker's we have",
                style: TextStyle(fontSize: 18),
              ),
              Spacer(), // Use Spacer to push See all button to the right
              TextButton(
                onPressed: () {
                  setState(() {
                    showimages = !showimages; // Toggle the visibility of images
                  });
                },
                child: Text(
                  "See all",
                  style: TextStyle(fontSize: 15, color: Colors.blue[500]),
                ),
              )
            ],
          ),

          Row(children: [
            SizedBox(width: 15,),
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => viewcare(),));
                },
                child: Image.asset("assets/images/doctorpic4.webp",width: 180,height: 200,)),
            SizedBox(width: 25,),
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => viewcare(),));
                },
                child: Image.asset("assets/images/doctorpic1.jpg",width: 180,height: 200,)),
          ],),
          Row(children: [
            SizedBox(width: 15,),
            Column(
              children: [
                Text("Mrs.Adithi shankar",style: TextStyle(fontSize: 18),),
                Text("7 Years Experience"),
                Row(
                  children: [
                    Icon(Icons.star,color: Colors.orange,),
                    Icon(Icons.star,color: Colors.orange,),
                    Icon(Icons.star,color: Colors.orange,),
                    Icon(Icons.star,color: Colors.orange,),
                    Icon(Icons.star_border,color: Colors.orange,),
                  ],
                )
              ],
            ),
            SizedBox(width: 70,),
            Column(
              children: [
                Text("Mr. S.K Shivarajkumar",style: TextStyle(fontSize: 18),),
                Text("5 years Experience"),
                Row(
                  children: [
                    Icon(Icons.star,color: Colors.orange,),
                    Icon(Icons.star,color: Colors.orange,),
                    Icon(Icons.star,color: Colors.orange,),
                    Icon(Icons.star,color: Colors.orange,),
                    Icon(Icons.star_border,color: Colors.orange,),
                  ],
                )
              ],
            ),
          ],),


          SizedBox(height: 20), // Add some space between text and containers
          showimages
              ? Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 15,),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => viewcare(),));
                      },
                      child: Image.asset("assets/images/doctorpic3.jpeg",width: 180,height: 200,)),
                  SizedBox(width: 25,),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => viewcare(),));
                      },
                      child: Image.asset("assets/images/doctorpic2.jpg",width: 180,height: 200,))
                ],
              ),
              Row(children: [
                SizedBox(width: 15,),
                Column(
                  children: [
                    Text("Mr. Arun k Menon",style: TextStyle(fontSize: 18),),
                    Text("13 years Experience"),
                    Row(
                      children: [
                        Icon(Icons.star,color: Colors.orange,),
                        Icon(Icons.star,color: Colors.orange,),
                        Icon(Icons.star,color: Colors.orange,),
                        Icon(Icons.star,color: Colors.orange,),
                        Icon(Icons.star_border,color: Colors.orange,),
                      ],
                    )
                  ],
                ),
                SizedBox(width: 85,),
                Column(
                  children: [
                    Text("Mr. Satheesh kumar",style: TextStyle(fontSize: 18),),
                    Text("7 years Experience"),
                    Row(
                      children: [
                        Icon(Icons.star,color: Colors.orange,),
                        Icon(Icons.star,color: Colors.orange,),
                        Icon(Icons.star,color: Colors.orange,),
                        Icon(Icons.star,color: Colors.orange,),
                        Icon(Icons.star_border,color: Colors.orange,),
                      ],
                    )
                  ],
                ),
              ],),
            ],
          ): SizedBox(),



        
        
        
        
        
        
        
        
        
        
        ]),
      ),







    );
  }
}