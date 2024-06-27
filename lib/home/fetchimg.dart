import 'package:flutter/material.dart';

class FetchPage extends StatelessWidget {
  final String imageUrl;

  const FetchPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetched Image'),
      ),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}