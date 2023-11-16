import 'package:dio/dio.dart';
import 'package:tftapp/config/constants/environment.dart';
import 'package:tftapp/infrastructure/models/match_info_model.dart';

class TFTMatchDataSource {
  final Dio _dio;

  TFTMatchDataSource(String region)
      : _dio = Dio(
          BaseOptions(
            baseUrl: _getBaseUrl(region),
            headers: {
              'X-Riot-Token': Environment.riotApiKey,
            },
          ),
        );

  static String _getBaseUrl(String region) {
    switch (region.toLowerCase()) {
      case 'americas':
        return 'https://americas.api.riotgames.com/tft/match/v1/';
      case 'asia':
        return 'https://asia.api.riotgames.com/tft/match/v1/';
      case 'europe':
        return 'https://europe.api.riotgames.com/tft/match/v1/';
      default:
        throw Exception('Unsupported region');
    }
  }

  Future<List<String>> getMatchIdsByPUUID(String puuid) async {
    try {
      final response = await _dio.get('matches/by-puuid/$puuid/ids?start=0&count=20');
      if (response.statusCode == 200) {
        return List<String>.from(response.data);
      }
      throw Exception('Failed to fetch match IDs');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<MatchInfoModel> getMatchDetailsById(String matchId) async {
    try {
      final response = await _dio.get('matches/$matchId');
      if (response.statusCode == 200) {
        return MatchInfoModel.fromJson(response.data);
      }
      throw Exception('Failed to fetch match details');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
