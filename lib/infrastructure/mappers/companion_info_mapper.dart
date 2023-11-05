
import 'package:tftapp/domain/entities/match_details_entities.dart';
import 'package:tftapp/infrastructure/models/companion_info_model.dart';

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
