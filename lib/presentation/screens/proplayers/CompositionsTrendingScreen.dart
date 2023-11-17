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
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            for (int i = 0; i < 10; i++) // Crea 10 filas como ejemplo
              Padding(
                padding: const EdgeInsets.all(8.0), // Espacio entre cada fila
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // Recorte redondeado para la imagen
                    Expanded(
                      child: Container(
                        height: 190, // Altura del contenedor
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.85), // Color de fondo gris claro
                          borderRadius: BorderRadius.circular(50), // Bordes redondeados
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(9, (index) => const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 1.0), // Espaciado entre los íconos
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/tft-champion/TFT9_Quinn.TFT_Set9.png'),
                              radius: 15, // Tamaño del círculo
                            ),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
