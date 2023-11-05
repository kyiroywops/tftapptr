import 'package:tftapp/domain/entities/match_details_entities.dart';
import 'package:tftapp/infrastructure/mappers/participant_info_mapper.dart';
import 'package:tftapp/infrastructure/models/match_info_model.dart';

class MatchInfoMapper {
  static MatchInfo entityFromModel(MatchInfoModel model) {
    return MatchInfo(
      dataVersion: model.dataVersion,
      matchId: model.matchId,
      participants: model.participants.map((participantModel) {
        // Aquí asumimos que participantModel es del tipo ParticipantInfoModel
        return ParticipantInfoMapper.entityFromModel(participantModel);
      }).toList(),
      // ... el resto de las propiedades
    );
  }
}
