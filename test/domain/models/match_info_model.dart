class MatchInfoModel {
  final String dataVersion;
  final String matchId;
  final List<String> participants;

  MatchInfoModel({
    required this.dataVersion,
    required this.matchId,
    required this.participants,
  });

  factory MatchInfoModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> participantsList = json['participants'];
    final List<String> participants = participantsList.map((e) => e.toString()).toList();

    return MatchInfoModel(
      dataVersion: json['dataVersion'],
      matchId: json['matchId'],
      participants: participants,
    );
  }
}
