import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tftapp/infrastructure/models/teamcomp_model.dart';

class TeamCompRepository {
  final FirebaseFirestore _firestore;

  TeamCompRepository({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<TeamComp>> watchAllTeamComps() {
    return _firestore.collection('teamComps').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => TeamComp.fromFirestore(doc)).toList();
    });
  }

  Future<List<TeamComp>> getAllTeamComps() async {
    final snapshot = await _firestore.collection('teamComps').get();
    return snapshot.docs.map((doc) => TeamComp.fromFirestore(doc)).toList();
  }
}
