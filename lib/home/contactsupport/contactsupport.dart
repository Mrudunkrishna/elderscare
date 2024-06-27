import 'package:elderscareapp/home/feedbakuser.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Support'),
        backgroundColor: Colors.blue[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 50),
            Text(
              'We are here to help you. Please choose one of the options below to contact our support team.',
              style: TextStyle(fontSize: 28.0,fontFamily: 'Schyler'),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: () => _makePhoneCall('tel:+9532165478'),
              child: Text('Call Support',style: TextStyle(color: Colors.black),),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[100]
              ,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.grey)),),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _sendEmail('mailto:abhiramdineshnp@gmail.com'),
              child: Text('Email Support',style: TextStyle(color: Colors.black),),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[100]
                ,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.grey)),),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _launchURL('https://www.google.com/faq'),
              child: Text('Visit FAQ',style: TextStyle(color: Colors.black),),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[100]
                ,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.grey)),),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => feedbackpage()),
              ),
              child: Text('Send Feedback',style: TextStyle(color: Colors.black),),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[100]
                ,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.grey)),),
            ),


            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Padding(
              padding: const EdgeInsets.only(right: 100),
              child: Lottie.asset(
                "assets/images/help.json", // Replace 'animation.json' with the path to your animation file
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.6,
                fit: BoxFit.cover,
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _sendEmail(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

// class FeedbackFormPage extends StatefulWidget {
//   @override
//   _FeedbackFormPageState createState() => _FeedbackFormPageState();
// }
//
// class _FeedbackFormPageState extends State<FeedbackFormPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _feedbackController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Send Feedback'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               TextFormField(
//                 controller: _feedbackController,
//                 maxLines: 5,
//                 decoration: InputDecoration(
//                   hintText: 'Enter your feedback',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your feedback';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     // Handle feedback submission
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Feedback sent')),
//                     );
//                     _feedbackController.clear();
//                   }
//                 },
//                 child: Text('Submit Feedback'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
