import 'package:flutter/material.dart';
import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';
import 'package:tftapp/infrastructure/models/match_info_model.dart';
import 'package:tftapp/infrastructure/models/participant_info_model.dart';
import 'package:tftapp/infrastructure/models/unit_info_model.dart';
import 'package:collection/collection.dart';

class ProPlayersScreen extends StatefulWidget {
  @override
  _ProPlayersScreenState createState() => _ProPlayersScreenState();
}

class _ProPlayersScreenState extends State<ProPlayersScreen> {
  final TFTMatchDataSource _dataSource = TFTMatchDataSource('americas');
  List<MatchInfoModel> _matches = [];
  bool _isLoading = true;
  String _errorMessage = '';
  final String puuid = '9wtqe0_9jqnAzHb-NzMeHQ0CQADVq0GQsS-F_2nU_ZEiO4QhjhXPKRTLppRTza9S1927K-eONC5IGQ';

  @override
  void initState() {
    super.initState();
    _fetchMatches();
  }

  Future<void> _fetchMatches() async {
    try {
      final matchIds = await _dataSource.getMatchIdsByPUUID(puuid);
      final matchDetailsFutures = matchIds.map(_dataSource.getMatchDetailsById);
      final matches = await Future.wait(matchDetailsFutures);

      // Imprimir nombres de las unidades en la consola para debugging
      for (var match in _matches) {
        final protagonist = match.participants.firstWhereOrNull((p) => p.puuid == puuid);
        if (protagonist != null) {
          print('Units for match ${match.matchId}:');
          protagonist.units.forEach((unit) {
            // Suponiendo que `unit.characterId` es el nombre del campeón.
            print(unit.characterId); 
          });
        }
      }

      setState(() {
        _matches = matches;
        _isLoading = false;
      });

      // Imprimir nombres de unidades de los protagonistas en la consola
      for (var match in _matches) {
        final protagonist = match.participants.firstWhereOrNull((p) => p.puuid == puuid);
        if (protagonist != null) {
          print('Units for match ${match.matchId}:');
          protagonist.units.forEach((unit) {
            print(unit.characterId); // Imprimir el ID del personaje, que asumimos es el nombre
          });
        }
      }

    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
      const Text(
        'ProPlayers Tracker',
        style: TextStyle(
          fontFamily: 'ReadexPro',
          fontSize: 25,
          fontWeight: FontWeight.bold, // Usa FontWeight para especificar el peso
      ),
        )
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text('Error: $_errorMessage'))
              : ListView.builder(
                  itemCount: _matches.length,
                  itemBuilder: (context, index) {
                    final match = _matches[index];
                    final protagonist = match.participants.firstWhereOrNull(
                      (p) => p.puuid == puuid,
                    );

                    if (protagonist == null) {
                      return ListTile(
                        title: Text('Match ID: ${match.matchId}'),
                        subtitle: Text('Protagonist not found'),
                      );
                    }

                    // Mostrar nombres de unidades en la UI
                    return ListTile(
                      title: Text('Match ID: ${match.matchId}'),
                      subtitle: Wrap(
                        children: protagonist.units
                            .map((unit) => Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Chip(
                                    label: Text(unit.characterId), // Mostrar el ID del personaje como el nombre
                                  ),
                                ))
                            .toList(),
                      ),
                    );
                  },
                ),
    );
  }
}
