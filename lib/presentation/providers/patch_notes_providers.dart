import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tftapp/infrastructure/repositories/patchNotes_repository.dart';

final patchNotesRepositoryProvider = Provider<PatchNotesRepository>((ref) {
  return PatchNotesRepository(firestore: FirebaseFirestore.instance);
});

final patchNotesStreamProvider = StreamProvider.autoDispose<List<PatchNote>>((ref) {
  final repository = ref.watch(patchNotesRepositoryProvider);
  return repository.watchAllPatchNotes();
});
