import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/presentation/providers/teamcomp_providers.dart';

class CompositionsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtienes la instancia del repositorio usando el Provider
    final teamCompRepository = ref.read(teamCompRepositoryProvider);

    // Obtienes los datos de Firestore
    final teamCompsAsyncValue = ref.watch(teamCompsStreamProvider);

    // Estilo de texto reutilizable
    TextStyle textStyle(Color color, {double size = 16, FontWeight weight = FontWeight.bold}) => TextStyle(
          fontFamily: 'ReadexPro',
          fontWeight: weight,
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
          const SizedBox(height: 4), // Espacio entre las estrellas y los items
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              3, // Suponiendo que hay 3 items
              (index) => const Padding(
                padding: EdgeInsets.all(4.0),
                child: CircleAvatar(
                  radius: 10, // Tamaño de los ítems
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
          child: Container( // Contenedor composiciones
            height: 370, // Ajusta la altura según sea necesario
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.89),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 15, 15, 15), // Añade padding general al contenedor
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Alineación a la izquierda
                children: [
                  Text(
                    'S+',
                    style: textStyle(Colors.red.shade800, size: 48),
                  ),
                  const SizedBox(height: 8), // Espacio vertical
                  Text('Freljord Vanquishers', style: textStyle(Colors.white)),
                  Text('Slow roll', style: textStyle(Colors.white)),
                  Text('Traits', style: textStyle(Colors.white)),
                  Text('No traits', style: textStyle(Colors.white)),
                  const SizedBox(height: 16), // Espacio vertical
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 9, // Número de avatares a mostrar
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
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
      ),
    );
  }
}
