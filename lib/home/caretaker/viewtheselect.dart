import 'package:elderscareapp/home/caretaker/caretakerpayment.dart';
import 'package:flutter/material.dart';

class CaretakerDetailPage extends StatelessWidget {
  final Map<String, dynamic> caretaker;

  CaretakerDetailPage({required this.caretaker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(caretaker['name'] ?? 'No name'),
        backgroundColor: Colors.blue[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            caretaker['imageUrl'] != null
                ? Image.network(caretaker['imageUrl'], width: double.infinity, height: 300, fit: BoxFit.cover)
                : Container(height: 200, color: Colors.grey),
            SizedBox(height: 36),
            Text('Name: ${caretaker['name'] ?? 'No name'}', style: TextStyle(fontSize: 28,decoration: TextDecoration.underline,fontStyle: FontStyle.italic)),
            Text('Address: ${caretaker['Adress'] ?? 'No address'}', style: TextStyle(fontSize: 16)),
            Text('Experience: ${caretaker['Experience'] ?? 'No experience'}', style: TextStyle(fontSize: 16)),
            Text('Contact: ${caretaker['contact number'] ?? 'No contact number'}', style: TextStyle(fontSize: 16)),
            Text('Price: ${caretaker['price'] ?? 'No Price'}', style: TextStyle(fontSize: 16)),


            SizedBox(height: 150,),
            Center(
              child: SizedBox(width: MediaQuery.of(context).size.width*0.50,
                height: MediaQuery.of(context).size.height*0.10,
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CaretakerPaymentPage(caretaker: caretaker),));
                }, child: Text("Book Now",style: TextStyle(color: Colors.black,fontSize: 20),),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[100],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
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
