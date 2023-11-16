import 'package:tftapp/infrastructure/models/participant_info_model.dart';

class MatchInfoModel {
  final String dataVersion;
  final String matchId;
  final List<ParticipantInfoModel> participants;

  MatchInfoModel({
    required this.dataVersion,
    required this.matchId,
    required this.participants,
  });

  factory MatchInfoModel.fromJson(Map<String, dynamic> json) {
    final dataVersion = json['metadata']['data_version'] as String? ?? 'Unknown';
    final matchId = json['metadata']['match_id'] as String? ?? 'Unknown';
    final participantsJson = json['info']['participants'] as List<dynamic>? ?? [];

    final participants = participantsJson
        .map((e) => ParticipantInfoModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return MatchInfoModel(
      dataVersion: dataVersion,
      matchId: matchId,
      participants: participants,
    );
  }
}
