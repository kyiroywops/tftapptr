class TraitInfoModel {
  final String name;
  final int numUnits;
  final int style;
  final int tierCurrent;
  final int tierTotal;

  TraitInfoModel({
    required this.name,
    required this.numUnits,
    required this.style,
    required this.tierCurrent,
    required this.tierTotal,
  });

  factory TraitInfoModel.fromJson(Map<String, dynamic> json) {
    // Proporcionar valores predeterminados para los campos que pueden ser nulos
    return TraitInfoModel(
      name: json['name'] as String? ?? 'default_name',
      numUnits: json['num_units'] as int? ?? 0,
      style: json['style'] as int? ?? 0,
      tierCurrent: json['tier_current'] as int? ?? 0,
      tierTotal: json['tier_total'] as int? ?? 0,
    );
  }
}
