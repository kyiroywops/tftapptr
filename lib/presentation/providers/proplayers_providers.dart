import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/infrastructure/models/proplayers_model.dart';
import 'package:tftapp/infrastructure/repositories/proplayers_repository.dart';

// Provider for the repository
final proPlayersRepositoryProvider = Provider<ProPlayersRepository>((ref) {
  return ProPlayersRepository();
});

// Stream provider to watch pro players data
final proPlayersStreamProvider = StreamProvider.autoDispose<List<ProPlayer>>((ref) {
  final repository = ref.watch(proPlayersRepositoryProvider);
  return repository.watchAllProPlayers();
});
