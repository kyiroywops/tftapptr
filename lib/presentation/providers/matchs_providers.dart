import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/infrastructure/repositories/tft_match_repository.dart';
import 'package:tftapp/infrastructure/models/match_info_model.dart';
import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';

final tftMatchRepositoryProvider = Provider.family<TFTMatchRepository, String>((ref, region) {
  final dataSource = TFTMatchDataSource(region);
  return TFTMatchRepository(dataSource);
});

final matchIdsProvider = FutureProvider.family<List<String>, Map<String, String>>((ref, params) async {
  final region = params['region'] ?? 'americas';
  final puuid = params['puuid']!;
  final repository = ref.watch(tftMatchRepositoryProvider(region));
  return repository.getMatchIdsByPUUID(puuid);
});

final matchDetailsProvider = FutureProvider.family<List<MatchInfoModel>, Map<String, dynamic>>((ref, params) async {
  final region = params['region'] ?? 'americas';
  final matchIds = params['matchIds'] as List<String>;
  final repository = ref.watch(tftMatchRepositoryProvider(region));
  return repository.getMatchDetailsByMatchIds(matchIds);
});
