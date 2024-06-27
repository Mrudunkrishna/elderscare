import 'package:elderscareapp/bottomtab/bottomtab.dart';
import 'package:elderscareapp/home/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleSignInButton extends StatelessWidget {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> _signInWithGoogle() async {
    await googleSignIn.signOut();

    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        UserCredential userCredential = await _auth.signInWithCredential(credential);

        User? user = userCredential.user;
        if (user != null) {
          await _firestore.collection('user').doc(user.uid).set({
            'email': user.email,
          });
        }

        return userCredential;
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
    return Future.error('Failed to sign in with Google');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          await _signInWithGoogle();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomTabBar()),
          );
        },
        child: Row(
          children: [
            Image.asset(
              "assets/images/google.png",
              height: 45,
            ),
            SizedBox(width: 45),
            Text(
              'Sign In with Google',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Schyler',
                fontSize: 25,
              ),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent[100],
          side: BorderSide(color: Colors.green),
        ),
      ),
    );
  }
}
