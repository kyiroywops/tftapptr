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
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          'Trending Compositions',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'ReadexPro',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: teamCompsAsyncValue.when(
        data: (teamComps) {
          // Ordena la lista de composiciones antes de construir la lista
          teamComps.sort((a, b) => getTierValue(a.tier).compareTo(getTierValue(b.tier)));
          return buildCompsList(teamComps);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  int getTierValue(String tier) {
    switch (tier) {
      case 'S+':
        return 1;
      case 'S':
        return 2;
      case 'A':
        return 3;
      default:
        return 4;
    }
  }

  Widget buildCompsList(List<TeamComp> teamComps) {
    return SingleChildScrollView(
      child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: teamComps
            .map((teamComp) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0), // Añade espacio entre los contenedores
              child: buildCompContainer(teamComp),
            ))
            .toList(),
      ),
    ),
    );
  }

  Widget buildCompContainer(TeamComp teamComp) {
 
      // Estilo de texto reutilizable
    TextStyle textStyle(Color color, {double size = 15, FontWeight weight = FontWeight.bold}) => TextStyle(
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
            radius: 34.5,
            child: Container(
              width: 63,  // Ajusta el ancho según tus necesidades
              height: 63, // Ajusta el alto según tus necesidades
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(
                  image: AssetImage('assets/tft-champions/${champion.imgChampions}'),
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
          const SizedBox(height: 6), // Espacio entre el texto y las estrellas
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              champion.estrellas,
              (index) => const Icon(
                Icons.star,
                color: Color.fromARGB(255, 180, 180, 2),
                size: 15,
              ),
            ),
          ),
          const SizedBox(height: 6), // Espa
          Row(
            mainAxisSize: MainAxisSize.min,
            children: champion.items.map((item) => Padding(
              padding: EdgeInsets.all(4.0),
              child: CircleAvatar(
                radius: 12,
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
      height: 335, // Ajusta la altura según sea necesario
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.60),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            30, 15, 15, 20), // Añade padding general al contenedor
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alineación a la izquierda
          children: [
            


            const SizedBox(height: 2), // Espacio vertical
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ajusta la alineación según necesites
            children: [
              Text(
                teamComp.tier,
                style: textStyle(
                  ChampionUseCases.getTierColor(teamComp.tier),
                  size: 48,
                ),
              ),
              const SizedBox(width: 120), // Espacio horizontal, ajusta según necesites
              Expanded( // Utiliza Expanded para evitar overflow de texto
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                     teamComp.nombreComp, // El nombre de la composición
                    style: textStyle(Colors.white),
                    textAlign: TextAlign.right, // Alinea el texto a la derecha
                    overflow: TextOverflow.visible, // Asegúrate de que el texto no se corten
                  ),
                ),
              ),
            ],
          ),
 
            const SizedBox(height: 8), // Espacio vertical
            Row(
              children: [
                Text('Traits', style: textStyle(Colors.white)),
                const SizedBox(width: 8),
                Flexible( // Utiliza Flexible en lugar de Expanded
                  child: Container(
                    height: 20, // Define una altura para el Container
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: teamComp.traits.map((trait) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                              child: Container(
                                width: 16,
                                height: 16,
                                child: Image.asset(
                                  'assets/tft-trait/${trait.imgTraits}',
                                  width: 16,
                                  height: 16,
                                 ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: Text(
                                '${trait.valueTraits}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Text(
                              '${trait.nameTraits}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),



            
            const SizedBox(height: 12), // Espacio vertical
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
