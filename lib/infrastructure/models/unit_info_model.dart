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
    // Manejo de valores nulos y listas que pueden venir como nulas
    return UnitInfoModel(
      characterId: json['characterId'] as String? ?? 'default_character_id',
      itemNames: (json['itemNames'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      name: json['name'] as String? ?? 'default_name',
      rarity: json['rarity'] as int? ?? 0, // Asumiendo que 0 es un valor por defecto aceptable
      tier: json['tier'] as int? ?? 0, // Asumiendo que 0 es un valor por defecto aceptable
    );
  }
}
