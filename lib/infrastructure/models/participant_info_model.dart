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


    print('Deserializando ParticipantInfoModel con JSON: $json'); // Imprime el JSON completo

    final List<dynamic>? augmentsList = json['augments'] as List?;
    final List<String> augments = augmentsList?.map((e) => e as String).toList() ?? [];
    print('Lista de augments después de la deserialización: $augments'); // Imprime la lista de augments

    final List<dynamic>? traitsList = json['traits'] as List?;
    final List<TraitInfoModel> traits = traitsList?.map((e) => TraitInfoModel.fromJson(e as Map<String, dynamic>)).toList() ?? [];
    print('Lista de traits después de la deserialización: $traits'); // Imprime la lista de traits

    final List<dynamic>? unitsList = json['units'] as List?;
    final List<UnitInfoModel> units = unitsList?.map((e) => UnitInfoModel.fromJson(e as Map<String, dynamic>)).toList() ?? [];
    print('Lista de units después de la deserialización: $units'); // Imprime la lista de units

    // Asegúrate de manejar todos los campos potencialmente nulos con el mismo patrón
    // Si algún campo puede ser nulo y no es una lista, asegúrate de proporcionar un valor por defecto 

    return ParticipantInfoModel(
      augments: augments,
      companion: CompanionInfoModel.fromJson(json['companion'] ?? {}),
      goldLeft: json['goldLeft'] ?? 0,
      lastRound: json['lastRound'] ?? 0,
      level: json['level'] ?? 0,
      placement: json['placement'] ?? 0,
      playersEliminated: json['playersEliminated'] ?? 0,
      puuid: json['puuid'] ?? '',
      timeEliminated: (json['timeEliminated'] as num?)?.toDouble() ?? 0.0,
      totalDamageToPlayers: json['totalDamageToPlayers'] ?? 0,
      traits: traits,
      units: units,
    );
  }
}
