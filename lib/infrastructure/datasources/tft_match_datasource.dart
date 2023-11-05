import 'package:dio/dio.dart';
import 'package:tftapp/config/constants/environment.dart';
import 'package:tftapp/domain/datasources/match_datasource.dart';
import 'package:tftapp/domain/entities/history_match_entities.dart';

class TFTMatchDataSource implements TFTMatchDataSource {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.riotgames.com/tft/match/v1/',
      headers: {
        'X-Riot-Token': Environment.riotApiKey, // Reemplaza con tu propia API key
      },
    ),
  );

  @override
  Future<List<String>> getMatchIdsByPUUID(String puuid, String region) async {
    try {
      final response = await _dio.get('matches/by-puuid/$puuid/ids?region=$region');
      if (response.statusCode == 200) {
        final List<String> matchIds = List<String>.from(response.data);
        return matchIds;
      }
      throw Exception('Failed to fetch match IDs');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Future<TFTMatch> getMatchDetails(String matchId) async {
    try {
      final response = await _dio.get('matches/$matchId');
      if (response.statusCode == 200) {
        // Aquí, debes parsear la respuesta JSON en una instancia de TFTMatch
        final TFTMatch matchDetails = TFTMatch.fromJson(response.data);
        return matchDetails;
      }
      throw Exception('Failed to fetch match details');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
