import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';
import 'package:tftapp/infrastructure/models/summonername_info_model.dart';

final selectedServerProviderchallengers = StateProvider<String>((ref) => 'NA1');



final challengerPlayerNamesProvider = FutureProvider.family<List<String>, String>((ref, server) async {
  final dataSource = ref.read(tftMatchDataSourceProvider(server));
  List<SummonerInfoModel> players = await dataSource.getChallengerPlayers(server);
  return players.map((player) => player.name).toList(); // Solo devuelve nombres de jugadores
});