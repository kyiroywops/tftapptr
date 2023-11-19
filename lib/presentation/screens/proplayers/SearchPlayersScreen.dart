import 'package:flutter/material.dart';

class SearchPlayersScreen extends StatelessWidget {
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
          fontWeight: FontWeight.bold, // Usa FontWeight para especificar el peso
        ),
      ),
      ),
      body: Container(
        color: Colors.grey.shade900, // Fondo blanco para el Container
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              decoration: InputDecoration(
                
                hintText: 'Put the SummonerID here :)',
                hintStyle: TextStyle(color: Colors.grey[300], fontFamily: 'ReadexPro', fontWeight: FontWeight.bold),
                prefixIcon: Icon(Icons.search, color: Colors.grey[300]), // Ícono de lupa dentro del campo
                filled: true,
                fillColor: Colors.black.withOpacity(0.6), // Fondo gris claro para el TextField
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), // Bordes muy redondeados
                  borderSide: BorderSide.none, // Sin borde visible
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
