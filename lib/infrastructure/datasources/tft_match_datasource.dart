import 'package:dio/dio.dart';
import 'package:tftapp/config/constants/environment.dart';
import 'package:tftapp/infrastructure/models/match_info_model.dart';
import 'package:tftapp/infrastructure/models/summonername_info_model.dart';

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

  static String _getBaseUrl(String server) {
      // Mapa de servidores a regiones
      const serverToRegion = {
        'BR1': 'americas',
        'LA1': 'americas',
        'LA2': 'americas',
        'NA1': 'americas',
        'americas' : 'americas',
        // ... [otros servidores de Americas]
        'EUN1': 'europe',
        'EUW1': 'europe',
        'TR1': 'europe',
        'RU': 'europe',
        // ... [otros servidores de Europa]
        'KR': 'asia',
        'JP1': 'asia',
        // ... [otros servidores de Asia]
        'OC1': 'apac',
        'PH2': 'apac',
        'VN2': 'apac',
        // ... [otros servidores de APAC]
      };

    // Obtener la región correspondiente al servidor
    String region = serverToRegion[server.toLowerCase()] ?? 'americas'; // Valor por defecto

    // Construir la URL base
    return 'https://${region}.api.riotgames.com/tft/match/v1/';
  }




  Future<List<String>> getMatchIdsByPUUID(String puuid,
      {int retryCount = 0}) async {
    print('getMatchIdsByPUUID called with puuid: $puuid');

    try {
      final response =
          await _dio.get('matches/by-puuid/$puuid/ids?start=0&count=5');
      if (response.statusCode == 200) {
        return List<String>.from(response.data);
      } else {
        print(
            'Error fetching match IDs: ${response.statusCode} - ${response.data}');
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

  Future<MatchInfoModel> getMatchDetailsById(String matchId,
      {int retryCount = 0}) async {
    print('Fetching details for match: $matchId');
    final response = await _dio.get('matches/$matchId');
    if (response.statusCode == 200) {
      print(
          'Response data for match details: ${response.data}'); // Imprime toda la respuesta
      return MatchInfoModel.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch match details');
    }
  }
Future<SummonerInfoModel> getSummonerInfoBySummonerName(
    String summonerName, String region) async {
  try {
    final response = await _dio.get(
      'https://$region.api.riotgames.com/lol/summoner/v4/summoners/by-name/$summonerName',
    );
    if (response.statusCode == 200) {
      // Agrega la región al crear el objeto SummonerInfoModel
      return SummonerInfoModel.fromJson(response.data, region);
    } else {
      throw Exception('Failed to fetch summoner info for name: $summonerName');
    }
  } on DioException catch (e) {
    throw Exception('Error fetching summoner info: $e');
  }
}

}