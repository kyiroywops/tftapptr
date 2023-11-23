import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';
import 'package:tftapp/infrastructure/models/summonername_info_model.dart';

class SummonerRepository {
  final TFTMatchDataSource _dataSource;

  SummonerRepository(this._dataSource);

  Future<SummonerInfoModel> fetchSummonerInfo(String summonerName, String region) async {
    try {
      return await _dataSource.getSummonerInfoBySummonerName(summonerName, region);
    } catch (e) {
      // Puedes manejar errores específicos o simplemente propagarlos
      throw Exception('Error fetching summoner info: $e');
    }
  }
}
