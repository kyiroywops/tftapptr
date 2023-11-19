import 'package:flutter/material.dart';

class ChampionUseCases {
  static Color getBorderColor(int value) {
    switch (value) {
      case 1:
        return Colors.grey;
      case 2:
        return Colors.green;
      case 3:
        return Colors.lightBlue;
      case 4:
        return Colors.purple;
      case 5:
        return Colors.orangeAccent;
      default:
        return Colors.transparent; // En caso de no reconocer el valor
    }
  }

  static Color getTierColor(String tier) {
    switch (tier) {
      case 'S+':
        return Colors.red.shade800;
      case 'S':
        return Colors.orange;
      case 'A':
        return const Color.fromARGB(255, 230, 220, 127);
      default:
        return Colors.grey;
    }
  }
}
