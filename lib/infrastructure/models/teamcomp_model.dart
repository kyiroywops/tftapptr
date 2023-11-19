import 'package:cloud_firestore/cloud_firestore.dart';

class TeamComp {
  final String tier;
  final String nombreComp;
  final List<Trait> traits;
  final List<Champion> champions;

  TeamComp({required this.tier, required this.nombreComp, required this.traits, required this.champions});

  factory TeamComp.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TeamComp(
      tier: data['tier'] ?? '',
      nombreComp: data['nombreComp'] ?? '',
      traits: (data['traits'] as List<dynamic>).map((e) => Trait.fromMap(e)).toList(),
      champions: (data['champions'] as List<dynamic>).map((e) => Champion.fromMap(e)).toList(),
    );
  }
}

class Trait {
  final String nameTraits;
  final String imgTraits;
  final int valueTraits;

  Trait({required this.nameTraits, required this.imgTraits, required this.valueTraits});

  factory Trait.fromMap(Map<String, dynamic> data) {
    return Trait(
      nameTraits: data['nameTraits'] ?? '',
      imgTraits: data['imgTraits'] ?? '',
      valueTraits: data['valueTraits'] ?? 0,
    );
  }
}

class Champion {
  final String nombre;
  final String imgChampions;
  final int estrellas;
  final int valueChampion;
  final List<Item> items;

  Champion({required this.nombre, required this.imgChampions, required this.estrellas, required this.valueChampion, required this.items});

  factory Champion.fromMap(Map<String, dynamic> data) {
    return Champion(
      nombre: data['nombre'] ?? '',
      imgChampions: data['imgChampions'] ?? '',
      estrellas: data['estrellas'] ?? 0,
      valueChampion: data['valueChampion'] ?? 0,
      items: (data['items'] as List<dynamic>).map((itemData) => Item.fromMap(itemData as Map<String, dynamic>)).toList(),
    );
  }
}

class Item {
  final String imgItem;

  Item({required this.imgItem});

  factory Item.fromMap(Map<String, dynamic> data) {
    return Item(
      imgItem: data['imgItem'] ?? '',
    );
  }
}
