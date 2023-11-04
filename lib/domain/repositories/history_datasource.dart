
import 'package:tftapp/domain/entities/history_match_entitites.dart';

abstract class TFTMatchIdsRepository {
  Future<TFTMatchInfo> getMatchIdsByPUUID({
    required String puuid,
    required String region,
    required String apiKey,
  });
}
