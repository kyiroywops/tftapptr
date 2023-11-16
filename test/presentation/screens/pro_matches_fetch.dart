// Tu archivo ProPlayersScreen.dart

import 'package:flutter/material.dart';
import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';
import 'package:tftapp/infrastructure/models/match_info_model.dart';

class ProPlayersScreen extends StatefulWidget {
  @override
  _ProPlayersScreenState createState() => _ProPlayersScreenState();
}

class _ProPlayersScreenState extends State<ProPlayersScreen> {
  final TFTMatchDataSource _dataSource = TFTMatchDataSource('americas');
  List<MatchInfoModel> _matches = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchMatches();
  }

  Future<void> _fetchMatches() async {
    setState(() {
      _isLoading = true;  // Asegúrate de que el indicador de carga se muestra al iniciar la carga
    });

    print('Fetching matches for a pro player...');
    try {
      // Usar el PUUID que proporcionaste
      final puuid = '9wtqe0_9jqnAzHb-NzMeHQ0CQADVq0GQsS-F_2nU_ZEiO4QhjhXPKRTLppRTza9S1927K-eONC5IGQ';
      final matchIds = await _dataSource.getMatchIdsByPUUID(puuid);
      print('Match IDs fetched: $matchIds');

      final matchDetailsFutures = matchIds.map(_dataSource.getMatchDetailsById);
      final matches = await Future.wait(matchDetailsFutures);
      print('Match details fetched for all matches');

      setState(() {
        _matches = matches;
        _isLoading = false;
      });
    } catch (e) {
      print('An error occurred while fetching matches: $e');
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Partidas del Jugador Pro')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text('Error: $_errorMessage'))
              : ListView.builder(
                  itemCount: _matches.length,
                  itemBuilder: (context, index) {
                    final match = _matches[index];
                    // Aquí construyes los widgets que muestran la información de cada partida
                    return ListTile(
                      title: Text('Match ID: ${match.matchId}'),
                      subtitle: Text('Data Version: ${match.dataVersion}'),
                      // Añade más información de la partida como prefieras
                    );
                  },
                ),
    );
  }
}
