// import 'package:flutter/material.dart';
// import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';
// import 'package:tftapp/infrastructure/models/match_info_model.dart';
// import 'package:tftapp/presentation/screens/proplayers/unit_info_model.dart';
// import 'package:collection/collection.dart'; // Importar collection para usar firstWhereOrNull

// class ProPlayersScreen extends StatefulWidget {

  


//   @override
//   _ProPlayersScreenState createState() => _ProPlayersScreenState();
// }

// class _ProPlayersScreenState extends State<ProPlayersScreen> {
//   final TFTMatchDataSource _dataSource = TFTMatchDataSource('americas');
//   List<MatchInfoModel> _matches = [];
//   bool _isLoading = true;
//   String _errorMessage = '';
//   // Definimos el puuid aquí para que sea accesible en todo el ámbito de la clase.
//   final String puuid = '9wtqe0_9jqnAzHb-NzMeHQ0CQADVq0GQsS-F_2nU_ZEiO4QhjhXPKRTLppRTza9S1927K-eONC5IGQ';

//   @override
//   void initState() {
//     super.initState();
//     _fetchMatches();
//   }

//   Future<void> _fetchMatches() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final matchIds = await _dataSource.getMatchIdsByPUUID(puuid);
//       final matchDetailsFutures = matchIds.map(_dataSource.getMatchDetailsById);
//       final matches = await Future.wait(matchDetailsFutures);

//       setState(() {
//         _matches = matches;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = e.toString();
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Partidas del Jugador Pro')),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//               ? Center(child: Text('Error: $_errorMessage'))
//               : ListView.builder(
//                   itemCount: _matches.length,
//                   itemBuilder: (context, index) {
//                     final match = _matches[index];
//                     final protagonist = match.participants.firstWhereOrNull(
//                       (p) => p.puuid == puuid,
//                     );

//                     if (protagonist == null) {
//                       return ListTile(
//                         title: Text('Match ID: ${match.matchId}'),
//                         subtitle: Text('Protagonist not found'),
//                       );
//                     }

//                     return ListTile(
//                       title: Text('Match ID: ${match.matchId}'),
//                       subtitle: Text('Data Version: ${match.dataVersion}'),
//                       trailing: Container(
//                         width: 200, // Un ancho fijo para el widget 'trailing'
//                         child: UnitsRowWidget(units: protagonist.units),
//             ),
//           );
//                   },
//                 ),
//     );
//   }
// }
