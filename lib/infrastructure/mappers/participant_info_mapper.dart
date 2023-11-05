
import 'package:tftapp/domain/entities/match_details_entities.dart';
import 'package:tftapp/infrastructure/mappers/companion_info_mapper.dart';
import 'package:tftapp/infrastructure/mappers/trait_info_mapper.dart';
import 'package:tftapp/infrastructure/mappers/unit_info_mapper.dart';
import 'package:tftapp/infrastructure/models/participant_info_model.dart';

class ParticipantInfoMapper {
  static ParticipantInfo entityFromModel(ParticipantInfoModel model) {
    return ParticipantInfo(
      augments: model.augments,
      companion: CompanionInfoMapper.entityFromModel(model.companion),
      goldLeft: model.goldLeft,
      lastRound: model.lastRound,
      level: model.level,
      placement: model.placement,
      playersEliminated: model.playersEliminated,
      puuid: model.puuid,
      timeEliminated: model.timeEliminated,
      totalDamageToPlayers: model.totalDamageToPlayers,
      traits: model.traits.map((e) => TraitInfoMapper.entityFromModel(e)).toList(),
      units: model.units.map((e) => UnitInfoMapper.entityFromModel(e)).toList(),
    );
  }
}
