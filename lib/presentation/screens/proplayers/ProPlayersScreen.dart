import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/domain/usecases/formatTimeAgoUseCases.dart';
import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';
import 'package:tftapp/infrastructure/models/match_info_model.dart';
import 'package:tftapp/infrastructure/models/trait_info_model.dart';
import 'package:tftapp/infrastructure/models/unit_info_model.dart';
import 'package:tftapp/presentation/providers/challengers_provider.dart';

class ChallengersScreen extends ConsumerStatefulWidget {
  const ChallengersScreen({Key? key}) : super(key: key);

  @override
  _ChallengersScreenState createState() => _ChallengersScreenState();
}

class _ChallengersScreenState extends ConsumerState<ChallengersScreen> {
  Map<String, List<MatchInfoModel>> _playerMatches = {};
  List<MatchInfoModel> _allMatches =
      []; // Lista combinada de todos los partidos
  bool _isLoading = true;
  String _errorMessage = '';
  List<MatchInfoModel> matches = [];
  bool isLoading = false;
  String errorMessage = '';
  Map<String, String> _playerNamesToPuuids = {};


  Widget buildAugmentsInfoSearch(List<String> augments) {
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

  Widget buildTraitsInfoSearch(List<TraitInfoModel> traits) {
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
                      width:
                          5), // Espacio entre el nombre y el número de unidades
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

  Widget buildAvatarWithNameAndItemsSearch(
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

  Widget buildTimeAndRoundInfoSearch(double timeEliminated, int lastRound) {
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
          const SizedBox(width: 10), // Espacio entre el icono y el texto
          Text(
            'time: ${timeEliminatedInMinutes} min', // Ajusta el formato como prefieras
            style:
                const TextStyle(color: Colors.white, fontFamily: 'ReadexPro'),
          ),
          const SizedBox(width: 28), // Espacio entre los dos widgets

          // Widget para Last Round
          const Icon(
            Icons.gamepad,
            color: Colors.white,
            size: 15,
          ), // Usa el icono que prefieras
          SizedBox(width: 37), // Espacio entre el icono y el texto
          Text(
            'last round: $lastRound',
            style:
                const TextStyle(color: Colors.white, fontFamily: 'ReadexPro'),
          ),
        ],
      ),
    );
  }

  Widget buildEliminatedAndDamageInfoSearch(
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
          const SizedBox(width: 2), // Espacio entre el icono y el texto
          Text(
            'killed: $playersEliminated',
            style:
                const TextStyle(color: Colors.white, fontFamily: 'ReadexPro'),
          ),
          const SizedBox(
              width: 50), // Espacio entre los dos conjuntos de icono y texto
          const Icon(
            Icons.flash_on,
            color: Colors.white,
            size: 15,
          ), // Icono para 'Total Damage to Players'
          const SizedBox(width: 5), // Espacio entre el icono y el texto
          Text(
            'total damage: $totalDamageToPlayers',
            style:
                const TextStyle(color: Colors.white, fontFamily: 'ReadexPro'),
          ),
        ],
      ),
    );
  }

  Widget buildChampionInfoSearch(UnitInfoModel unit) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Image.asset(
              'assets/tft-champions/${unit.characterId}.png'), // Asegúrate de que la ruta a tus imágenes es correcta
          Text(unit.characterId),
          Row(
            children: List.generate(
              unit.tier,
              (index) => Icon(Icons.star, size: 12, color: Colors.yellow),
            ),
          ),
        ],
      ),
    );
  }

// Este widget construirá cada tarjeta de partido
  Widget buildMatchTileSearch(MatchInfoModel match, String playerName) {
     // Busca el PUUID basado en el nombre del jugador.
  final String? summonerPuuid = _playerNamesToPuuids[playerName];

  Color getColorForPlacement(int placement) {
  switch (placement) {
    case 1:
      return Color(0xFFFFD700); // Oro
    case 2:
      return Color(0xFFC0C0C0); // Plata
    case 3:
      return Color(0xFFCD7F32); // Bronce
    case 4:
      return Color(0xFFADD8E6); // Azul claro
    case 5:
      return Color(0xFF32CD32); // Verde
    case 6:
      return Color(0xFFFFFF00); // Amarillo
    case 7:
      return Color(0xFFFFA500); // Naranja
    default:
      return Color(0xFFFF0000); // Rojo
  }

}

  
  // Si no se encuentra el PUUID, maneja el caso de error.
  if (summonerPuuid == null || summonerPuuid.isEmpty) {
    print("Error: PUUID not found for $playerName");
    return ListTile(
      title: Text('Match ID: ${match.matchId}'),
      subtitle: Text('Protagonist with name $playerName not found'),
    );
  }
  
  // Continúa con la lógica existente si se encuentra el PUUID.
  final protagonist = match.participants.firstWhereOrNull(
    (p) => p.puuid == summonerPuuid,
  );
    final formattedTimeAgo = formatTimeAgo(match.gameDatetime);

    if (protagonist == null) {
      
      return ListTile(
        title: Text('Match ID: ${match.matchId}'),
        subtitle: Text('Protagonist not found'),
      );
    } else {
      Color placementColor = getColorForPlacement(protagonist.placement);

       return Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        height: 500,
        width: MediaQuery.of(context).size.width -
            16, // Asegúrate de que el ancho esté acotado
        decoration: BoxDecoration(
          color: Colors.grey.shade600.withOpacity(0.2),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2), // Espacio vertical
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Nombre del jugador y logo de Challenger a la izquierda
                  Row(
                    children: [
                      Text(
                        playerName, // Nombre del jugador
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'ReadexPro',
                          fontWeight: FontWeight.bold,
                          fontSize: 17

                        ),
                      ),
                      SizedBox(width: 20), // Espacio entre el texto y la imagen
                      Image.asset(
                        'assets/images/challenger.png', // Ruta a la imagen de Challenger
                        width: 70, // Ajusta el tamaño según tus necesidades
                        height: 70,
                      ),
                    ],
                  ),
                  // Tiempo transcurrido desde la partida
                  Text(
                    'Played $formattedTimeAgo',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'ReadexPro',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
                            ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  '${protagonist.placement.toString()}st Place',
                  style:  TextStyle(
                    color: placementColor.withOpacity(0.9),
                    fontSize: 30,
                    fontFamily: 'ReadexPro',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              const SizedBox(height: 5), // Espacio vertical
              buildTimeAndRoundInfoSearch(
                  protagonist.timeEliminated, protagonist.lastRound),
              const SizedBox(height: 5), // Espacio vertical
              buildEliminatedAndDamageInfoSearch(protagonist.playersEliminated,
                  protagonist.totalDamageToPlayers),
              const SizedBox(height: 5), // Espacio vertical
              buildTraitsInfoSearch(protagonist.traits),
              buildAugmentsInfoSearch(protagonist.augments),

              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: protagonist.units.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: buildAvatarWithNameAndItemsSearch(
                          protagonist.units[index].characterId,
                          protagonist.units[index].tier,
                          protagonist.units[index].itemNames),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final selectedServer =
          ref.read(selectedServerProviderchallengers.state).state;
      try {
        final playerNames = await ref
            .read(challengerPlayerNamesProvider(selectedServer).future);
        print("Player names: $playerNames");
        if (playerNames.isNotEmpty) {
          await _fetchPlayersMatches(playerNames, selectedServer);
        } else {
          print("Player names list is empty");
          setState(() {
            _isLoading = false;
            _errorMessage = "No player names were found.";
          });
        }
      } catch (e) {
        print("Error fetching player names: $e");
        setState(() {
          _isLoading = false;
          _errorMessage = e.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
     return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/icons/logo.png', // Reemplaza con el camino a tu logo
                height: 30.0,
              ),
              Text(
                'ProPlayers Realtime',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ReadexPro',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Icon(
                Icons.discord, // Ícono de Discord
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (_errorMessage.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Challenger Players'),
        ),
        body: Center(
          child: Text('Error: $_errorMessage'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/icons/logo.png', // Reemplaza con el camino a tu logo
                height: 30.0,
              ),
              Text(
                'ProPlayers Realtime',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ReadexPro',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Icon(
                Icons.discord, // Ícono de Discord
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
  body: _allMatches.isEmpty
      ? const Center(child: Text('No matches found.'))
      : ListView.builder(
          itemCount: _allMatches.length,
          itemBuilder: (context, index) {
            final match = _allMatches[index];
            String? protagonistName;

            for (var participant in match.participants) {
              if (_playerNamesToPuuids.containsValue(participant.puuid)) {
                // Encuentra el nombre del jugador basado en el PUUID
                protagonistName = _playerNamesToPuuids.entries.firstWhere(
                  (entry) => entry.value == participant.puuid,
                  orElse: () => MapEntry('', ''),
                ).key;
                break;
              }
            }

            // Ahora llama a buildMatchTileSearch con el nombre del jugador
            return buildMatchTileSearch(match, protagonistName ?? '');
          },
        ),
);
  }

  Future<List<MatchInfoModel>> fetchMatchesForPlayer(
      String playerName, String server, WidgetRef ref) async {
    List<MatchInfoModel> fetchedMatches = []; // Inicializa una lista vacía
    try {
      final dataSource = ref.read(tftMatchDataSourceProvider(server));
      final summonerInfo =
          await dataSource.getSummonerInfoBySummonerName(playerName, server);
          _playerNamesToPuuids[playerName] = summonerInfo.puuid;
    


      
      final matchIds = await dataSource.getMatchIdsByPUUID(summonerInfo.puuid);

      for (String matchId in matchIds) {
        MatchInfoModel matchDetails =
            await dataSource.getMatchDetailsById(matchId);
        fetchedMatches.add(matchDetails);
      }

      if (mounted) {
        // Asegúrate de que el widget está montado antes de llamar a setState
        setState(() {
          _playerMatches[playerName] = fetchedMatches;
        });
      }
    } catch (e) {
      if (mounted) {
        // Asegúrate de que el widget está montado antes de llamar a setState
        setState(() {
          _errorMessage = e.toString();
        });
      }
    }

    return fetchedMatches; // Devuelve la lista de partidos
  }

  Future<void> _fetchPlayersMatches(
      List<String> playerNames, String server) async {
    setState(() => _isLoading = true);
    _playerMatches.clear();
    _allMatches.clear();

    for (var playerName in playerNames) {
      try {
        final dataSource = ref.read(tftMatchDataSourceProvider(server));
        final summonerInfo =
            await dataSource.getSummonerInfoBySummonerName(playerName, server);

        // Actualizar el mapa con el PUUID del jugador
        _playerNamesToPuuids.putIfAbsent(playerName, () => summonerInfo.puuid);
        print('PUUID for $playerName is ${_playerNamesToPuuids[playerName]}');



        final matchIds =
            await dataSource.getMatchIdsByPUUID(summonerInfo.puuid);
        List<MatchInfoModel> matchesForPlayer = [];

        for (String matchId in matchIds) {
          MatchInfoModel matchDetails =
              await dataSource.getMatchDetailsById(matchId);
          matchesForPlayer.add(matchDetails);
        }

        if (mounted) {
          setState(() {
            _playerMatches[playerName] = matchesForPlayer;
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _errorMessage = e.toString();
          });
        }
      }
    }

    _allMatches = _playerMatches.values.expand((x) => x).toList();
    _allMatches.sort((a, b) => b.gameDatetime.compareTo(a.gameDatetime));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
