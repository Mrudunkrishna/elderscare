import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserNotificationViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.blue[100],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('notifications').orderBy('timestamp').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final notifications = snapshot.data!.docs;

          if (notifications.isEmpty) {
            return Center(child: Text('No notifications found'));
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              var notification = notifications[index].data() as Map<String, dynamic>;
              DateTime timestamp = notification['timestamp'].toDate();
              String docId = notifications[index].id;

              return Column(
                children: [
                  SizedBox(height: 25,),
                  SizedBox(
                    width: 380,
                    child: Card(
                      color: Colors.blue[100],
                      child: ListTile(
                        title: Text(notification['text']),
                        subtitle: Text('Added on: ${_formatDateTime(timestamp)}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _showDeleteDialog(context, docId),
                        ),
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

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }

  void _showDeleteDialog(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue[100],
          title: Text('Delete Notification'),
          content: Text('Are you sure you want to delete this notification?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel',style: TextStyle(color: CupertinoColors.systemGreen),),
            ),
            TextButton(
              onPressed: () {
                _deleteNotification(docId);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete',style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
  }

  void _deleteNotification(String docId) {
    FirebaseFirestore.instance.collection('notifications').doc(docId).delete();
  }
}
