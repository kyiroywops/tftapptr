// units_row_widget.dart
import 'package:flutter/material.dart';
import 'package:tftapp/infrastructure/models/unit_info_model.dart';

class UnitsRowWidget extends StatelessWidget {
  final List<UnitInfoModel> units;

  UnitsRowWidget({Key? key, required this.units}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // Ajusta según el diseño que desees
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: units.length,
        itemBuilder: (context, index) {
          var unit = units[index];
          // No necesitas imageUrl si solo mostrarás texto.
          
          return Container(
            width: 80, // Ajusta según el diseño que desees
            padding: EdgeInsets.all(8), // Añade padding si es necesario
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centra el texto verticalmente
              children: [
                Text(unit.name, textAlign: TextAlign.center), // Asume que este es el nombre del campeón a mostrar
              ],
            ),
          );
        },
      ),
    );
  }
}
