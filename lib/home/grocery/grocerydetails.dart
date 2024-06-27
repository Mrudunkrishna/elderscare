import 'package:elderscareapp/home/grocery/viewthegroselected.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class grocdetails extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        automaticallyImplyLeading: true,
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 40),
                child: Text(
                  "Buy your Groceries Here",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.chat)),
              IconButton(onPressed: () {}, icon: Icon(Icons.help_outline)),
            ],
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: StreamBuilder(
        stream: _firestore.collection('grocery').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return GridView.builder(
            padding: EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.7,
            ),
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot doc = snapshot.data!.docs[index];
              final data = doc.data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => groceryselected(grocery: data),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      Container(
                        height: 215,
                        width: double.infinity,
                        child: data['image'] != null
                            ? Image.network(
                          data['image'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.broken_image, size: 50);
                          },
                        )
                            : Icon(Icons.image_not_supported, size: 50),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name
                            Text(
                              data['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            // Details
                            Text(
                              data['details'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
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

  Widget buildDrawerItem(BuildContext context, IconData icon, String text) {
    return SizedBox(
      height: 40,
      child: ListTile(
        onTap: () {},
        title: buildDrawerRow(icon, text),
      ),
    );
  }

  Widget buildDrawerRow(IconData icon, String text) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(icon, color: Colors.black, size: 18),
        ),
        SizedBox(width: 5),
        TextButton(
          onPressed: () {},
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: "Schyler",
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDivider() {
    return Divider(
      thickness: 1,
      color: Colors.pink[100],
      indent: 20,
      endIndent: 35,
    );
  }
}
