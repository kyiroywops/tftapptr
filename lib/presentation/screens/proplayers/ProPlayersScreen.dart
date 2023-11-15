import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Esta es la pantalla que mostrará la lista de pro players y sus partidas.
class ProPlayersScreen extends ConsumerWidget {
  static const name = 'home-screen-pro-players';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Asumimos que tienes un Provider que obtiene una lista de pro players.
    // Vamos a simular esta lista con un FutureProvider para el ejemplo.
    final proPlayersAsyncValue = ref.watch(proPlayersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pro Players'),
      ),
      body: proPlayersAsyncValue.when(
        data: (proPlayers) {
          // Asumiendo que proPlayers es una lista de objetos que contienen información del jugador.
          return ListView.builder(
            itemCount: proPlayers.length,
            itemBuilder: (context, index) {
              final proPlayer = proPlayers[index];
              return ListTile(
                title: Text(proPlayer.name), // Asumiendo que cada proPlayer tiene un nombre.
                subtitle: Text('Rank: ${proPlayer.rank}'), // Asumiendo que cada proPlayer tiene un rango.
                onTap: () {
                  // Aquí podrías navegar a una pantalla de detalles o mostrar el historial de partidas.
                },
              );
            },
          );
        },
        loading: () => CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error'),
      ),
    );
  }
}

// Suponiendo que tienes un provider que obtiene la lista de jugadores profesionales.
final proPlayersProvider = FutureProvider<List<ProPlayer>>((ref) async {
  // Aquí deberías obtener la lista de pro players de tu backend o servicio.
  // Este es un ejemplo y debes reemplazarlo con tu lógica real.
  // Por ejemplo:
  // return await ref.read(tftMatchRepositoryProvider).getProPlayers();
  throw UnimplementedError(); // Reemplaza esto con tu implementación real.
});

// Un ejemplo de clase para representar a los jugadores profesionales.
// Deberás reemplazar esto con tu modelo real.
class ProPlayer {
  final String name;
  final String rank;

  ProPlayer(this.name, this.rank);
}
