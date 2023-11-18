import 'package:cloud_firestore/cloud_firestore.dart';

class PatchNote {
  final DateTime date;
  final String id;
  final String imageUrl;
  final String title;
  final String version;
  final String content;

  PatchNote({
    required this.date,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.version,
    required this.content,
  });

  factory PatchNote.fromMap(Map<String, dynamic> map, String documentId) {
    return PatchNote(
      date: (map['date'] as Timestamp).toDate(),
      id: documentId,
      imageUrl: map['image_url'] as String,
      title: map['title'] as String,
      version: map['version'] as String,
      content: map['content'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDate(date),
      'image_url': imageUrl,
      'title': title,
      'version': version,
      'content': content,
    };
  }
}


