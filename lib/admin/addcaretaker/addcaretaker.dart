import 'dart:io';

import 'package:elderscareapp/admin/addcaretaker/adminviewcaretaker.dart';
import 'package:elderscareapp/home/healthtips/healthtipabove.dart';
import 'package:elderscareapp/home/caretaker/viewcaretaker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class addcaretaker extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<addcaretaker> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController adressController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  File? _selectedImage; // Define _selectedImage here

  Future<void> _getImageFromGallery() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  void submitHealthTip() async {
    if (_selectedImage == null) {
      return; // Don't submit if no image is selected
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Uploaded Succesfully')),
      );
    }

    final imageUrl = await _uploadImageToFirestore();

    await FirebaseFirestore.instance.collection('caretaker').add({
      'name': nameController.text,
      'Adress': adressController.text,
      'imageUrl': imageUrl,
      'Experience': experienceController.text,
      'contact number': contactController.text,
      'price':priceController.text,
      'timestamp': Timestamp.now(),
    });
  }

  Future<String> _uploadImageToFirestore() async {
    final firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('caretaker_images')
        .child(DateTime.now().toString() + '.jpg');

    await firebaseStorageRef.putFile(_selectedImage!);
    return await firebaseStorageRef.getDownloadURL();
  }

  void deleteHealthTip(String id) async {
    await FirebaseFirestore.instance.collection('caretaker').doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Deleted Successfully')),
    );
  }

  void deleteAllHealthTips() async {
    final collection = FirebaseFirestore.instance.collection('caretaker');
    final snapshot = await collection.get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All caretakers deleted successfully')),
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Here'),
        backgroundColor: Colors.blue[100],
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => viewcareadmin(),));
            }, child:Text("View Added Details",style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent[100],side: BorderSide(color: Colors.green)
            ),),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("",style: TextStyle(fontFamily: 'Schyler',fontSize: 18),),
              if (_selectedImage != null) Image.file(_selectedImage!),
              ElevatedButton(
                onPressed: _getImageFromGallery,
                child: Text('Select Image from Gallery',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent[100],side: BorderSide(color: Colors.green)
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name',border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: adressController,
                maxLines: 6,
                decoration: InputDecoration(labelText: 'Adress',border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: experienceController,
                decoration: InputDecoration(labelText: 'Experience',border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: contactController,
                decoration: InputDecoration(labelText: 'Contact details',border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price',border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: submitHealthTip,
                child: Text('Submit',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent[100],side: BorderSide(color: Colors.green)
                ),),

              SizedBox(height: 20.0),
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  color: Colors.blue[100],
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('caretaker').snapshots(),
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
                          return ListTile(
                            title: Text(data['name'] ?? 'No name'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data['Adress'] ?? 'No address'),
                                Text(data['price'] ?? 'No price available'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteHealthTip(doc.id),
                            ),
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
