import 'package:cloud_firestore/cloud_firestore.dart';

class ProPlayer {
  final String nombre;
  final String ranking;
  final String puuid;
  final String team;
  final String imgTeam;
  final String region;
  final String youtubeLink;
  final String twitchLink;

  ProPlayer({
    required this.nombre,
    required this.ranking,
    required this.puuid,
    this.team = '',
    this.imgTeam = '',
    required this.region,
    this.youtubeLink = '',
    this.twitchLink = '',
  });

  factory ProPlayer.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return ProPlayer(
      nombre: data['nombre'] ?? '',
      ranking: data['ranking'] ?? '',
      puuid: data['puuid'] ?? '',
      team: data['team'] ?? '',
      imgTeam: data['img_team'] ?? '',
      region: data['region'] ?? '',
      youtubeLink: data['youtube_link'] ?? '',
      twitchLink: data['twitch_link'] ?? '',
    );
  }
}
