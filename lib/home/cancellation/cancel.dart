import 'package:elderscareapp/home/cancellation/cancelcaretaker.dart';
import 'package:elderscareapp/home/cancellation/cancelgrocery.dart';
import 'package:elderscareapp/home/cancellation/cancelmedicine.dart';
import 'package:flutter/material.dart';

class CancelBookingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancel Your Bookings and Orders'),
        backgroundColor: Colors.blue[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            Text('Cancel Your Bookings and Orders', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,fontFamily: 'Schyler'),),
            SizedBox(height: 80),
            ListTile(
              title: Text('Cancel Medicine'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookedMedicine()),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('Cancel Grocery'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookedGrocery()),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('Cancel Caretaker'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => cancelcaretaker()),
                );
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

