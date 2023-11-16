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
    final List<dynamic> participantsJson = json['participants'] as List<dynamic>? ?? [];
    final List<ParticipantInfoModel> participants = participantsJson
        .map((e) => ParticipantInfoModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return MatchInfoModel(
      dataVersion: json['dataVersion'] as String? ?? 'Unknown',
      matchId: json['matchId'] as String? ?? 'Unknown',
      participants: participants,
    );
  }
}
