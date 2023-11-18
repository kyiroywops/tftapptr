import 'package:cloud_firestore/cloud_firestore.dart';

class PatchNotesRepository {
  final FirebaseFirestore _firestore;

  PatchNotesRepository({FirebaseFirestore? firestore}) 
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<PatchNote>> watchAllPatchNotes() {
    return _firestore.collection('patchNotes').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => PatchNote.fromFirestore(doc)).toList();
    });
  }
}

class PatchNote {
  final String title;
  final String content;
  final DateTime releaseDate;
  final String version;
  final String imageUrl;

  PatchNote({
    required this.title,
    required this.content,
    required this.releaseDate,
    required this.version,
    required this.imageUrl,
  });

  factory PatchNote.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PatchNote(
      title: data['title'],
      content: data['content'],
      releaseDate: (data['date'] as Timestamp).toDate(),
      version: data['version'],
      imageUrl: data['image_url'],
    );
  }
}
