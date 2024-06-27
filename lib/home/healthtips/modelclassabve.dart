import 'package:cloud_firestore/cloud_firestore.dart';

class HealthTip {
  final String title;
  final String description;
  final String imageUrl;
  final String waterLevel;
  final String bpLevel;
  final String cholesterolLevel;
  final String sugarLevel;
  final Timestamp timestamp;

  HealthTip({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.waterLevel,
    required this.bpLevel,
    required this.cholesterolLevel,
    required this.sugarLevel,
    required this.timestamp,
  });

  factory HealthTip.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return HealthTip(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      waterLevel: data['waterLevel'] ?? '',
      bpLevel: data['bpLevel'] ?? '',
      cholesterolLevel: data['cholesterolLevel'] ?? '',
      sugarLevel: data['sugarLevel'] ?? '',
      timestamp: data['timestamp'],
    );
  }
}
