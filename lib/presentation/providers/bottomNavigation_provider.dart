import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationNotifier extends StateNotifier<int> {
  BottomNavigationNotifier() : super(0); // Comienza en el índice 0

  void selectTab(int index) {
    state = index; // Actualiza el estado al nuevo índice
  }
}

// prov
final bottomNavigationProvider = StateNotifierProvider<BottomNavigationNotifier, int>((ref) {
  return BottomNavigationNotifier();
});
