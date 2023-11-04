import 'package:tftapp/domain/entities/match_details_entities.dart';

abstract class TFTMatchRepository {
  Future<TFTMatch> getMatchDetails(String matchId);
}
