import 'package:elderscareapp/admin/addcaretaker/addcaretaker.dart';
import 'package:elderscareapp/admin/addcaretaker/viewbooked.dart';
import 'package:elderscareapp/admin/chatadmin/chatadmin.dart';
import 'package:elderscareapp/admin/groceries/addgrocery.dart';
import 'package:elderscareapp/admin/groceries/viewbookedgrocery.dart';
import 'package:elderscareapp/admin/healthtips/addhere.dart';
import 'package:elderscareapp/admin/medicines/addmedicines.dart';
import 'package:elderscareapp/admin/fetchfeedback.dart';
import 'package:elderscareapp/admin/fetchuserdetail.dart';
import 'package:elderscareapp/admin/healthtips/addhlthbelow.dart';
import 'package:elderscareapp/admin/healthtips/hlthtipsabove.dart';
import 'package:elderscareapp/admin/medicines/viewbookedmed.dart';
import 'package:elderscareapp/admin/notification/addnotification.dart';
import 'package:elderscareapp/home/aboutus.dart';
import 'package:elderscareapp/home/contactsupport/contactsupport.dart';
import 'package:elderscareapp/home/sharedpreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class admin1 extends StatefulWidget {
  const admin1({super.key});

  @override
  State<admin1> createState() => _homepageState();
}

class _homepageState extends State<admin1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        automaticallyImplyLeading: false,
        actions: [
          Row(children: [

            Padding(
              padding: const EdgeInsets.only(left: 10,right: 40),
              child: Text("Welcome ADMIN",style: TextStyle(fontSize: 20),),
            ),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreenadmin(),));
            }, icon: Icon(Icons.chat)),
            IconButton(onPressed: (){}, icon: Icon(Icons.help_outline)),
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
        child: Container(color: Colors.blue[100],
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(height: 200,
                child: DrawerHeader(
                    decoration: BoxDecoration(
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Image.asset("assets/images/logo2.jpg",width: 150,height: 100,),
                        ),
                      ],
                    )
                ),
              ),
              SizedBox(height: 40,
                child: ListTile(
                  onTap: () {
                    // Add functionality for Item 1
                  },
                  title: Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.bell,color: Colors.black,size: 18,)),
                      SizedBox(width: 5),
                      TextButton(onPressed: (){}, child: Text("Notification",style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: "Schyler"),))
                    ],
                  ),
                ),
              ),Divider(thickness: 1,color: Colors.pink[100],
                indent: 20,endIndent: 35,),


              SizedBox(height: 40,
                child: ListTile(
                  onTap: () {
                    // Add functionality for Item 1
                  },
                  title: Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.person_alt_circle,color: Colors.black,size: 18,)),
                      SizedBox(width: 5),
                      TextButton(onPressed: (){}, child: Text("My Account",style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: "Schyler"),))
                    ],
                  ),
                ),
              ),Divider(thickness: 1,color: Colors.pink[100],
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
                      }, icon: Icon(Icons.phone_forwarded_outlined,color: Colors.black,size: 18,)),
                      SizedBox(width: 5),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ContactSupportPage(),));
                      }, child: Text("Contact Us",style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: "Schyler"),))
                    ],
                  ),
                ),
              ),Divider(thickness: 1,color: Colors.pink[100],
                indent: 20,endIndent: 35,),


              SizedBox(height: 40,
                child: ListTile(
                  onTap: () {
                  },
                  title: Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => aboutus(),));
                      }, icon: Icon(CupertinoIcons.person_2_alt,color: Colors.black,size: 18,)),
                      SizedBox(width: 5),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => aboutus(),));
                      }, child: Text("About Us",style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: "Schyler"),))
                    ],
                  ),
                ),
              ),Divider(thickness: 1,color: Colors.pink[100],
                indent: 20,endIndent: 35,),






              SizedBox(height: 40,
                child: ListTile(
                  onTap: () {

                  },
                  title: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.logout),
                        onPressed: () async {
                          await SharedPrefHelper.setLoginStatus(false);
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                      ),
                      SizedBox(width: 5),
                      TextButton(
                        onPressed: () async {
                          await SharedPrefHelper.setLoginStatus(false);
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "Schyler"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),Divider(thickness: 1,color: Colors.pink[100],
                indent: 20,endIndent: 35,),

            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(children: [


          SizedBox(height: 25,),
          Center(
            child: Container(
              height: 150,
              width: 380,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Text("View all User Details",style: TextStyle(fontSize: 25,fontFamily: 'Schyler'),),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => fetch(),));
                    },
                    child: const Text('View',style: TextStyle(color: Colors.white
                        ,fontFamily: 'Schyler',fontSize: 25),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent[100],side: BorderSide(color: Colors.green)
                    ),
                  ),                ],
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
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Text("Add New Medicines details",style: TextStyle(fontSize: 25,fontFamily: 'Schyler'),),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Addmedicine(),));
                    },
                    child: const Text('Add',style: TextStyle(color: Colors.white
                        ,fontFamily: 'Schyler',fontSize: 25),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent[100],side: BorderSide(color: Colors.green)
                    ),
                  ),                ],
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
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Text("Add new Grocery Details",style: TextStyle(fontSize: 25,fontFamily: 'Schyler'),),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Addgrocery(),));
                    },
                    child: const Text('Add',style: TextStyle(color: Colors.white
                        ,fontFamily: 'Schyler',fontSize: 25),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent[100],side: BorderSide(color: Colors.green)
                    ),
                  ),                ],
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
                  Text("Add Notification",style: TextStyle(fontSize: 25,fontFamily: 'Schyler'),),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => notiadmin(),));
                    },
                    child: const Text('Add',style: TextStyle(color: Colors.white
                        ,fontFamily: 'Schyler',fontSize: 25),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent[100],side: BorderSide(color: Colors.green)
                    ),
                  ),                ],
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
                  Text("Add New Caretaker Details",style: TextStyle(fontSize: 25,fontFamily: 'Schyler'),),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => addcaretaker(),));
                    },
                    child: const Text('Add',style: TextStyle(color: Colors.white
                        ,fontFamily: 'Schyler',fontSize: 25),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent[100],side: BorderSide(color: Colors.green)
                    ),
                  ),                ],
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
                  Text("View Booked care Taker",style: TextStyle(fontSize: 25,fontFamily: 'Schyler'),),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => viewbooked(),));
                    },
                    child: const Text('View',style: TextStyle(color: Colors.white
                        ,fontFamily: 'Schyler',fontSize: 25),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent[100],side: BorderSide(color: Colors.green)
                    ),
                  ),                ],
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
                  Text("View grocery user bought",style: TextStyle(fontSize: 25,fontFamily: 'Schyler'),),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => bokkedgrocery(),));
                    },
                    child: const Text('View',style: TextStyle(color: Colors.white
                        ,fontFamily: 'Schyler',fontSize: 25),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent[100],side: BorderSide(color: Colors.green)
                    ),
                  ),                ],
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
                  Text("View medicines user bought",style: TextStyle(fontSize: 25,fontFamily: 'Schyler'),),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => bokkedmedicine(),));
                    },
                    child: const Text('View',style: TextStyle(color: Colors.white
                        ,fontFamily: 'Schyler',fontSize: 25),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent[100],side: BorderSide(color: Colors.green)
                    ),
                  ),                ],
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
                  Text("View all User Feedback",style: TextStyle(fontSize: 25,fontFamily: 'Schyler'),),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackListPage(),));
                    },
                    child: const Text('View',style: TextStyle(color: Colors.white
                        ,fontFamily: 'Schyler',fontSize: 25),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent[100],side: BorderSide(color: Colors.green)
                    ),
                  ),                ],
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
                  Text("Add Health tips For user",style: TextStyle(fontSize: 25,fontFamily: 'Schyler'),),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => addhere(),));
                    },
                    child: const Text('Add',style: TextStyle(color: Colors.white
                        ,fontFamily: 'Schyler',fontSize: 25),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent[100],side: BorderSide(color: Colors.green)
                    ),
                  ),                ],
              ),
            ),
          ),







        
        SizedBox(height: 25,),
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        ]),
      ),



    );
  }
}
