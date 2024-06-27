import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class Addgrocery extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<Addgrocery> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void _uploadGrocery() async {
    String name = _nameController.text;
    String details = _detailsController.text;
    String description = _descriptionController.text;

    try {
      if (_image != null) {
        // Upload image to Firebase Storage
        Reference ref = _storage.ref().child("grocery_images/$name");
        await ref.putFile(_image!);

        // Get image URL
        String imageUrl = await ref.getDownloadURL();

        // Save grocery details to Firestore
        await _firestore.collection('grocery').doc().set({
          'name': name,
          'details': details,
          'description': description,
          'image': imageUrl,
        });

        _nameController.clear();
        _detailsController.clear();
        _descriptionController.clear();
        setState(() {
          _image = null;
        });
      } else {
        print("Please select an image.");
      }
    } catch (e) {
      print("Error uploading grocery: $e");
    }
  }

  void deleteGrocery(String id) async {
    await FirebaseFirestore.instance.collection('grocery').doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Deleted Successfully')),
    );
  }

  void deleteAllGroceries() async {
    final collection = FirebaseFirestore.instance.collection('grocery');
    final snapshot = await collection.get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All groceries deleted successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Groceries Here'),
        backgroundColor: Colors.blue[200],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Grocery Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                TextField(
                  controller: _detailsController,
                  decoration: InputDecoration(
                    labelText: 'Grocery Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Grocery Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                _image != null
                    ? Image.file(
                  _image!,
                  height: 100,
                )
                    : Container(),
                ElevatedButton(
                  onPressed: _getImageFromGallery,
                  child: Text(
                    'Select Image',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Schyler',
                      fontSize: 20,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent[100],
                    side: BorderSide(color: Colors.green),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _uploadGrocery,
                  child: Text(
                    'Add Grocery',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Schyler',
                      fontSize: 20,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent[100],
                    side: BorderSide(color: Colors.green),
                  ),
                ),
                SizedBox(height: 20.0),
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.40,
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('grocery').snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final doc = snapshot.data!.docs[index];
                            final data = doc.data() as Map<String, dynamic>;
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(data['name'] ?? 'No Title'),
                                  subtitle: Text(data['details'] ?? 'No Details'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => deleteGrocery(doc.id),
                                  ),
                                ),
                                Divider(
                                  color: Colors.black,
                                  indent: 30,
                                  endIndent: 30,
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
