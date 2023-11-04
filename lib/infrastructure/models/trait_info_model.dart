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
    return TraitInfoModel(
      name: json['name'],
      numUnits: json['numUnits'],
      style: json['style'],
      tierCurrent: json['tierCurrent'],
      tierTotal: json['tierTotal'],
    );
  }
}
