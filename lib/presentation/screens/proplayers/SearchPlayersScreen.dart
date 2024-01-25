import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/domain/usecases/formatTimeAgoUseCases.dart';
import 'package:tftapp/infrastructure/models/match_info_model.dart';
import 'package:tftapp/infrastructure/models/trait_info_model.dart';
import 'package:tftapp/infrastructure/models/unit_info_model.dart';
import 'package:tftapp/presentation/providers/matchs_providers.dart';
import 'package:tftapp/presentation/providers/summonerid_provider.dart';

class SearchPlayersScreen extends ConsumerStatefulWidget {
  const SearchPlayersScreen({Key? key}) : super(key: key);

  @override
  _SearchPlayersScreenState createState() => _SearchPlayersScreenState();
}

class _SearchPlayersScreenState extends ConsumerState<SearchPlayersScreen> {
  final TextEditingController summonerNameController = TextEditingController();
  List<MatchInfoModel> matches = [];
  bool isLoading = false;
  String errorMessage = '';
  String summonerPuuid =
      ''; // Añade un nuevo campo de estado para almacenar el PUUID



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
          style: const TextStyle(color: Colors.white, fontFamily: 'ReadexPro'),
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
          style: const TextStyle(color: Colors.white, fontFamily: 'ReadexPro'),
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
  Widget buildMatchTileSearch(MatchInfoModel match) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 10), // Espacio horizontal
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

  Future<void> _searchSummoner() async {
    print('Iniciando búsqueda de Summoner...');
    if (mounted) {
      setState(() => isLoading = true);
    }

    final String summonerName = summonerNameController.text;
    final String selectedServer = ref.watch(selectedServerProvider.state).state;

    try {
      if (summonerName.isNotEmpty) {
        final summonerInfo = await ref
            .read(summonerProvider('$summonerName|$selectedServer').future);

        // Asegúrate de que el widget sigue montado antes de actualizar su estado.
        if (mounted) {
          setState(() {
            summonerPuuid = summonerInfo.puuid;
          });
        }

        final matchRepository =
            ref.read(tftMatchRepositoryProvider(selectedServer));
        final matchIds =
            await matchRepository.getMatchIdsByPUUID(summonerInfo.puuid);
        final matches =
            await matchRepository.getMatchDetailsByMatchIds(matchIds);

        if (mounted) {
          setState(() {
            this.matches =
                matches; // Actualiza el estado con los detalles de las partidas
          });
        }
      } else {
        if (mounted) {
          setState(() {
            errorMessage = 'Please enter a summoner name.';
          });
        }
      }
    } catch (e) {
      // Si hay un error, actualiza el estado solo si el widget sigue montado.
      if (mounted) {
        setState(() {
          errorMessage = e.toString();
        });
      }
    } finally {
    // Al final del proceso, si el widget está montado, actualiza el estado para dejar de mostrar el indicador de carga.
    if (mounted) {
      setState(() => isLoading = false);
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Construye tu UI aquí
    final String selectedServer = ref.watch(selectedServerProvider);

    // Asegúrate de que tienes una lista de servidores definida en alguna parte
    final List<String> servers = [
      'BR1',
      'EUN1',
      'EUW1',
      'JP1',
      'KR',
      'LA1',
      'LA2',
      'NA1',
      'OC1',
      'PH2',
      'RU',
      'SG2',
      'TH2',
      'TR1',
      'TW2',
      'VN2'
    ];

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
                'Search Summoner',
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
  body: isLoading
      ? const Center(child: CircularProgressIndicator())
      : Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Row para el Dropdown y el SummonerID
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // DropdownButton
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 8, 10, 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          value: selectedServer,
                          iconSize: 30,
                          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                          dropdownColor: Colors.black54,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              ref.read(selectedServerProvider.notifier).state = newValue;
                            }
                          },
                          items: servers.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: const TextStyle(color: Colors.white,
                              fontFamily: 'ReadexPro',
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Espaciado entre el Dropdown y el TextField
                  // SummonerID TextField
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: summonerNameController,
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'ReadexPro',
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: 'SummonerID',
                          hintStyle: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 14,
                            fontFamily: 'ReadexPro',
                            fontWeight: FontWeight.bold,
                          ),
                          prefixIcon: const Icon(Icons.search, color: Colors.white),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Botón de búsqueda con nuevo diseño
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                  onPressed: _searchSummoner,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey.shade400.withOpacity(0.8),
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                  ),
                  child: const Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'ReadexPro',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Mensaje de error, si existe
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(errorMessage, style: const TextStyle(color: Colors.red)),
                ),
              // Lista de partidas
              Expanded(
                child: ListView.builder(
                  itemCount: matches.length,
                  itemBuilder: (context, index) {
                    final match = matches[index];
                    return buildMatchTileSearch(match);
                  },
                ),
              ),
            ],
          ),
        ),
);

  }
}
