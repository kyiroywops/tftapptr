import 'package:dio/dio.dart';

class TFTMatchDatasource {
  final Dio dio;

  TFTMatchDatasource({required this.dio});

  Future<List<String>> getMatchIdsByPUUID(String puuid) async {
    try {
      final response = await dio.get('/tft/match/v1/matches/by-puuid/$puuid/ids');
      if (response.statusCode == 200) {
        final List<dynamic> matchIds = response.data;
        return matchIds.cast<String>();
      } else {
        throw Exception('Failed to get match IDs');
      }
    } catch (e) {
      throw Exception('Failed to get match IDs: $e');
    }
  }
}












// import 'package:dio/dio.dart';
// import 'package:tftapp/config/constants/environment.dart';
// import 'package:tftapp/domain/datasources/history_datasource.dart';

// // import 'package:your_project/infrastructure/models/tft_match/tft_match_response.dart'; // Asegúrate de importar tus propios modelos aquí

// class TFTMatchDatasource extends TFTMatchIdsDatasource {
//   final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: 'https://api.riotgames.com/tft/match/v1/',
//       headers: {
//         'X-Riot-Token': Enviroment.riotApiKey, // Usa tu propia API key aquí
//       },
//     ),
//   );

//   @override
//   Future<List<String>> getMatchIdsByPUUID(String puuid, String region) async {
//     try {
//       final response = await _dio.get('matches/by-puuid/$puuid/ids?region=$region');
//       if (response.statusCode == 200) {
//         final List<String> matchIds = List<String>.from(response.data);
//         return matchIds;
//       }
//       throw Exception('Failed to fetch match IDs');
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }

//   @override
//   Future<TFTMatchResponse> getMatchDetailsById(String matchId, String region) async {
//     try {
//       final response = await _dio.get('matches/$matchId?region=$region');
//       if (response.statusCode == 200) {
//         final TFTMatchResponse matchDetails = TFTMatchResponse.fromJson(response.data);
//         return matchDetails;
//       }
//       throw Exception('Failed to fetch match details');
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }
// }
