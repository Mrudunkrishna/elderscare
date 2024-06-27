import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class cancelcaretaker extends StatefulWidget {
  @override
  _CancelCaretakerPageState createState() => _CancelCaretakerPageState();
}

class _CancelCaretakerPageState extends State<cancelcaretaker> {
  late Stream<QuerySnapshot> _bookingStream;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _fetchBookingStream();
  }

  void _fetchBookingStream() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _bookingStream = FirebaseFirestore.instance
            .collection('carebookings')
            .where('userId', isEqualTo: user.uid)
            .snapshots();
      });
    }
  }

  Future<void> _cancelBooking(String documentId) async {
    try {
      await FirebaseFirestore.instance.collection('carebookings').doc(documentId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking cancelled successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to cancel booking: $e')),
      );
    }
  }

  void _showCancelDialog(String documentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue[100],
          title: Text('Cancel Booking'),
          content: Text('Are you sure you want to cancel this booking?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No', style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                _cancelBooking(documentId);
                Navigator.of(context).pop();
              },
              child: Text('Yes', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancel Caretaker Bookings'),
        backgroundColor: Colors.blue[100],
      ),
      body: _bookingStream == null
          ? Center(child: CircularProgressIndicator())
          : StreamBuilder<QuerySnapshot>(
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

          return GridView.builder(
            padding: EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 3 / 4,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              Timestamp timestamp = data['timestamp'] as Timestamp;
              DateTime bookingTime = timestamp.toDate();

              return Card(
                color: Colors.blue[200],
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Caretaker: ${data['caretakerName']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('Contact: ${data['caretakerContact']}'),
                      Text('Payment Method: ${data['paymentMethod']}'),
                      Text('Date: ${data['date'] != null ? DateFormat('yyyy-MM-dd').format(data['date']!.toDate()) : 'No date'}'),
                      Text('Time: ${DateFormat('HH:mm').format(bookingTime)}'),
                      Spacer(),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => _showCancelDialog(document.id),
                          child: Text('Cancel Booking', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
