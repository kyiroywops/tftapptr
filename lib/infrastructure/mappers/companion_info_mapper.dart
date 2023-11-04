import 'package:flutt_muvi/infrastructure/models/tft/match/companion_info_model.dart';
import 'package:flutt_muvi/domain/entities/tft/match/companion_info.dart';

class CompanionInfoMapper {
  static CompanionInfo entityFromModel(CompanionInfoModel model) {
    return CompanionInfo(
      contentId: model.contentId,
      itemId: model.itemId,
      skinId: model.skinId,
      species: model.species,
    );
  }
}
