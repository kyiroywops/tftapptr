import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/presentation/providers/summonerid_provider.dart';

class SearchPlayersScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _summonerNameController = TextEditingController();
    final selectedServerState = ref.watch(selectedServerProvider);
    final selectedServer = selectedServerState;

    final List<String> servers = [
      'BR1', 'EUN1', 'EUW1', 'JP1', 'KR', 'LA1', 'LA2',
      'NA1', 'OC1', 'PH2', 'RU', 'SG2', 'TH2', 'TR1', 'TW2', 'VN2'
    ];

    Future<void> _searchSummoner() async {
       String summonerName = _summonerNameController.text;
 
      if (summonerName.isNotEmpty) {
        final combinedParams = '$summonerName|$selectedServer';
        final summonerInfoFuture = ref.read(summonerProvider(combinedParams).future);

        try {
          // Suponiendo que tienes un objeto dataSource de la clase TFTMatchDataSource
          final summonerInfo = await summonerInfoFuture;
          print('Summoner info: $summonerInfo');


        } catch (e) {
          // Maneja cualquier error que pueda ocurrir durante la búsqueda
          print('Error al buscar información del invocador: $e');
        }
      } else {
        // Manejar el caso de que el campo de búsqueda esté vacío
        print('Por favor, introduce un nombre de invocador para buscar.');
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          title: const Text(
            'Search Players',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'ReadexPro',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          color: Colors.grey.shade900,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(45, 0, 40, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Text(
                      'Put your SummonerID and select your server.',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ReadexPro',
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 8, 10, 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            // Aquí personalizamos el tema del menú desplegable
                            popupMenuTheme: PopupMenuThemeData(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Esto dará los bordes redondeados
                              ),
                              // Otras personalizaciones pueden ir aquí
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(
                                  16), // This line gives the dropdown rounded corners

                              value: selectedServer,
                              icon: const Icon(Icons.arrow_drop_down_rounded,
                                  color: Colors.white), // Ícono de flecha
                              dropdownColor: Colors.black.withOpacity(
                                  0.4), // Color del menú desplegable
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  context
                                      .read(selectedServerProvider.notifier)
                                      .state = newValue;
                                }
                              },
                              items: servers.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                );
                              }).toList(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'ReadexPro',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _summonerNameController,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'ReadexPro',
                            fontWeight: FontWeight.bold,
                            // This will make the typed text white
                          ),
                          decoration: InputDecoration(
                            hintText: 'SummonerID',
                            hintStyle: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 14,
                              fontFamily: 'ReadexPro',
                              fontWeight: FontWeight.bold,
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 0),
                              child:
                                  Icon(Icons.search, color: Colors.grey[300]),
                            ),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ), // TextField code here
                    ],
                  ),
                  const SizedBox(height: 0), // Spacing after the input row

                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 10),
                      width: 150,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                        onPressed: _searchSummoner,
                        child: const Text(
                          'Search',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'ReadexPro',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}