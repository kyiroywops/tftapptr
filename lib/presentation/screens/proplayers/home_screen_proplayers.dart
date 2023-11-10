import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/presentation/providers.dart';
import 'package:tftapp/presentation/providers/matchs_providers.dart'; // Importa los proveedores

class HomeScreenProPlayers extends ConsumerWidget {
  static const name = 'home-screen-pro-players';

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // Lee el repositorio y otros proveedores necesarios
    final tftMatchRepository = context.read(tftMatchRepositoryProvider);
    // Otros proveedores aquí si los necesitas

    // Ahora puedes usar el repositorio para obtener datos
    final matchIds = tftMatchRepository.getMatchIdsByPUUID('yourPUUID', 'yourRegion');
    // Hacer algo con los matchIds, por ejemplo, cargar el historial

    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de partidas'),
      ),
      body: Center(
        child: Text('Contenido de la pantalla de historial aquí'),
      ),
    );
  }
}
