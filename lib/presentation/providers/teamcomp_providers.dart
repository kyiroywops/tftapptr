import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/infrastructure/repositories/teamcomp_repository.dart';

final teamCompRepositoryProvider = Provider<TeamCompRepository>((ref) {
  return TeamCompRepository();
});

final teamCompsStreamProvider = StreamProvider.autoDispose((ref) {
  final repository = ref.watch(teamCompRepositoryProvider);
  return repository.watchAllTeamComps();
});
