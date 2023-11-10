import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/presentation/providers/matchs_providers.dart';

class HomeScreenProPlayers extends StatelessWidget {
  static const name = 'home-screen-pro-players';
  const HomeScreenProPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: HomeScreenProPlayersStateful(), // Utiliza el widget Stateful
    );
  }
}

class HomeScreenProPlayersStateful extends StatefulWidget {
  @override
  _HomeScreenProPlayersState createState() => _HomeScreenProPlayersState();
}

class _HomeScreenProPlayersState extends State<HomeScreenProPlayersStateful> {
  @override
  void initState() {
    super.initState();

    // Puedes realizar operaciones de inicialización aquí si es necesario.
  }

  @override
  Widget build(BuildContext context) {
    final tftMatchRepository = context.read(tftMatchProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen Pro Players'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Realiza las operaciones que necesites con el repositorio
            // Por ejemplo, puedes usar tftMatchRepository para obtener datos de los proplayers.
          },
          child: Text('Fetch Data'),
        ),
      ),
    );
  }
}
