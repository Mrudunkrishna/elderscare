import 'package:elderscareapp/home/grocery/grocerypayment.dart';
import 'package:flutter/material.dart';

class groceryselected extends StatelessWidget {
  final Map<String, dynamic> grocery;

  groceryselected({required this.grocery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(grocery['name'] ?? 'No name'),
        backgroundColor: Colors.blue[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            grocery['image'] != null
                ? Image.network(grocery['image'], width: double.infinity, height: 300, fit: BoxFit.cover)
                : Container(height: 200, color: Colors.grey),
            SizedBox(height: 16),
            Text('Name: ${grocery['name'] ?? 'No name'}', style: TextStyle(fontSize: 20,decoration: TextDecoration.underline)),
            SizedBox(height: 20,),
            Text('Price: ${grocery['details'] ?? 'No details'}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20,),
            Text('Description: ${grocery['description'] ?? 'No details'}', style: TextStyle(fontSize: 16)),


            SizedBox(height: 250,),
            Center(
              child: SizedBox(width: MediaQuery.of(context).size.width*0.50,
                height: MediaQuery.of(context).size.height*0.1,
                child: ElevatedButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(grocery: grocery),
                    ),
                  );
                }, child: Text("Order Now",style: TextStyle(color: Colors.black,fontSize: 20),),
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
