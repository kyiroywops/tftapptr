// import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';
// import 'package:tftapp/infrastructure/models/match_info_model.dart';

// class TFTMatchRepository {
//   final TFTMatchDataSource _dataSource;

//   TFTMatchRepository(this._dataSource);

//   Future<List<String>> getMatchIdsByPUUID(String puuid, String region) async {
//     return await _dataSource.getMatchIdsByPUUID(puuid, region);
//   }

//   Future<List<MatchInfoModel>> getMatchDetailsByMatchIds(List<String> matchIds, String region) async {
//     final List<MatchInfoModel> matchDetails = [];

//     for (final matchId in matchIds) {
//       final matchDetail = await _dataSource.getMatchDetailsById(matchId, region);
//       matchDetails.add(matchDetail); 
//     }

//     return matchDetails;
//   }
// }
