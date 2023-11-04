import 'package:tftapp/domain/entities/match_details_entities.dart';

abstract class TFTMatchDataSource {
  Future<TFTMatch> getMatchDetails(String matchId);
}
