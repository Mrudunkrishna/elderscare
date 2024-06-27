import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class viewbooked extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<viewbooked> {

  late Stream<QuerySnapshot> _bookingStream;


  @override
  void initState() {
    super.initState();
    _bookingStream = FirebaseFirestore.instance.collection('carebookings').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Bookings'),
        backgroundColor: Colors.blue[100],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _bookingStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No bookings found'));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              Timestamp timestamp = data['timestamp'] as Timestamp;
              DateTime bookingTime = timestamp.toDate();

              return Card(
                color: Colors.blue[200],
                child: ListTile(
                  title: Text('Caretaker: ${data['caretakerName']}',style: TextStyle(fontSize: 25),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 18,),
                      Text('Contact: ${data['caretakerContact']}'),
                      Text('Payment Method: ${data['paymentMethod']}'),
                      Text('Date: ${data['date'] != null ? DateFormat('yyyy-MM-dd').format(data['date']!.toDate()) : 'No date'}'),
                      Text('Time: ${DateFormat('HH:mm').format(bookingTime)}'),
                      // Text("Booked By:"),
                      // Text('Timestamp: ${DateFormat('yyyy-MM-dd HH:mm').format(bookingTime)}'),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
