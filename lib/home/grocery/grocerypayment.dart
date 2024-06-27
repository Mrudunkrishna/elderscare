import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher for navigating to payment apps

class PaymentPage extends StatefulWidget {
  final Map<String, dynamic> grocery;

  PaymentPage({required this.grocery});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _selectedPaymentMethod;

  void _placeOrder(BuildContext context) async {
    if (_selectedPaymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a payment method')),
      );
      return;
    }

    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('groceryPayment').add({
          'userId': user.uid,
          'groceryId': widget.grocery['id'],  // Make sure 'id' is present in grocery data
          'groceryName': widget.grocery['name'],
          'paymentMethod': _selectedPaymentMethod,
          'timestamp': FieldValue.serverTimestamp(),
        });

        if (_selectedPaymentMethod == 'Cash on Delivery') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.blue[100],
                title: Text('Order Placed'),
                content: Text('Your order to be expected in 24 hours.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();  // Navigate back to previous screen
                    },
                    child: Text('OK', style: TextStyle(color: Colors.black)),
                  ),
                ],
              );
            },
          );
        } else {
          _launchPaymentApp(_selectedPaymentMethod);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void _launchPaymentApp(String? paymentMethod) async {
    String url;
    switch (paymentMethod) {
      case 'PhonePe':
        url = 'https://www.phonepe.com/';
        break;
      case 'GPay':
        url = 'https://pay.google.com/intl/en_in/about/'; // Example UPI intent for GPay
        break;
      default:
        url = '';
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch the payment app')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.blue[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.grocery['image'] != null
                ? Image.network(widget.grocery['image'], width: double.infinity, height: 200, fit: BoxFit.cover)
                : Container(height: 200, color: Colors.grey),
            SizedBox(height: 16),
            Text('Name: ${widget.grocery['name'] ?? 'No name'}', style: TextStyle(fontSize: 20)),
            Text('Details: ${widget.grocery['details'] ?? 'No details'}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Divider(),
            Text('Payment Options', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            RadioListTile<String>(
              title: Row(
                children: [
                  Image.asset('assets/images/phonepay.png', height: 24), // Ensure you have an image asset
                  SizedBox(width: 10),
                  Text('PhonePe'),
                ],
              ),
              value: 'PhonePe',
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Row(
                children: [
                  Image.asset('assets/images/gpay.jpeg', height: 24), // Ensure you have an image asset
                  SizedBox(width: 10),
                  Text('Google Pay (GPay)'),
                ],
              ),
              value: 'GPay',
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Cash on Delivery'),
              value: 'Cash on Delivery',
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            Spacer(),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.50,
                height: MediaQuery.of(context).size.height * 0.10,
                child: ElevatedButton(
                  onPressed: () {
                    _placeOrder(context);
                  },
                  child: Text(
                    "Buy Now",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[100],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
