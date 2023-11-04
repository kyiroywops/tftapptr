import 'package:flutt_muvi/infrastructure/models/tft/match/trait_info_model.dart';
import 'package:flutt_muvi/domain/entities/tft/match/trait_info.dart';

class TraitInfoMapper {
  static TraitInfo entityFromModel(TraitInfoModel model) {
    return TraitInfo(
      name: model.name,
      numUnits: model.numUnits,
      style: model.style,
      tierCurrent: model.tierCurrent,
      tierTotal: model.tierTotal,
    );
  }
}
