import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';
import 'package:tftapp/infrastructure/models/summonername_info_model.dart';
import 'package:tftapp/infrastructure/repositories/summonerid_repository.dart';

// Un StateProvider para mantener el servidor seleccionado
final selectedServerProvider = StateProvider<String>((ref) => 'NA1');

// Un FutureProvider family que recibe una cadena con el nombre del invocador y el servidor
final summonerProvider = FutureProvider.family<SummonerInfoModel, String>((ref, combinedParams) async {
  // Separar el nombre del invocador y el servidor
  var parts = combinedParams.split('|');
  String summonerName = parts[0];
  String selectedServer = parts.length > 1 ? parts[1] : 'NA1'; // Usar 'NA1' como valor por defecto

  // Crear una instancia de TFTMatchDataSource con el servidor seleccionado
  final dataSource = TFTMatchDataSource(selectedServer);
  final repository = SummonerRepository(dataSource);
  
  // Devolver la información del invocador
  return repository.fetchSummonerInfo(summonerName);
});
