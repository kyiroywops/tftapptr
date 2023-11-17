import 'package:flutter/material.dart';

class CompositionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trending Compositions',
          style: TextStyle(
            fontFamily: 'ReadexPro',
            fontWeight: FontWeight.bold, // Usa FontWeight para especificar el peso
          ),
        ),
      ),
      body: SingleChildScrollView(
        child:Column(
      children: <Widget>[
      for (int i = 0; i < 10; i++) // Crea 5 filas como ejemplo
        Padding(
          padding: const EdgeInsets.all(8.0), // Espacio entre cada fila
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded( // Expanded hace que el Container se expanda para llenar el espacio disponible en la fila
                child: Container(
                  height: 90, // Altura del contenedor
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8), // Color de fondo gris claro
                    borderRadius: BorderRadius.circular(35), // Bordes redondeados
                  ),
                  child: Center(
                    child: Text(
                      'Composición $i', // Texto dentro del contenedor
                      style: TextStyle(color: Colors.grey[300], fontFamily: 'ReadexPro', fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ],
    )
    
     
      ),
    );
  }
}