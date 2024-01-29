import 'package:tftapp/infrastructure/models/match_info_model.dart';
import 'package:tftapp/infrastructure/models/summonername_info_model.dart';

class SummonerInfoWithMatches {
  final SummonerInfoModel summonerInfo;
  final List<MatchInfoModel> matches;

  SummonerInfoWithMatches(this.summonerInfo, this.matches);
}
