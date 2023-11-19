import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/domain/usecases/championUseCases.dart';
import 'package:tftapp/infrastructure/models/teamcomp_model.dart';
import 'package:tftapp/presentation/providers/teamcomp_providers.dart';

class CompositionsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamCompsAsyncValue = ref.watch(teamCompsStreamProvider);

    

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
      body: teamCompsAsyncValue.when(
        data: (teamComps) => buildCompsList(teamComps),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget buildCompsList(List<TeamComp> teamComps) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: teamComps
              .map((teamComp) => buildCompContainer(teamComp))
              .toList(),
        ),
      ),
    );
  }

  Widget buildCompContainer(TeamComp teamComp) {
 
      // Estilo de texto reutilizable
    TextStyle textStyle(Color color, {double size = 16, FontWeight weight = FontWeight.bold}) => TextStyle(
          fontFamily: 'ReadexPro',
          fontWeight: weight,
          color: color,
          fontSize: size,
        );



    Widget buildAvatarWithNameAndItems(Champion champion) {
      return Column(
        children: [
          CircleAvatar(
            backgroundColor: ChampionUseCases.getBorderColor(champion.valueChampion),
            radius: 32.5,
            child: Container(
              width: 60,  // Ajusta el ancho según tus necesidades
              height: 60, // Ajusta el alto según tus necesidades
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(
                  image: AssetImage('assets/tft-champion/${champion.imgChampions}'),
                  fit: BoxFit.cover, // Ajusta el ajuste de la imagen según tus necesidades
                  alignment: Alignment(1.0, 0.0), // Mueve la imagen hacia la derecha
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 4),
          Text(
            champion.nombre,  // Nombre del campeón
            style: textStyle(Colors.white),
          ),
          const SizedBox(height: 4), // Espacio entre el texto y las estrellas
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              champion.estrellas,
              (index) => const Icon(
                Icons.star,
                color: Colors.yellow,
                size: 20,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: champion.items.map((item) => Padding(
              padding: EdgeInsets.all(4.0),
              child: CircleAvatar(
                radius: 10,
                backgroundImage: AssetImage('assets/tft-item/${item.imgItem}'),
              ),
            )).toList(),
          ),

          const SizedBox(height: 4), 
          

        
        ],
      );
    }
    // Por ejemplo, puedes usar teamComp.nombreComp, teamComp.tier, etc.
    return Container(
      // Contenedor composiciones
      height: 375, // Ajusta la altura según sea necesario
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.89),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            25, 15, 15, 15), // Añade padding general al contenedor
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alineación a la izquierda
          children: [
            Text(
              teamComp.tier,
              style: textStyle(Colors.red.shade800, size: 48),
            ),
            const SizedBox(height: 8), // Espacio vertical
            Text(teamComp.nombreComp, style: textStyle(Colors.white)),
            Text('Slow roll', style: textStyle(Colors.white)),
            Text('Traits', style: textStyle(Colors.white)),
            Text('No traits', style: textStyle(Colors.white)),
            const SizedBox(height: 16), // Espacio vertical
            Expanded(
              child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: teamComp.champions.length,  // Usa la longitud de la lista de campeones
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                child: buildAvatarWithNameAndItems(teamComp.champions[index]),  // Usa el campeón en la posición actual
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
