import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderscareapp/home/aboutus.dart';
import 'package:elderscareapp/home/cancellation/cancel.dart';
import 'package:elderscareapp/home/caretaker/viewcaretaker.dart';
import 'package:elderscareapp/home/chatuser.dart';
import 'package:elderscareapp/home/contactsupport/contactsupport.dart';
import 'package:elderscareapp/home/feedbakuser.dart';
import 'package:elderscareapp/home/gethelp.dart';
import 'package:elderscareapp/home/notification.dart';
import 'package:elderscareapp/home/sharedpreference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class ImageUploadPage extends StatefulWidget {
  const ImageUploadPage({Key? key}) : super(key: key);
  @override
  State<ImageUploadPage> createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _profileImageUrl;
  String _userName = '';
  String _email = '';
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadProfileImage();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _loadUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
      String name = userDoc['name'] ?? 'User Name';
      setState(() {
        _userName = name;
        _email = user.email ?? 'Email';
      });
    }
  }

  Future<void> _loadProfileImage() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentSnapshot userDoc = await _firestore.collection('user').doc(user.uid).get();
      setState(() {
        _profileImageUrl = userDoc['profileImageUrl'] as String?;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    try {
      if (_image != null) {
        final User? user = _auth.currentUser;
        if (user != null) {
          final String uid = user.uid;
          final Reference ref = _storage.ref().child('profile_images').child('$uid.jpg');
          await ref.putFile(_image!);
          final String downloadUrl = await ref.getDownloadURL();
          setState(() {
            _profileImageUrl = downloadUrl;
          });
          await _firestore.collection('user').doc(uid).update({'profileImageUrl': downloadUrl});
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
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
              padding: const EdgeInsets.only(right: 100),
              child: Text("My Profile",style: TextStyle(fontSize: 25),),
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
        child: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Align widgets to the start of the column
              mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 25,),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 25),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: _profileImageUrl != null
                          ? NetworkImage(_profileImageUrl!)
                          : AssetImage('assets/images/default_avatar.png') as ImageProvider,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text(
                        'Upload Profile Picture',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[100]),
                    ),
                  ],
                ),


              // ElevatedButton(
              //   onPressed: _toggleEditing,
              //   child: Text(_isEditing ? 'Done Editing' : 'Edit',style: TextStyle(color: Colors.black),
              //   ),
              //   style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.blue[100],side: BorderSide(color: Colors.green)
              //   ),
              // ),
              //
              // if (_isEditing)
              // Column(children: [
              //   SizedBox(width: MediaQuery.of(context).size.width * 0.5,
              //     child: ElevatedButton(
              //       onPressed: () => _pickImage(ImageSource.gallery),
              //       child: Text("Pick from gallery",style: TextStyle(color: Colors.black)),
              //       style: ElevatedButton.styleFrom(
              //           backgroundColor: Colors.blue[100],side: BorderSide(color: Colors.green)
              //       ),
              //     ),
              //   ),
              //   SizedBox(width: MediaQuery.of(context).size.width * 0.5,
              //     child: ElevatedButton(
              //       onPressed: () => _pickImage(ImageSource.camera),
              //       child: Text("Take a picture",style: TextStyle(color: Colors.black),),
              //       style: ElevatedButton.styleFrom(
              //           backgroundColor: Colors.blue[100],side: BorderSide(color: Colors.green)
              //       ),
              //     ),
              //   ),
              //
              //   SizedBox(width: MediaQuery.of(context).size.width * 0.5,
              //     child: ElevatedButton(
              //       onPressed: _uploadImage,
              //       child: Text("Save image",style: TextStyle(color: Colors.black),),
              //       style: ElevatedButton.styleFrom(
              //           backgroundColor: Colors.blue[100],side: BorderSide(color: Colors.green)
              //       ),
              //     ),
              //   ),
              // ],
                ),



              SizedBox(height: 25,),
              Text(_userName,style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),),
              SizedBox(height: 10,),
              Text(_email,style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),),





              SizedBox(height: 50,),
              Container(
                height: 482,
                width: 480,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  border: Border.all(color: Colors.grey), // Add border for styling
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                  ), // Add border radius for rounded corners
                ),
                child: Column(children: [
                  ListTile(
                    onTap: () {
                      // Add functionality for Item 1
                    },
                    title: Row(
                      children: [
                        IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ContactSupportPage(),));
                        }, icon: Icon(CupertinoIcons.phone_arrow_right,color: Colors.black,size: 18,)),
                        SizedBox(width: 5), // Add some spacing between the icon and text
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ContactSupportPage(),));
                        }, child: Text("Customer Support",style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: "Schyler"),))
                      ],
                    ),
                  ),
                  Divider(thickness: 1,color: Colors.pink[100],
                    indent: 20,endIndent: 35,),



                  ListTile(
                    onTap: () {
                      // Add functionality for Item 1
                    },
                    title: Row(
                      children: [
                        IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => aboutus(),));
                        }, icon: Icon(Icons.man_2_rounded,color: Colors.black,size: 18,)),
                        SizedBox(width: 5), // Add some spacing between the icon and text
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => aboutus(),));
                        }, child: Text("About Us",style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: "Schyler"),))
                      ],
                    ),
                  ),
                  Divider(thickness: 1,color: Colors.pink[100],
                    indent: 20,endIndent: 35,),






                  ListTile(
                    onTap: () {
                      // Add functionality for Item 1
                    },
                    title: Row(
                      children: [
                        IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => viewcare(),));
                        }, icon: Icon(CupertinoIcons.doc_append,color: Colors.black,size: 18,)),
                        SizedBox(width: 5), // Add some spacing between the icon and text
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => viewcare(),));
                        }, child: Text("Manage CareTaker Bookings",style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: "Schyler"),))
                      ],
                    ),
                  ),
                  Divider(thickness: 1,color: Colors.pink[100],
                    indent: 20,endIndent: 35,),



                  ListTile(
                    onTap: () {
                      // Add functionality for Item 1
                    },
                    title: Row(
                      children: [
                        IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CancelBookingsPage(),));
                        }, icon: Icon(CupertinoIcons.settings,color: Colors.black,size: 18,)),
                        SizedBox(width: 5), // Add some spacing between the icon and text
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CancelBookingsPage(),));
                        }, child: Text("Cancel Booking",style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: "Schyler"),))
                      ],
                    ),
                  ),
                  Divider(thickness: 1,color: Colors.pink[100],
                    indent: 20,endIndent: 35,),



                  ListTile(
                    onTap: () {
                      // Add functionality for Item 1
                    },
                    title: Row(
                      children: [
                        IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => feedbackpage(),));
                        }, icon: Icon(Icons.feedback_outlined,color: Colors.black,size: 18,)),
                        SizedBox(width: 5), // Add some spacing between the icon and text
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => feedbackpage(),));
                        }, child: Text("Feedback",style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: "Schyler"),))
                      ],
                    ),
                  ),
                  Divider(thickness: 1,color: Colors.pink[100],
                    indent: 20,endIndent: 35,),





                  ListTile(
                    onTap: () {
                      // Add functionality for Item 1
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
                        SizedBox(width: 5), // Add some spacing between the icon and text
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
                  Divider(thickness: 1,color: Colors.pink[100],
                    indent: 20,endIndent: 35,),




                ]),
              )







            ],
          ),
        ),
      ),
    );
  }
}