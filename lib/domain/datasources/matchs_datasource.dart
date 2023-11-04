import 'package:tftapp/domain/entities/match_entities.dart';

abstract class TFTMatchDataSource {
  Future<TFTMatch> getMatchDetails(String matchId);
}
