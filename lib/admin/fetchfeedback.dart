import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Feedbacks",
          style: TextStyle(
            fontFamily: 'Schyler',
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.blue[100],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('feedback').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          final feedbackDocs = snapshot.data!.docs;
          if (feedbackDocs.isEmpty) {
            return Center(
              child: Text('No feedback available.'),
            );
          }
          return ListView.builder(
            itemCount: feedbackDocs.length,
            itemBuilder: (context, index) {
              final feedbackData = feedbackDocs[index].data() as Map<String, dynamic>;
              final feedback = feedbackData['feedback'];
              final email = feedbackData['email']; // Retrieve email
              return Column(
                children: [
                  SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[100], // Set container color here
                      borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.green)
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email: $email", // Display email
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Feedback: $feedback",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Schyler1',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}