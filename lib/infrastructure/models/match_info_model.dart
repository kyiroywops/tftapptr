import 'package:tftapp/infrastructure/models/participant_info_model.dart';

class MatchInfoModel {
  final String dataVersion;
  final String matchId;
  final List<ParticipantInfoModel> participants;  // Cambio de List<String> a List<ParticipantInfoModel>

  MatchInfoModel({
    required this.dataVersion,
    required this.matchId,
    required this.participants,
  });

  factory MatchInfoModel.fromJson(Map<String, dynamic> json) {
    // Asegúrate de convertir la lista a una lista de ParticipantInfoModel y no de String
    final List<ParticipantInfoModel> participants = (json['participants'] as List)
        .map((e) => ParticipantInfoModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return MatchInfoModel(
      dataVersion: json['dataVersion'],
      matchId: json['matchId'],
      participants: participants,
    );
  }
}
