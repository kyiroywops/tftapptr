class SummonerInfoModel {
  final String puuid;
  final String name;

  SummonerInfoModel({
    required this.puuid,
    required this.name,
  });

  factory SummonerInfoModel.fromJson(Map<String, dynamic> json) {
    return SummonerInfoModel(
      puuid: json['puuid'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'puuid': puuid,
      'name': name,
    };
  }
}
