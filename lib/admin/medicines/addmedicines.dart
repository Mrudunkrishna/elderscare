import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class Addmedicine extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<Addmedicine> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _descriptionControll = TextEditingController();
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

  void _uploadMedicine() async {
    String name = _nameController.text;
    String details = _detailsController.text;
    String description = _descriptionControll.text;

    try {
      if (_image != null) {
        Reference ref = _storage.ref().child("medicine_images/$name");
        await ref.putFile(_image!);


        String imageUrl = await ref.getDownloadURL();

        await _firestore.collection('medicines').doc().set({
          'name': name,
          'details': details,
          'description': description,
          'image': imageUrl,
        });

        _nameController.clear();
        _detailsController.clear();
        setState(() {
          _image = null;
        });
      } else {
        print("Please select an image.");
      }
    } catch (e) {
      print("Error uploading medicine: $e");
    }
  }

  void deletemedicine(String id) async {
    await FirebaseFirestore.instance.collection('medicines').doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Deleted Successfully')),
    );
  }

  void deleteAllmedicines() async {
    final collection = FirebaseFirestore.instance.collection('medicines');
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
        title: Text('Add Medicines Here'),
        backgroundColor: Colors.blue[200],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Medicine Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 25,),
              TextField(
                controller: _detailsController,
                decoration: InputDecoration(labelText: 'Medicine Price',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 25),
              TextField(
                controller: _descriptionControll,
                decoration: InputDecoration(
                  labelText: 'Medicine Description',
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
                child: Text('Select Image',style: TextStyle(color: Colors.white
                    ,fontFamily: 'Schyler',fontSize: 20),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent[100],side: BorderSide(color: Colors.green)
                ),),
        
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _uploadMedicine,
                child: Text('Add Medicine',style: TextStyle(color: Colors.white
                    ,fontFamily: 'Schyler',fontSize: 20),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent[100],side: BorderSide(color: Colors.green)
                ),),
        
        
              SizedBox(height: 50.0),
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height*0.45,
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
                    stream: FirebaseFirestore.instance.collection('medicines').snapshots(),
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
                                subtitle: Text(data['details'] ?? 'No Description'),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => deletemedicine(doc.id),
                                ),
                              ),
                              Divider(color: Colors.black,indent: 30,endIndent: 30,)
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
    );
  }
}
