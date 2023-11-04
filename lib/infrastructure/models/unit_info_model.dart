class UnitInfoModel {
  final String characterId;
  final List<String> itemNames;
  final String name;
  final int rarity;
  final int tier;

  UnitInfoModel({
    required this.characterId,
    required this.itemNames,
    required this.name,
    required this.rarity,
    required this.tier,
  });

  factory UnitInfoModel.fromJson(Map<String, dynamic> json) {
    return UnitInfoModel(
      characterId: json['characterId'],
      itemNames: List<String>.from(json['itemNames']),
      name: json['name'],
      rarity: json['rarity'],
      tier: json['tier'],
    );
  }
}
