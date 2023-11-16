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
    // Se proporcionan valores predeterminados en caso de que los campos sean nulos.
    return CompanionInfoModel(
      contentId: json['contentId'] as String? ?? 'default_content_id',
      itemId: json['itemId'] as int? ?? 0, // Suponiendo que 0 es un valor predeterminado aceptable
      skinId: json['skinId'] as int? ?? 0, // Suponiendo que 0 es un valor predeterminado aceptable
      species: json['species'] as String? ?? 'default_species',
    );
  }
}
