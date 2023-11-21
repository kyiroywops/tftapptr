import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/domain/usecases/formatTimeAgoUseCases.dart';
import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';
import 'package:tftapp/infrastructure/models/match_info_model.dart';
import 'package:tftapp/infrastructure/models/proplayers_model.dart';
import 'package:tftapp/presentation/providers/proplayers_providers.dart';

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



  Widget buildAvatarWithNameAndItems(String champion, int tier, List<String> itemNames) {

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
          width: 63,  // Ajusta el ancho según tus necesidades
          height: 63, // Ajusta el alto según tus necesidades
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            image: DecorationImage(
              image: AssetImage('assets/tft-champions/$champion.png'),
              fit: BoxFit.cover, // Ajusta el ajuste de la imagen según tus necesidades
              alignment: Alignment(1.0, 0.0), // Mueve la imagen hacia la derecha
            ),
          ),
          
        ),
      ),
        const SizedBox(height: 4),
       Text(
  champion.replaceFirst('TFT9_', ''),  // Elimina el prefijo 'TFT9_' del nombre
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
  List<MatchInfoModel> _allMatches = []; // Lista combinada de todos los partidos
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
    matches.sort((a, b) => b.gameDatetime.compareTo(a.gameDatetime)); // Ordenar de más reciente a más antiguo


    _playerMatches[puuid] = matches;
  }

  @override
  Widget build(BuildContext context) {
     _allMatches = _playerMatches.values
    .expand((matches) => matches)
    .toList()
    ..sort((a, b) => b.gameDatetime.compareTo(a.gameDatetime));



    return _isLoading
      ? const Center(child: CircularProgressIndicator())
      : _errorMessage.isNotEmpty
        ? Center(child: Text('Error: $_errorMessage'))
        : SingleChildScrollView(
            child: Column(
              children: _allMatches.map((match) {
                final protagonist = match.participants
                    .firstWhereOrNull((p) => widget.proPlayers.any((player) => player.puuid == p.puuid));
                final formattedTimeAgo = formatTimeAgo(match.gameDatetime);

                // Encuentra el objeto ProPlayer correspondiente al protagonista
                final player = widget.proPlayers.firstWhereOrNull(
                  (proPlayer) => proPlayer.puuid == protagonist?.puuid
                );
                return Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  height: 335,
                  width: MediaQuery.of(context).size.width - 16, // Asegúrate de que el ancho esté acotado
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
                          crossAxisAlignment:
                            CrossAxisAlignment.start,
                            
                          children: [
                            const SizedBox(height: 2), // Espacio vertical
                            Row(
                              
                              
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
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
                                  const SizedBox(width: 10), // Espacio horizontal
                                  Flexible( // Usa Flexible aquí
                                    child: Text(
                                      'Played $formattedTimeAgo',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'ReadexPro',
                                        fontWeight: FontWeight.w300,
                                        ),
                                    ),
                                  ),

                                
                                 const SizedBox(height: 8), // Espacio vertical
                                //  Container(
                                //   height: 16,
                                //   child: Wrap(
                                    
                                //     spacing: 8.0, // Espacio horizontal entre los widgets
                               
                                //     children: protagonist.units.map((unit) {
                                //       return Row(children: [
                                //         Container(
                                //           width: 16, 
                                //           height: 16,
                                //           child: buildAvatarWithNameAndItems(unit.characterId),


                                //         ),
                                //       ],);
                                //     } 
                                     
                                     
                                //     ).toList(),
                                //   ),
                                // ),

                                ],
                              ),
                              const SizedBox(height: 12), // Espacio vertical
                              Expanded(
                                              child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount: protagonist.units.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                                    child: buildAvatarWithNameAndItems(protagonist.units[index].characterId, protagonist.units[index].tier, protagonist.units[index].itemNames ),
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