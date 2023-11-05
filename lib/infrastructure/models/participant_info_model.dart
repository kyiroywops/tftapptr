
import 'package:tftapp/infrastructure/models/companion_info_model.dart';
import 'package:tftapp/infrastructure/models/trait_info_model.dart';
import 'package:tftapp/infrastructure/models/unit_info_model.dart';

class ParticipantInfoModel {
  final List<String> augments;
  final CompanionInfoModel companion;
  final int goldLeft;
  final int lastRound;
  final int level;
  final int placement;
  final int playersEliminated;
  final String puuid;
  final double timeEliminated;
  final int totalDamageToPlayers;
  final List<TraitInfoModel> traits;
  final List<UnitInfoModel> units;

  ParticipantInfoModel({
    required this.augments,
    required this.companion,
    required this.goldLeft,
    required this.lastRound,
    required this.level,
    required this.placement,
    required this.playersEliminated,
    required this.puuid,
    required this.timeEliminated,
    required this.totalDamageToPlayers,
    required this.traits,
    required this.units,
  });

  factory ParticipantInfoModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> augmentsList = json['augments'];
    final List<String> augments = augmentsList.map((e) => e.toString()).toList();

    final List<dynamic> traitsList = json['traits'];
    final List<TraitInfoModel> traits = traitsList.map((e) => TraitInfoModel.fromJson(e)).toList();

    final List<dynamic> unitsList = json['units'];
    final List<UnitInfoModel> units = unitsList.map((e) => UnitInfoModel.fromJson(e)).toList();

    return ParticipantInfoModel(
      augments: augments,
      companion: CompanionInfoModel.fromJson(json['companion']),
      goldLeft: json['goldLeft'],
      lastRound: json['lastRound'],
      level: json['level'],
      placement: json['placement'],
      playersEliminated: json['playersEliminated'],
      puuid: json['puuid'],
      timeEliminated: json['timeEliminated'],
      totalDamageToPlayers: json['totalDamageToPlayers'],
      traits: traits,
      units: units,
    );
  }
}
