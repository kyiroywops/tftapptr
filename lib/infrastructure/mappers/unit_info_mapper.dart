
import 'package:tftapp/domain/entities/match_details_entities.dart';
import 'package:tftapp/infrastructure/models/unit_info_model.dart';

class UnitInfoMapper {
  static UnitInfo entityFromModel(UnitInfoModel model) {
    return UnitInfo(
      characterId: model.characterId,
      itemNames: model.itemNames,
      name: model.name,
      rarity: model.rarity,
      tier: model.tier,
    );
  }
}
