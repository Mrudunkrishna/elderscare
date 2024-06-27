import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

class below extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Be Healthy'),
        backgroundColor: Colors.blue[100],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('health_tips2').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No health tips available'),
            );
          }

          var tips = snapshot.data!.docs.where((doc) {
            var data = doc.data() as Map<String, dynamic>;
            return data.containsKey('title') &&
                data.containsKey('description') &&
                data['title'].toString().isNotEmpty &&
                data['description'].toString().isNotEmpty;
          }).toList();

          if (tips.isEmpty) {
            return Center(
              child: Text('No health tips available'),
            );
          }

          return ListView.builder(
            itemCount: tips.length,
            itemBuilder: (context, index) {
              var tip = tips[index];
              var data = tip.data() as Map<String, dynamic>;

              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.39,
                child: Card(
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (data.containsKey('imageUrl') && data['imageUrl'].isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Image.network(
                              data['imageUrl'],
                              width: MediaQuery.of(context).size.width * 0.30,
                              height: MediaQuery.of(context).size.height * 0.25,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return SizedBox.shrink();
                              },
                            ),
                          ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['title'],
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text('Description: ${data['description']}',style: TextStyle(fontSize: 20),),
                              if (data.containsKey('waterLevel'))
                                Text('Water Level: ${data['waterLevel']}',style: TextStyle(fontSize: 20),),
                              if (data.containsKey('bpLevel'))
                                Text('BP Level: ${data['bpLevel']}',style: TextStyle(fontSize: 20),),
                              if (data.containsKey('cholesterolLevel'))
                                Text('Cholesterol Level: ${data['cholesterolLevel']}',style: TextStyle(fontSize: 20),),
                              if (data.containsKey('sugarLevel'))
                                Text('Sugar Level: ${data['sugarLevel']}',style: TextStyle(fontSize: 20),),
                              Padding(
                                padding: const EdgeInsets.only(top: 15,left: 85),
                                child: Lottie.asset(
                                  "assets/images/health.json", // Replace 'animation.json' with the path to your animation file
                                  height: 100,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
