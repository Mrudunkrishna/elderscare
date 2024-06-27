import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher for navigating to payment apps

class CaretakerPaymentPage extends StatefulWidget {
  final Map<String, dynamic> caretaker;

  CaretakerPaymentPage({required this.caretaker});

  @override
  _CaretakerPaymentPageState createState() => _CaretakerPaymentPageState();
}

class _CaretakerPaymentPageState extends State<CaretakerPaymentPage> {
  String? _selectedPaymentMethod;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue[100],
          title: Text('Booking Confirmed', style: TextStyle(color: Colors.black)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your booking has been confirmed.', style: TextStyle(color: Colors.black)),
                Text('Payment Method: $_selectedPaymentMethod.', style: TextStyle(color: Colors.black)),
                Text('Date: ${_selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : 'No date selected'}', style: TextStyle(color: Colors.black)),
                Text('Time: ${_selectedTime != null ? _selectedTime!.format(context) : 'No time selected'}', style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: Colors.black)),
              onPressed: () {
                _storeDetails();
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Navigate back to previous screen
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _storeDetails() async {
    User? Currentuser = FirebaseAuth.instance.currentUser;
    if (Currentuser != null) {
      await FirebaseFirestore.instance.collection('carebookings').add({
        'caretakerName': widget.caretaker['name'],
        'caretakerContact': widget.caretaker['contact number'],
        'paymentMethod': _selectedPaymentMethod,
        'date': _selectedDate,
        'time': _selectedTime != null ? Timestamp.fromDate(DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day, _selectedTime!.hour, _selectedTime!.minute)) : null,
        'price': widget.caretaker['price'],
        'timestamp': Timestamp.now(),
        'userId': Currentuser.uid,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking details stored successfully')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User not logged in')));
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)), // Allow booking for the next year
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _launchPaymentApp(String paymentMethod) async {
    String url;
    switch (paymentMethod) {
      case 'PhonePe':
        url = 'phonepe://';
        break;
      case 'GPay':
        url = 'upi://pay?pa=yourupiid@okicici&pn=YourName'; // Example UPI intent for GPay
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
        title: Text('Payment Details'),
        backgroundColor: Colors.blue[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                widget.caretaker['imageUrl'] != null
                    ? Image.network(widget.caretaker['imageUrl'], width: 80, height: 80, fit: BoxFit.cover)
                    : Container(width: 80, height: 80, color: Colors.grey),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${widget.caretaker['name'] ?? 'No name'}', style: TextStyle(fontSize: 20)),
                    Text('Contact: ${widget.caretaker['contact number'] ?? 'No contact number'}', style: TextStyle(fontSize: 16)),
                    Text('Price: ${widget.caretaker['price'] ?? 'No price available'}', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Payment Options', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ListTile(
              leading: Image.asset('assets/images/gpay.jpeg', height: 24), // Ensure you have an image asset
              title: Text('GPay'),
              trailing: Radio<String>(
                value: 'GPay',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: Image.asset('assets/images/phonepay.png', height: 24), // Ensure you have an image asset
              title: Text('PhonePe'),
              trailing: Radio<String>(
                value: 'PhonePe',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet), // Replace with an appropriate image if available
              title: Text('Care Wallet'),
              trailing: Radio<String>(
                value: 'Care Wallet',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.money), // Replace with an appropriate image if available
              title: Text('Cash on Delivery'),
              trailing: Radio<String>(
                value: 'Cash on Delivery',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Select Date: '),
                IconButton(
                  icon: Icon(Icons.calendar_month),
                  onPressed: () {
                    _selectDate(context);
                  },
                ),
                Text('Date: ${_selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : 'No date selected'}'),
              ],
            ),
            Row(
              children: [
                Text('Select Time: '),
                IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: () {
                    _selectTime(context);
                  },
                ),
                Text('Time: ${_selectedTime != null ? _selectedTime!.format(context) : 'No time selected'}'),
              ],
            ),
            Spacer(),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.50,
                height: MediaQuery.of(context).size.height * 0.10,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedPaymentMethod != null) {
                      if (_selectedPaymentMethod == 'Cash on Delivery') {
                        _showConfirmationDialog();
                      } else if (_selectedPaymentMethod == 'GPay' || _selectedPaymentMethod == 'PhonePe') {
                        _launchPaymentApp(_selectedPaymentMethod!);
                      } else {
                        _storeDetails();
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select a payment method')));
                    }
                  },
                  child: Text(
                    "Proceed to Pay",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[100],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
