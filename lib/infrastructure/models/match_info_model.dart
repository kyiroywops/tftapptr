import 'package:tftapp/infrastructure/models/participant_info_model.dart';

class MatchInfoModel {
  final String dataVersion;
  final String matchId;
  final List<ParticipantInfoModel> participants;
  final DateTime gameDatetime; // Campo agregado para almacenar la fecha del juego

  MatchInfoModel({
    required this.dataVersion,
    required this.matchId,
    required this.participants,
    required this.gameDatetime, // Agregar en el constructor
  });

  factory MatchInfoModel.fromJson(Map<String, dynamic> json) {
    final dataVersion = json['metadata']['data_version'] as String? ?? 'Unknown';
    final matchId = json['metadata']['match_id'] as String? ?? 'Unknown';
    final participantsJson = json['info']['participants'] as List<dynamic>? ?? [];

    final participants = participantsJson
        .map((e) => ParticipantInfoModel.fromJson(e as Map<String, dynamic>))
        .toList();

    // Convertir el timestamp en milisegundos a DateTime
    final gameDatetime = DateTime.fromMillisecondsSinceEpoch(json['info']['game_datetime']);

    return MatchInfoModel(
      dataVersion: dataVersion,
      matchId: matchId,
      participants: participants,
      gameDatetime: gameDatetime, // Asignar el valor convertido
    );
  }
}
