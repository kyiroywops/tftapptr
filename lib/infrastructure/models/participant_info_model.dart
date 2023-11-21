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
    // Deserialización con manejo de valores nulos para enteros
    return ParticipantInfoModel(
      augments: (json['augments'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      companion: CompanionInfoModel.fromJson(json['companion']),
      goldLeft: json['gold_left'] as int? ?? 0,
      lastRound: json['last_round'] as int? ?? 0,
      level: json['level'] as int? ?? 0,
      placement: json['placement'] as int? ?? 0,
      playersEliminated: json['players_eliminated'] as int? ?? 0,
      puuid: json['puuid'] ?? '',
      timeEliminated: (json['time_eliminated'] as num?)?.toDouble() ?? 0.0,
      totalDamageToPlayers: json['total_damage_to_players'] as int? ?? 0,
      traits: (json['traits'] as List<dynamic>?)
          ?.map((e) => TraitInfoModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      units: (json['units'] as List<dynamic>?)
          ?.map((e) => UnitInfoModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}
