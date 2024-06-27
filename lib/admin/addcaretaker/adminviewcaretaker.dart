import 'package:elderscareapp/home/caretaker/viewtheselect.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class viewcareadmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caretaker Details'),
        backgroundColor: Colors.blue[100],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('caretaker').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final data = doc.data() as Map<String, dynamic>;

              return Container(
                color: Colors.blue[100],
                height: MediaQuery.of(context).size.height * 0.21,
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => CaretakerDetailPage(caretaker: data),
                    //   ),
                    // );
                  },
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          // Image
                          data['imageUrl'] != null
                              ? SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              data['imageUrl'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.broken_image, size: 50);
                              },
                            ),
                          )
                              : Container(
                            height: 100,
                            width: 100,
                            color: Colors.grey[200],
                            child: Icon(Icons.image_not_supported, size: 50),
                          ),
                          SizedBox(width: 10),
                          // Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10,),
                                Text(
                                  data['name'] ?? 'No name',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text('Address: ${data['Adress'] ?? 'No address'}'),
                                Text('Experience: ${data['Experience'] ?? 'No experience'}'),
                                Text('Contact: ${data['contact number'] ?? 'No contact number'}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
