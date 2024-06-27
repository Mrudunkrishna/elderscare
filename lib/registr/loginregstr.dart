
import 'package:elderscareapp/signup/signinsmll.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
class loginreg extends StatefulWidget {
  const loginreg({Key? key}) : super(key: key);

  @override
  State<loginreg> createState() => _LoginState();
}

class _LoginState extends State<loginreg> {
  bool obscurete=true;
  bool obscuretex=true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> reg() async {
    try {
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String confirmPassword = confirmPasswordController.text.trim();
      String phone = phoneController.text.trim();

      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match")),
        );
        return;
      }

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);


      final FirebaseFirestore firestore=FirebaseFirestore.instance;
      await firestore.collection("user").doc(
          userCredential.user!.uid).set({
        "uid":userCredential.user!.uid,
        "name":name,
        "email":email,
        "phone":phone
      });


      final FirebaseFirestore firestor=FirebaseFirestore.instance;
      await firestore.collection("user1").doc(
          userCredential.user!.uid).set({
        "name":name,
        "email":email,
        "phone":phone
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("succesful"))
      );

    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("failed registration"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                    title: Text(
                    "Create Your Profile",
                     style: TextStyle(
                       fontFamily: 'Schyler',
                   fontSize: 30,
                    ),
                  ),
                   backgroundColor: Colors.blueAccent[100],
          automaticallyImplyLeading: false, // Remove back button
        ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Padding(
              padding: const EdgeInsets.only(right: 100),
              child: Lottie.asset(
                "assets/images/annie.json", // Replace 'animation.json' with the path to your animation file
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.6,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            SizedBox(width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_2_outlined),
                  hintText: "Name",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                ),
              ),
            ),


            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            SizedBox(width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: "Email",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                ),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            SizedBox(width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      obscurete=!obscurete;
                    });
                  }, icon: Icon(obscurete? Icons.visibility_off:Icons.visibility)),
                  hintText: "Password",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                ),
                obscureText: obscurete,
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: SizedBox(width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        obscuretex=!obscuretex;
                      });
                    }, icon: Icon(obscuretex? Icons.visibility_off:Icons.visibility)),
                    hintText: "Confirm Password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  ),
                  obscureText: obscuretex,
                ),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            SizedBox(width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  hintText: "Phone",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                ),
              ),
            ),



            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
            Container(width: 300,height: 50,
              child: ElevatedButton(
                onPressed: reg,
                child: Text("Register",style: TextStyle(
                  color: Colors.white,fontFamily: 'Schyler',fontSize: 25
                ),),style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent[100],side: BorderSide(color: Colors.green)
              ),
              ),
            ),

            SizedBox(height: 25,),
            Container(width: 300,height: 50,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => signinsmll()),
                  );
                },
                child: Text("Log In",style: TextStyle(
                    color: Colors.white,fontFamily: 'Schyler',fontSize: 25
                ),),style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent[100],side: BorderSide(color: Colors.green)
              ),
              ),
            ),

            SizedBox(height: 25,),






          ],
        ),
      ),
    );
  }
}


