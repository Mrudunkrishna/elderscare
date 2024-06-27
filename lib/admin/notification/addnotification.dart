import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class notiadmin extends StatefulWidget {
  @override
  _AdminNotificationAddPageState createState() => _AdminNotificationAddPageState();
}

class _AdminNotificationAddPageState extends State<notiadmin> {
  final TextEditingController _notificationController = TextEditingController();

  void _addNotification() {
    String notificationText = _notificationController.text.trim();
    if (notificationText.isNotEmpty) {
      FirebaseFirestore.instance.collection('notifications').add({
        'text': notificationText,
        'timestamp': FieldValue.serverTimestamp(),
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Notification added successfully')));
        _notificationController.clear();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add notification')));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notification'),
        backgroundColor: Colors.blue[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 35,),
            TextFormField(
              maxLength: 50,
              controller: _notificationController,
              decoration: InputDecoration(labelText: 'Notification',
              border: OutlineInputBorder(borderRadius: 
              BorderRadius.circular(20))
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 110),
              child: ElevatedButton(
                onPressed: _addNotification,
                child: Text('Add Notification',style: TextStyle(color: Colors.black),),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[100]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
