class CompanionInfoModel {
  final String contentId;
  final int itemId;
  final int skinId;
  final String species;

  CompanionInfoModel({
    required this.contentId,
    required this.itemId,
    required this.skinId,
    required this.species,
  });

  factory CompanionInfoModel.fromJson(Map<String, dynamic> json) {
    return CompanionInfoModel(
      contentId: json['contentId'],
      itemId: json['itemId'],
      skinId: json['skinId'],
      species: json['species'],
    );
  }
}
