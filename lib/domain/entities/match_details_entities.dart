class TFTMatch {
  final MatchMetadata metadata;
  final MatchInfo info;

  TFTMatch({
    required this.metadata,
    required this.info,
  });
}

class MatchMetadata {
  final String dataVersion;
  final String matchId;
  final List<String> participants;

  MatchMetadata({
    required this.dataVersion,
    required this.matchId,
    required this.participants,
  });
}

class MatchInfo {
  final DateTime gameDateTime;
  final double gameLength;
  final String gameVersion;
  final List<ParticipantInfo> participants;

  MatchInfo({
    required this.gameDateTime,
    required this.gameLength,
    required this.gameVersion,
    required this.participants,
  });
}

class ParticipantInfo {
  final List<String> augments;
  final CompanionInfo companion;
  final int goldLeft;
  final int lastRound;
  final int level;
  final int placement;
  final int playersEliminated;
  final String puuid;
  final double timeEliminated;
  final int totalDamageToPlayers;
  final List<TraitInfo> traits;
  final List<UnitInfo> units;

  ParticipantInfo({
    required this.augments,
    required this.companion,
    required this.goldLeft,
    required this.lastRound,
    required this.level,
    required this.placement,
    required this.playersEliminated,
    required this.puuid,
    required this.timeEliminated,
    required this.totalDamageToPlayers,
    required this.traits,
    required this.units,
  });
}

class CompanionInfo {
  final String contentId;
  final int itemId;
  final int skinId;
  final String species;

  CompanionInfo({
    required this.contentId,
    required this.itemId,
    required this.skinId,
    required this.species,
  });
}

class TraitInfo {
  final String name;
  final int numUnits;
  final int style;
  final int tierCurrent;
  final int tierTotal;

  TraitInfo({
    required this.name,
    required this.numUnits,
    required this.style,
    required this.tierCurrent,
    required this.tierTotal,
  });
}

class UnitInfo {
  final String characterId;
  final List<String> itemNames;
  final String name;
  final int rarity;
  final int tier;

  UnitInfo({
    required this.characterId,
    required this.itemNames,
    required this.name,
    required this.rarity,
    required this.tier,
  });
}
