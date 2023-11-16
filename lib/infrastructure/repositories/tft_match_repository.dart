import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';
import 'package:tftapp/infrastructure/models/match_info_model.dart';

class TFTMatchRepository {
  final TFTMatchDataSource _dataSource;

  TFTMatchRepository(this._dataSource);

  Future<List<String>> getMatchIdsByPUUID(String puuid) async {
    return await _dataSource.getMatchIdsByPUUID(puuid);
  }

  Future<List<MatchInfoModel>> getMatchDetailsByMatchIds(List<String> matchIds) async {
    List<MatchInfoModel> matchDetails = [];
    for (var matchId in matchIds) {
      var detail = await _dataSource.getMatchDetailsById(matchId);
      matchDetails.add(detail);
    }
    return matchDetails;
  }
}
