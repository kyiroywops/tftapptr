import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tftapp/domain/usecases/formatTimeAgoUseCases.dart';
import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';
import 'package:tftapp/infrastructure/models/match_info_model.dart';
import 'package:tftapp/infrastructure/models/proplayers_model.dart';
import 'package:tftapp/infrastructure/models/trait_info_model.dart';
import 'package:tftapp/presentation/providers/proplayers_providers.dart';
import 'package:url_launcher/url_launcher.dart';

class ProPlayersScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proPlayersAsyncValue = ref.watch(proPlayersStreamProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          'ProPlayers Tracker',
          style: TextStyle(
            fontFamily: 'ReadexPro',
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: proPlayersAsyncValue.when(
        data: (proPlayers) => _ProPlayersScreenBody(proPlayers: proPlayers),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

Widget buildAugmentsInfo(List<String> augments) {
  return Container(
    height: 40, // Ajusta la altura según tus necesidades
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: augments.length,
      itemBuilder: (context, index) {
        String augment = augments[index];
        // Elimina el prefijo 'TFT9_' del nombre del augment
        String cleanedName = augment
            .replaceFirst('TFT10_', '')
            .replaceFirst('Augment_', '')
            .replaceFirst('TFT6_', '')
            .replaceFirst('TFT9_', '');

        return Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Text(
                'Augment',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'ReadexPro',
                    fontWeight: FontWeight.bold),
              ),
              // Opcional: Añadir un ícono o imagen antes del texto si lo deseas
              // Image.asset('path/to/icon.png', width: 24, height: 24),
              SizedBox(width: 8), // Espacio entre el ícono y el texto
              Text(
                cleanedName, // Usa el nombre limpio del augment
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget buildTraitsInfo(List<TraitInfoModel> traits) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
      height: 40, // Ajusta la altura según tus necesidades
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: traits.where((trait) => trait.tierCurrent > 0).length,
        itemBuilder: (context, index) {
          TraitInfoModel trait =
              traits.where((trait) => trait.tierCurrent > 0).elementAt(index);
          // Elimina los prefijos 'Set9_', 'Set9b_', y 'Set9_'
          String cleanedName = trait.name.replaceAll(RegExp(r'Set9b?_?'), '');
    
          // Ruta del asset
          String traitAssetPath = 'assets/tft-trait/$cleanedName.png';
    
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Image.asset(
                  traitAssetPath,
                  width: 20, // Ajusta el tamaño según tus necesidades
                  height: 20,
                ),
    
                const SizedBox(
                    width: 5), // Espacio entre el nombre y el número de unidades
                Text(
                  trait.numUnits.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ReadexPro',
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

Widget buildRankingAndRegionInfo(String ranking, String region) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.leaderboard,
          color: Colors.white,
          size: 15,
        ), // Icono para 'Ranking'
        SizedBox(width: 8), // Espacio entre el icono y el texto
        Text(
          ranking,
          style: TextStyle(color: Colors.white, fontFamily: 'ReadexPro'),
        ),
        const SizedBox(
            width: 40), // Espacio entre los dos conjuntos de icono y texto
        Icon(
          Icons.public,
          color: Colors.white,
          size: 15,
        ), // Icono para 'Región'
        const SizedBox(width: 70), // Espacio entre el icono y el texto
        Text(
          region,
          style: TextStyle(color: Colors.white, fontFamily: 'ReadexPro'),
        ),
      ],
    ),
  );
}

Widget buildTimeAndRoundInfo(double timeEliminated, int lastRound) {
  double timeEliminatedInSeconds =
      timeEliminated; // Reemplaza con tu valor real
  int timeEliminatedInMinutes = (timeEliminatedInSeconds / 60).ceil();

  return Padding(
    padding: const EdgeInsets.all(5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Widget para Time Eliminated
        Icon(
          Icons.timer,
          color: Colors.white,
          size: 15,
        ), // Usa el icono que prefieras
        const SizedBox(width:10), // Espacio entre el icono y el texto
        Text(
          'time: ${timeEliminatedInMinutes} min', // Ajusta el formato como prefieras
          style: const TextStyle(color: Colors.white, fontFamily: 'ReadexPro'),
        ),
        const SizedBox(width:28), // Espacio entre los dos widgets

        // Widget para Last Round
        const Icon(
          Icons.gamepad,
          color: Colors.white,
          size: 15,
        ), // Usa el icono que prefieras
        SizedBox(width: 37), // Espacio entre el icono y el texto
        Text(
          'last round: $lastRound',
          style: const TextStyle(color: Colors.white, fontFamily: 'ReadexPro'),
        ),
      ],
    ),
  );
}

Widget buildEliminatedAndDamageInfo(
    int playersEliminated, int totalDamageToPlayers) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          Icons.person_remove,
          color: Colors.white,
          size: 15,
        ), // Icono para 'Players Eliminated'
        const SizedBox(width: 0), // Espacio entre el icono y el texto
        Text(
          'killed: $playersEliminated',
          style: const TextStyle(color: Colors.white, fontFamily: 'ReadexPro'),
        ),
        const SizedBox(
            width: 50), // Espacio entre los dos conjuntos de icono y texto
        const Icon(
          Icons.flash_on,
          color: Colors.white,
          size: 15,
        ), // Icono para 'Total Damage to Players'
        const SizedBox(width: 0), // Espacio entre el icono y el texto
        Text(
          'total damage: $totalDamageToPlayers',
          style: const TextStyle(color: Colors.white, fontFamily: 'ReadexPro'),
        ),
      ],
    ),
  );
}

Widget buildTwitchIcon(String twitchUrl) {
  return InkWell(
    onTap: () async {
      final Uri url = Uri.parse(twitchUrl);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        // Maneja el error como prefieras
        print('No se pudo abrir $twitchUrl');
      }
    },
    child: const Icon(
      FontAwesomeIcons.twitch,
      color: Colors.deepPurpleAccent,
      size: 24.0,
    ),
  );
}

Widget buildAvatarWithNameAndItems(
    String champion, int tier, List<String> itemNames) {
  List<Widget> itemWidgets = itemNames.map((itemName) {
    String itemAssetPath = 'assets/tft-item/$itemName.png';
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CircleAvatar(
        radius: 12, // Ajusta el radio según tus necesidades
        backgroundImage: AssetImage(itemAssetPath),
      ),
    );
  }).toList();

  return Column(
    children: [
      CircleAvatar(
        radius: 34.5,
        child: Container(
          width: 63, // Ajusta el ancho según tus necesidades
          height: 63, // Ajusta el alto según tus necesidades
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            image: DecorationImage(
              image: AssetImage('assets/tft-champions/$champion.png'),
              fit: BoxFit
                  .cover, // Ajusta el ajuste de la imagen según tus necesidades
              alignment:
                  Alignment(1.0, 0.0), // Mueve la imagen hacia la derecha
            ),
          ),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        champion.replaceFirst(
            'TFT10_', ''), // Elimina el prefijo 'TFT9_' del nombre
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'ReadexPro',
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 6), // Espacio entre el texto y las estrellas
      Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          tier, // Asume que el número de estrellas se pasa como argumento
          (index) => const Icon(
            Icons.star,
            color: Color.fromARGB(255, 180, 180, 2),
            size: 15,
          ),
        ),
      ),
      const SizedBox(height: 6),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: itemWidgets,
      ),
    ],
  );
}

class _ProPlayersScreenBody extends StatefulWidget {
  final List<ProPlayer> proPlayers;

  const _ProPlayersScreenBody({Key? key, required this.proPlayers})
      : super(key: key);

  @override
  _ProPlayersScreenBodyState createState() => _ProPlayersScreenBodyState();
}

class _ProPlayersScreenBodyState extends State<_ProPlayersScreenBody> {
  Map<String, List<MatchInfoModel>> _playerMatches = {};
  List<MatchInfoModel> _allMatches =
      []; // Lista combinada de todos los partidos
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchPlayersMatches();
  }

  Future<void> _fetchPlayersMatches() async {
    setState(() => _isLoading = true);
    try {
      for (var player in widget.proPlayers) {
        await _fetchMatches(player.puuid, player.region);
      }
      // Combina todos los partidos en una lista y los ordena
      _allMatches = _playerMatches.values.expand((m) => m).toList()
        ..sort((a, b) => b.gameDatetime.compareTo(a.gameDatetime));
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchMatches(String puuid, String region) async {
    final dataSource = TFTMatchDataSource(region);
    final matchIds = await dataSource.getMatchIdsByPUUID(puuid);
    final matchDetailsFutures = matchIds.map(dataSource.getMatchDetailsById);
    final matches = await Future.wait(matchDetailsFutures);
    matches.sort((a, b) => b.gameDatetime
        .compareTo(a.gameDatetime)); // Ordenar de más reciente a más antiguo

    _playerMatches[puuid] = matches;
  }

  @override
  Widget build(BuildContext context) {
    _allMatches = _playerMatches.values.expand((matches) => matches).toList()
      ..sort((a, b) => b.gameDatetime.compareTo(a.gameDatetime));

    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _errorMessage.isNotEmpty
            ? Center(child: Text('Error: $_errorMessage'))
            : SingleChildScrollView(
                child: Column(
                  children: _allMatches.map((match) {
                    final protagonist = match.participants.firstWhereOrNull(
                        (p) => widget.proPlayers
                            .any((player) => player.puuid == p.puuid));
                    final formattedTimeAgo = formatTimeAgo(match.gameDatetime);

                    // Encuentra el objeto ProPlayer correspondiente al protagonista
                    final player = widget.proPlayers.firstWhereOrNull(
                        (proPlayer) => proPlayer.puuid == protagonist?.puuid);
                    return Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      height: 500,
                      width: MediaQuery.of(context).size.width -
                          16, // Asegúrate de que el ancho esté acotado
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: protagonist == null
                          ? Text(
                              'Match ID: ${match.matchId} - Protagonist not found',
                              style: TextStyle(color: Colors.red),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 2), // Espacio vertical
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(
                                            player?.nombre ?? 'Unknown Player',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'ReadexPro',
                                            ),
                                          ),
                                        ),
                                      ),
                                      buildTwitchIcon(player?.twitchLink ?? ''),
                                      const SizedBox(
                                          width: 10), // Espacio horizontal
                                      Flexible(
                                        // Usa Flexible aquí
                                        child: Text(
                                          'Played $formattedTimeAgo',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontFamily: 'ReadexPro',
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      '${protagonist.placement.toString()}st Place',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 30,
                                        fontFamily: 'ReadexPro',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5), // Espacio vertical
                                  buildRankingAndRegionInfo(
                                      player?.ranking ?? 'Unknown',
                                      player?.region ?? 'Unknown'),
                                  const SizedBox(height: 5), // Espacio vertical
                                  buildTimeAndRoundInfo(
                                      protagonist.timeEliminated,
                                      protagonist.lastRound),
                                  const SizedBox(height: 5), // Espacio vertical
                                  buildEliminatedAndDamageInfo(
                                      protagonist.playersEliminated,
                                      protagonist.totalDamageToPlayers),
                                  const SizedBox(height: 5), // Espacio vertical
                                  buildTraitsInfo(protagonist.traits),
                                  buildAugmentsInfo(protagonist.augments),

                                  const SizedBox(height: 12),
                                  Expanded(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: protagonist.units.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          child: buildAvatarWithNameAndItems(
                                              protagonist
                                                  .units[index].characterId,
                                              protagonist.units[index].tier,
                                              protagonist
                                                  .units[index].itemNames),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    );
                  }).toList(),
                ),
              );
  }
}
