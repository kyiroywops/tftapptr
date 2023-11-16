import 'package:flutter/material.dart';
import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';

class ProPlayersScreen extends StatelessWidget {
  // PUUID de prueba
  final String puuid = '9wtqe0_9jqnAzHb-NzMeHQ0CQADVq0GQsS-F_2nU_ZEiO4QhjhXPKRTLppRTza9S1927K-eONC5IGQ';

  @override
  Widget build(BuildContext context) {
    // Instanciando el DataSource directamente para depuración
    final dataSource = TFTMatchDataSource('americas');

    dataSource.getMatchIdsByPUUID(puuid).then((ids) {
      // Imprimir los IDs para depuración
      print('Match IDs: $ids');
    }).catchError((error) {
      // Capturar y manejar errores aquí
      print('Error: $error');
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Partidas del Jugador'),
      ),
      body: Center(
        child: Text('Verifica la consola para los IDs de las partidas.'),
      ),
    );
  }
}
