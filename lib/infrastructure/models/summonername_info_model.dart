class SummonerInfoModel {
  final String puuid;
  final String name;
  final String region; // Agrega este campo para almacenar la región

  SummonerInfoModel({
    required this.puuid,
    required this.name,
    required this.region, // Haz que la región sea un parámetro requerido
  });

  // Actualiza el método fromJson si obtienes la región de la respuesta de la API,
  // o establece la región manualmente después de crear el objeto.
  factory SummonerInfoModel.fromJson(Map<String, dynamic> json, String region) {
    return SummonerInfoModel(
      puuid: json['puuid'],
      name: json['name'],
      region: region, // Asigna la región aquí
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'puuid': puuid,
      'name': name,
      'region': region, // Incluye la región en la serialización a JSON si es necesario
    };
  }
}
