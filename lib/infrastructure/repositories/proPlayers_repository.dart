import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tftapp/infrastructure/models/proplayers_model.dart';

class ProPlayersRepository {
  final FirebaseFirestore _firestore;

  ProPlayersRepository({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<ProPlayer>> watchAllProPlayers() {
    return _firestore.collection('proPlayers').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ProPlayer.fromFirestore(doc)).toList();
    });
  }

  Future<List<ProPlayer>> getAllProPlayers() async {
    final snapshot = await _firestore.collection('proPlayers').get();
    return snapshot.docs.map((doc) => ProPlayer.fromFirestore(doc)).toList();
  }
}
