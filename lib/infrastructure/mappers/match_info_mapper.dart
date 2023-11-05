import 'package:tftapp/domain/entities/match_details_entities.dart';
import 'package:tftapp/infrastructure/models/match_info_model.dart';

class MatchInfoMapper {
  static MatchInfo entityFromModel(MatchInfoModel model) {
    return MatchInfo(
      dataVersion: model.dataVersion,
      matchId: model.matchId,
      participants: model.participants,
    );
  }
}
