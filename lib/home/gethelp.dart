import 'package:flutter/material.dart';

class GetHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Help',style: TextStyle(fontFamily: 'Schyler',fontSize: 35),),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              SizedBox(height: 16.0),
              _buildSectionTitle('Frequently Asked Questions (FAQ)'),
              _buildFAQItem(
                'What is the Elderly Care App?',
                'The Elderly Care App allows users to buy groceries, purchase medicine, and book caretakers to ensure the well-being of elderly individuals.',
              ),
              _buildFAQItem(
                'How do I create an account?',
                'To create an account, click on the "Sign Up" button on the home screen and follow the prompts to enter your personal details and set up a password.',
              ),

              _buildFAQItem(
                'How do I order groceries?',
                'To order groceries, navigate to the "Groceries" section, select the items you need. Once you have all the items, proceed to checkout and follow the payment instructions.',
              ),

              _buildFAQItem(
                'How do I order medicine?',
                'Go to the "Medicine" section, browse or search for the required medicine. and complete the purchase through the checkout process.',
              ),
              _buildFAQItem(
                'How do I book a caretaker?',
                'To book a caretaker, go to the "Caretakers" section, browse through the available caretakers, view their profiles, select the one that fits your needs, and choose the date and time for the service.',
              ),
              _buildFAQItem(
                'Can I cancel a caretaker booking?',
                'Yes, you can cancel a caretaker booking from the "cancel Bookings" section. Select the booking you wish to cancel and follow the cancellation instructions. Please note that cancellation policies may apply.',
              ),
              SizedBox(height: 16.0),
              _buildSectionTitle('Contact Support'),
              _buildSupportItem(
                'Email Support',
                'Email us at support@elderlycareapp.com for any issues or questions. We aim to respond within 24 hours.',
              ),
              _buildSupportItem(
                'Phone Support',
                'Call us at 0000000000. Our support lines are open from 9 AM to 6 PM, Monday to Friday.',
              ),

              SizedBox(height: 16.0),
              _buildSectionTitle('Troubleshooting'),
              _buildTroubleshootingItem(
                'The app is not loading or is crashing. What should I do?',
                'Try the following steps:\n1. Close and reopen the app.\n2. Ensure you have the latest version of the app installed.\n3. Restart your device.\n4. Check your internet connection.\n\nIf the problem persists, please contact our support team.',
              ),
              _buildTroubleshootingItem(
                'I am unable to make a payment. What should I do?',
                'Ensure your payment details are correct and up-to-date. If the issue continues, try using a different payment method. Contact our support team if you need further assistance.',
              ),
              SizedBox(height: 16.0),
              _buildSectionTitle('Feedback'),
              Text(
                'We value your feedback! If you have any suggestions or comments on how we can improve our app, please email us at feedback@elderlycareapp.com or use the feedback form in the app.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      child: Text(
        title,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black,fontFamily: 'Schyler'),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              question,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text(answer),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text(description),
          ],
        ),
      ),
    );
  }

  Widget _buildTroubleshootingItem(String issue, String steps) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              issue,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text(steps),
          ],
        ),
      ),
    );
  }
}

