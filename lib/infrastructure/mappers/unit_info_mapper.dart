import 'package:flutt_muvi/infrastructure/models/tft/match/unit_info_model.dart';
import 'package:flutt_muvi/domain/entities/tft/match/unit_info.dart';

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
