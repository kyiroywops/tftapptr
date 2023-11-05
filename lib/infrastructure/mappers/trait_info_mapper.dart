
import 'package:tftapp/domain/entities/match_details_entities.dart';
import 'package:tftapp/infrastructure/models/trait_info_model.dart';

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
