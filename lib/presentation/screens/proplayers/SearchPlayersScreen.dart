import 'package:flutter/material.dart';

class SearchPlayersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Jugadores'),
      ),
      body: const Center(
        child: Text('Contenido de Buscar Jugadores aquí'),
      ),
    );
  }
}