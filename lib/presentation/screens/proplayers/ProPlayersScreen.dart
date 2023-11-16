import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/presentation/providers/matchs_providers.dart';

class ProPlayersScreen extends ConsumerWidget {
  final String puuid = 'tu_puuid';  // Reemplaza con el PUUID real que quieres usar

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchIdsAsyncValue = ref.watch(matchIdsProvider({'puuid': puuid, 'region': 'americas'}));

    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Partidas'),
      ),
      body: matchIdsAsyncValue.when(
        data: (matchIds) {
          final lastFiveMatchIds = matchIds.take(5).toList();
          final matchDetailsAsyncValue = ref.watch(matchDetailsProvider({'matchIds': lastFiveMatchIds, 'region': 'americas'}));
          
          return matchDetailsAsyncValue.when(
            data: (matchDetails) => ListView.builder(
              itemCount: matchDetails.length,
              itemBuilder: (context, index) {
                final match = matchDetails[index];
                return ListTile(
                  title: Text('ID de Partida: ${match.matchId}'),
                  subtitle: Text('Versión de Datos: ${match.dataVersion}'),
                  onTap: () {
                    // Aquí podrías mostrar más detalles de la partida.
                  },
                );
              },
            ),
            loading: () => CircularProgressIndicator(),
            error: (error, stack) => Text('Error: $error'),
          );
        },
        loading: () => CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error'),
      ),
    );
  }
}
