import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';
import 'package:tftapp/infrastructure/models/match_info_model.dart';
import 'package:tftapp/presentation/providers/challengers_provider.dart';

class ChallengersScreen extends ConsumerStatefulWidget {
  const ChallengersScreen({Key? key}) : super(key: key);

  @override
  _ChallengersScreenState createState() => _ChallengersScreenState();
}

class _ChallengersScreenState extends ConsumerState<ChallengersScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedServer = ref.watch(selectedServerProviderchallengers.state).state;
    final playerNamesAsyncValue = ref.watch(challengerPlayerNamesProvider(selectedServer));

    

    return Scaffold(
      appBar: AppBar(
        title: Text('Challenger Players'),
      ),
      body: playerNamesAsyncValue.when(
        data: (playerNames) {
          return ListView.builder(
            itemCount: playerNames.length,
            itemBuilder: (context, index) {
              final playerName = playerNames[index];
              return FutureBuilder<List<MatchInfoModel>>(
                future: fetchMatchesForPlayer(playerName, selectedServer, ref),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListTile(title: Text(playerName), subtitle: Text('Cargando partidas...'));
                  } else if (snapshot.hasError) {
                    return ListTile(title: Text(playerName), subtitle: Text('Error al cargar partidas'));
                  } else {
                    final matches = snapshot.data ?? [];
                    return ListTile(
                      title: Text(playerName),
                      subtitle: Text('Partidas: ${matches.length}'),
                      onTap: () {
                        // Aquí puedes implementar la lógica para mostrar detalles de las partidas
                      },
                    );
                  }
                },
              );
            },
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}


Future<List<MatchInfoModel>> fetchMatchesForPlayer(String summonerName, String server, ref) async {
  try {
    final dataSource = ref.read(tftMatchDataSourceProvider(server));
    final summonerInfo = await dataSource.getSummonerInfoBySummonerName(summonerName, server);
    final matchIds = await dataSource.getMatchIdsByPUUID(summonerInfo.puuid);
    final matches = await dataSource.getMatchDetailsByMatchIds(matchIds);
    return matches;
  } catch (e) {
    print('Error fetching matches for player: $e');
    return [];
  }
}