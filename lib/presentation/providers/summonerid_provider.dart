import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';
import 'package:tftapp/infrastructure/models/summonername_info_model.dart';
import 'package:tftapp/infrastructure/repositories/summonerid_repository.dart';

final summonerProvider = FutureProvider.family<SummonerInfoModel, String>((ref, summonerName) async {
  // Aquí debes crear una instancia del data source con el servidor seleccionado
  // Esto podría implicar leer otro provider para obtener el servidor actual
  String selectedServer = 'NA1'; // Por ejemplo, este valor podría venir de otro provider

  final dataSource = TFTMatchDataSource(selectedServer);
  final repository = SummonerRepository(dataSource);
  return repository.fetchSummonerInfo(summonerName, selectedServer);
});
