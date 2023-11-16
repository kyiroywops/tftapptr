import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/infrastructure/repositories/tft_match_repository.dart';
import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';

final tftMatchRepositoryProvider = Provider.family<TFTMatchRepository, String>((ref, region) {
  return TFTMatchRepository(TFTMatchDataSource(region));
});

final matchIdsProvider = FutureProvider.family<List<String>, Map<String, String>>((ref, params) {
  final repository = ref.watch(tftMatchRepositoryProvider(params['region'] ?? 'default_region'));
  return repository.getMatchIdsByPUUID(params['puuid']!);
});
