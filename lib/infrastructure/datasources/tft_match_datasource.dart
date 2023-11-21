import 'package:dio/dio.dart';
import 'package:tftapp/config/constants/environment.dart';
import 'package:tftapp/infrastructure/models/match_info_model.dart';

class TFTMatchDataSource {
  final Dio _dio;

  // Define un máximo de reintentos para evitar ciclos infinitos
  static const int maxRetries = 5;

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
    // Aquí puedes añadir más casos para otras regiones si es necesario
    switch (region.toLowerCase()) {
      case 'americas':
        return 'https://americas.api.riotgames.com/tft/match/v1/';
      case 'europe':
        return 'https://europe.api.riotgames.com/tft/match/v1/';
      case 'asia':
        return 'https://asia.api.riotgames.com/tft/match/v1/';
      // ...
      default:
        throw Exception('Unsupported region');
    }
  }
  Future<List<String>> getMatchIdsByPUUID(String puuid, {int retryCount = 0}) async {
      print('getMatchIdsByPUUID called with puuid: $puuid');

    try {
      final response = await _dio.get('matches/by-puuid/$puuid/ids?start=0&count=2');
      if (response.statusCode == 200) {
        return List<String>.from(response.data);
      } else {
        print('Error fetching match IDs: ${response.statusCode} - ${response.data}');
        throw Exception('Failed to fetch match IDs');
      }
    } on DioException catch (e) {
       if (e.response?.statusCode == 429) {
        if (retryCount < maxRetries) {
          print('Rate limit exceeded. Waiting 2 minutes before retrying...');
          await Future.delayed(Duration(minutes: 2));
          return getMatchIdsByPUUID(puuid, retryCount: retryCount + 1);
        } else {
          print('Max retries reached.');
          throw Exception('Error: $e');
        }
      } else {
        throw Exception('Error: $e');
      }
    
      
    }
  }

  Future<MatchInfoModel> getMatchDetailsById(String matchId, {int retryCount = 0}) async {
  print('Fetching details for match: $matchId');
  final response = await _dio.get('matches/$matchId');
  if (response.statusCode == 200) {
    print('Response data for match details: ${response.data}'); // Imprime toda la respuesta
    return MatchInfoModel.fromJson(response.data);
  } else {
    throw Exception('Failed to fetch match details');
  }
}
  }

  

  // ... (otros métodos de la clase TFTMatchDataSource) ...

