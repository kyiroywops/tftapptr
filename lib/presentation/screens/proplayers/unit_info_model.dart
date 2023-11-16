// units_row_widget.dart
import 'package:flutter/material.dart';
import 'package:tftapp/infrastructure/models/unit_info_model.dart';

class UnitsRowWidget extends StatelessWidget {
  final List<UnitInfoModel> units;

  UnitsRowWidget({Key? key, required this.units}) : super(key: key);

  String getImageUrl(String championName) {
    // Reemplaza espacios y caracteres especiales según sea necesario.
    String formattedName = championName.toLowerCase().replaceAll(' ', '').replaceAll('.', '');
    return 'https://raw.communitydragon.org/pbe/game/assets/characters/$formattedName/hud/${formattedName}_circle.png';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // Ajusta según el diseño que desees
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: units.length,
        itemBuilder: (context, index) {
          var unit = units[index];
          var imageUrl = getImageUrl(unit.characterId); // Usa characterId o el campo apropiado para obtener el nombre del campeón
          
          return Container(
            width: 80, // Ajusta según el diseño que desees
            padding: EdgeInsets.all(8), // Añade padding si es necesario
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    imageUrl,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error); // Icono de error si la imagen no se puede cargar
                    },
                  ),
                ),
                Text(unit.name), // Asume que este es el nombre del campeón a mostrar
              ],
            ),
          );
        },
      ),
    );
  }
}
