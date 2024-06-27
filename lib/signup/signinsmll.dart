import 'package:elderscareapp/admin/admin1.dart';
import 'package:elderscareapp/bottomtab/bottomtab.dart';
import 'package:elderscareapp/home/Homepage.dart';
import 'package:elderscareapp/home/sharedpreference.dart';
import 'package:elderscareapp/registr/loginregstr.dart';
import 'package:elderscareapp/signup/googlesignup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signinsmll extends StatefulWidget {
  const signinsmll({Key? key});

  @override
  State<signinsmll> createState() => _EmailAndPasswordSignInState();
}

class _EmailAndPasswordSignInState extends State<signinsmll> {
  bool obscuretext = true;
  bool isLoggedIn = false;
  String email = '';

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

  void autoLogIn() async {
    bool isLoggedIn = await SharedPrefHelper.getLoginStatus();
    if (isLoggedIn) {
      _navigateToHomepage();
    }
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signIn(BuildContext context) async {
    try {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign-in Successful')),
      );

      SharedPrefHelper.setLoginStatus(true);

      if (email == "mrudunkrishna@gmail.com") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => admin1()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomTabBar()),
        );
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in: $e')),
      );
    }
  }

  Future<void> _logout() async {
    await SharedPrefHelper.setLoginStatus(false);
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _navigateToHomepage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomTabBar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Please Log In..",
          style: TextStyle(
            fontFamily: 'Schyler',
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.blueAccent[100],
        automaticallyImplyLeading: false, // Remove back button
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Image.asset(
                "assets/images/2.png",
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              !isLoggedIn
                  ? TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                ),
              )
                  : Text('You are logged in as $email'),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscuretext = !obscuretext;
                      });
                    },
                    icon: Icon(obscuretext ? Icons.visibility_off : Icons.visibility),
                  ),
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                ),
                obscureText: obscuretext,
              ),
              SizedBox(height: 16.0),
              Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: () => _signIn(context),
                  child: const Text(
                    'Log In',
                    style: TextStyle(color: Colors.white, fontFamily: 'Schyler', fontSize: 25),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent[100],
                    side: BorderSide(color: Colors.green),
                  ),
                ),
              ),
              SizedBox(height: 16),
              GoogleSignInButton(),
              Padding(
                padding: const EdgeInsets.only(left: 80, top: 100),
                child: Row(
                  children: [
                    Text("Don't have an Account ?"),
                    SizedBox(width: 5),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => loginreg()),
                        );
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
