import 'package:flutter/material.dart';
import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';

class HomeScreenProPlayers extends StatelessWidget {
  static const name = 'home-screen-pro-players';
  final TFTMatchDataSource dataSource;

  const HomeScreenProPlayers({
    Key? key,
    required this.dataSource,
  }) : super(key: key);

  Future<void> _fetchData() async {
    final puuid = "9wtqe0_9jqnAzHb-NzMeHQ0CQADVq0GQsS-F_2nU_ZEiO4QhjhXPKRTLppRTza9S1927K-eONC5IGQ";
    final region = "NA1";
    final matchId = "NA1_4818645441";

    try {
      final matchIds = await dataSource.getMatchIdsByPUUID(puuid, region);
      print("Match IDs: $matchIds");

      final matchDetails = await dataSource.getMatchDetailsById(matchId, region);
      print("Match Details: $matchDetails");
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pro Players'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Pro Players Data',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: _fetchData,
              child: const Text('Fetch Data'),
            ),
          ],
        ),
      ),
    );
  }
}
