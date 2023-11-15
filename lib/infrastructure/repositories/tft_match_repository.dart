import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';
import 'package:tftapp/infrastructure/models/match_info_model.dart';
// Importa un paquete de registro como 'logger' si es necesario.
// import 'package:logger/logger.dart';

class TFTMatchRepository {
  final TFTMatchDataSource _dataSource;
  // Crea una instancia de tu logger si decides usar uno.
  // final Logger _logger = Logger();

  TFTMatchRepository(this._dataSource);

  Future<List<String>> getMatchIdsByPUUID(String puuid, String region) async {
    return await _dataSource.getMatchIdsByPUUID(puuid, region);
  }

  Future<List<MatchInfoModel>> getMatchDetailsByMatchIds(List<String> matchIds, String region) async {
    final List<Future<MatchInfoModel>> requests = matchIds.map((matchId) {
      return _dataSource.getMatchDetailsById(matchId, region);
    }).toList();

    try {
      // Ya no necesitas filtrar por null aquí si estás seguro de que el método getMatchDetailsById
      // nunca devolverá null, así que se elimina la comprobación de null.
      return await Future.wait(requests, eagerError: false);
    } catch (error) {
      // Utiliza el marco de registro aquí para registrar el error.
      // _logger.error('Error fetching match details: $error');
      // Por ahora, vamos a reemplazar print con un comentario:
      // Handle the error appropriately.
      return <MatchInfoModel>[]; // Retorna una lista vacía o maneja de otra manera.
    }
  }
}
