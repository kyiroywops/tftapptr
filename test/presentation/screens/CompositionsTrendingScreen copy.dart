import 'package:flutter/material.dart';

class CompositionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Estilo de texto reutilizable
    TextStyle textStyle(Color color, {double size = 16}) => TextStyle(
          fontFamily: 'ReadexPro',
          fontWeight: FontWeight.bold,
          color: color,
          fontSize: size,
        );

    // Crea un widget para avatar, estrellas y items
    Widget buildAvatarWithNameAndItems(String championName, String assetPath) {
      return Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(assetPath),
            radius: 30,
          ),
          const SizedBox(height: 4), // Espacio entre el avatar y el texto
          Text(
            championName,
            style: textStyle(Colors.white),
          ),
          const SizedBox(height: 4), // Espacio entre el texto y las estrellas
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              3,
              (index) => const Icon(
                Icons.star,
                color: Colors.yellow,
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 10), // Espacio entre las estrellas y los items
          // Fila para items
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              3, // Suponiendo que hay 3 items
              (index) => const Padding(
                padding: EdgeInsets.all(4.0), // Padding agregado aquí
                child: CircleAvatar(
                  radius: 16, // Tamaño de los ítems
                  backgroundImage: AssetImage('assets/tft-item/TFT_Item_MadredsBloodrazor.png'),
                ),
              ),
            ),
          ),
        ],
      );
    }

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 350, // Ajusta la altura según sea necesario
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.85),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'S+',
                        style: textStyle(Colors.red.shade800, size: 48),
                      ),
                      Text('Slow roll', style: textStyle(Colors.white)),
                      Text('Traits', style: textStyle(Colors.white)),
                      Text('No traits', style: textStyle(Colors.white)),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 9, // Número de avatares a mostrar
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: buildAvatarWithNameAndItems(
                        'Campeón $index',
                        'assets/tft-champion/TFT9_Milio.TFT_Set9_Stage2.png',
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
