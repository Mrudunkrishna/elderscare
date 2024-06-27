import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class feedbackpage extends StatefulWidget {
  const feedbackpage({Key? key}) : super(key: key);

  @override
  State<feedbackpage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<feedbackpage> {
  final TextEditingController _feedbackController = TextEditingController();

  Future<void> _submitFeedback() async {
    String feedbackText = _feedbackController.text.trim();
    if (feedbackText.isNotEmpty) {
      try {
        // Get the current user's email
        String? userEmail = FirebaseAuth.instance.currentUser?.email;
        if (userEmail != null) {
          await FirebaseFirestore.instance.collection('feedback').add({
            'feedback': feedbackText,
            'email': userEmail, // Store the user's email with the feedback
          });
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Feedback submitted"))
          );
          _feedbackController.clear();
        } else {
          // User not authenticated
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("User not authenticated"))
          );
        }
      } catch (error) {
        // Error handling
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to submit feedback"))
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Empty Feedback'),
            content: Text('Please provide feedback before submitting.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        automaticallyImplyLeading: true,
        title: Text(
          'Feedback',
          style: TextStyle(
            fontFamily: 'Schyler',
            fontSize: 30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Write your feedback here',
                border: OutlineInputBorder(),
              ),
            ),







            SizedBox(height: 20),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[100],
                ),
                onPressed: _submitFeedback,
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontFamily: 'Schyler1',
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}