import 'package:flutt_muvi/infrastructure/models/tft/match/participant_info_model.dart';
import 'package:flutt_muvi/domain/entities/tft/match/participant_info.dart';
import 'package:flutt_muvi/infrastructure/mappers/tft/match/companion_info_mapper.dart';
import 'package:flutt_muvi/infrastructure/mappers/tft/match/trait_info_mapper.dart';
import 'package:flutt_muvi/infrastructure/mappers/tft/match/unit_info_mapper.dart';

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
