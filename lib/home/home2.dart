import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderscareapp/home/aboutus.dart';
import 'package:elderscareapp/home/chatuser.dart';
import 'package:elderscareapp/home/contactsupport/contactsupport.dart';
import 'package:elderscareapp/home/gethelp.dart';
import 'package:elderscareapp/home/healthtips/healthbelow.dart';
import 'package:elderscareapp/home/healthtips/healthtipabove.dart';
import 'package:elderscareapp/home/home4.dart';
import 'package:elderscareapp/home/notification.dart';
import 'package:elderscareapp/home/sharedpreference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class home2 extends StatefulWidget {
  const home2({super.key});

  @override
  State<home2> createState() => _home2State();
}

class _home2State extends State<home2> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> done() async {
    try {
      String name =nameController.text.trim();
      String age = ageController.text.trim();
      String gender = genderController.text.trim();
      String place = placeController.text.trim();
      String height = heightController.text.trim();
      String weight = weightController.text.trim();

      if (name.isEmpty || age.isEmpty || gender.isEmpty || place.isEmpty || height.isEmpty || weight.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("All fields are required"))
        );
        return;
      }

      int ageValue = int.tryParse(age) ?? 0;
      if (ageValue < 50 || ageValue > 95) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Age must be between 50 and 95"))
        );
        return;
      }

      await FirebaseFirestore.instance.collection("user_data").add({
        "name": name,
        "age": age,
        "gender": gender,
        "place": place,
        "height": height,
        "weight": weight,
      });

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Successful"))
      );

      if (ageValue < 80) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => below()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => above()));
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed submission"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        automaticallyImplyLeading: false, // Remove back button
        actions: [
          Row(children: [

            Padding(
              padding: const EdgeInsets.only(left: 20,right: 50),
              child: Text("Your Health Tips Here",style: TextStyle(fontSize: 20),),
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
          
        
          SizedBox(height: 20,),
          Center(
              child:
              Text("Please fill the followings",style: TextStyle(fontSize: 20,fontFamily: 'Schyler'),)
          ),


          SizedBox(height: 25,),
          SizedBox(width: 350,
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: "Name",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
            ),
          ),


          SizedBox(height: 25,),
          SizedBox(width: 350,
            child: TextField(
              controller: ageController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: "Age",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
            ),
          ),
        
          SizedBox(height: 25,),
          SizedBox(width: 350,
            child: TextField(
              controller: genderController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.airline_seat_recline_extra_sharp),
                hintText: "Gender",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
            ),
          ),
        
          SizedBox(height: 25,),
          SizedBox(width: 350,
            child: TextField(
              controller: placeController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.place),
                hintText: "Place",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
            ),
          ),
        
          SizedBox(height: 25,),
          SizedBox(width: 350,
            child: TextField(
              controller: heightController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.height),
                hintText: "Height",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
            ),
          ),
        
        
          SizedBox(height: 25,),
          SizedBox(width: 350,
            child: TextField(
              controller: weightController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.monitor_weight),
                hintText: "Weight",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
            ),
          ),
        
        
        
          SizedBox(height: 41,),
          ElevatedButton(
            onPressed: done,
            child: const Text('Submit',style: TextStyle(color: Colors.white
                ,fontFamily: 'Schyler',fontSize: 25),),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent[100],side: BorderSide(color: Colors.green)
            ),
          ),
        
          Lottie.asset(
            "assets/images/Animation .json", // Replace 'animation.json' with the path to your animation file
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          ),
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
        ]),
      ),
































    );
  }
}
