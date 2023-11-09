import 'package:dio/dio.dart';
import 'package:tftapp/config/constants/environment.dart';
import 'package:tftapp/infrastructure/models/match_info_model.dart';

class TFTMatchDataSource {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.riotgames.com/tft/match/v1/',
      headers: {
        'X-Riot-Token': Environment.riotApiKey, 
      },
    ),
  );

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

  Future<MatchInfoModel> getMatchDetailsById(String matchId, String region) async {
    try {
      final response = await _dio.get('matches/$matchId?region=$region');
      if (response.statusCode == 200) {
        final MatchInfoModel matchDetails = MatchInfoModel.fromJson(response.data);
        return matchDetails;
      }
      throw Exception('Failed to fetch match details');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
