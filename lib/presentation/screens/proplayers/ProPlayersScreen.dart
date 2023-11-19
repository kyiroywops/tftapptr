import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';
import 'package:tftapp/infrastructure/models/match_info_model.dart';
import 'package:tftapp/infrastructure/models/proplayers_model.dart';
import 'package:tftapp/presentation/providers/proplayers_providers.dart';
import 'package:collection/collection.dart';

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

class _ProPlayersScreenBody extends StatefulWidget {
  final List<ProPlayer> proPlayers;

  const _ProPlayersScreenBody({Key? key, required this.proPlayers}) : super(key: key);

  @override
  __ProPlayersScreenBodyState createState() => __ProPlayersScreenBodyState();
}

class __ProPlayersScreenBodyState extends State<_ProPlayersScreenBody> {
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
    if (widget.proPlayers.isEmpty) {
      setState(() {
        _errorMessage = 'No pro players found';
        _isLoading = false;
      });
      return;
    }

    try {
      final puuid = widget.proPlayers.first.puuid;
      final matchIds = await _dataSource.getMatchIdsByPUUID(puuid);
      final matchDetailsFutures = matchIds.map(_dataSource.getMatchDetailsById);
      final matches = await Future.wait(matchDetailsFutures);
      
      setState(() {
        _matches = matches;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _errorMessage.isNotEmpty
            ? Center(child: Text('Error: $_errorMessage'))
            : ListView.builder(
                itemCount: _matches.length,
                itemBuilder: (context, index) {
                  final match = _matches[index];
                  final protagonist = match.participants.firstWhereOrNull(
                    (p) => p.puuid == widget.proPlayers.first.puuid,
                  );

                  if (protagonist == null) {
                    return ListTile(
                      title: Text('Match ID: ${match.matchId}'),
                      subtitle: Text('Protagonist not found'),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ListTile(
                        title: Text('Match ID: ${match.matchId}', style: TextStyle(color: Colors.white, fontFamily: 'ReadexPro', fontWeight: FontWeight.bold, fontSize: 15)),
                        subtitle: Wrap(
                          children: protagonist.units.map((unit) => Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Chip(
                                  label: Text(unit.characterId),
                                ),
                              )).toList(),
                        ),
                      ),
                    ),
                  );
                },
              );
  }
}
