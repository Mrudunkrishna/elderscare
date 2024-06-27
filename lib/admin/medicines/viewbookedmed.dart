import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class bokkedmedicine extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicines - Payment Details'),
        backgroundColor: Colors.blue[100],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('medicineDetails').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final payments = snapshot.data!.docs;

          return ListView.builder(
            itemCount: payments.length,
            itemBuilder: (context, index) {
              var payment = payments[index].data() as Map<String, dynamic>;

              return Card(
                color: Colors.blue[100],
                child: ListTile(
                  title: Text('Medicine: ${payment['medicineName']}',style: TextStyle(fontSize: 25),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 18,),
                      Text('User ID: ${payment['userId']}'),
                      // Text('Grocery ID: ${payment['groceryId']}'),
                      Text('Payment Method: ${payment['paymentMethod']}'),
                      Text('Timestamp: ${payment['timestamp'] != null ? (payment['timestamp'] as Timestamp).toDate() : 'No timestamp'}'),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
